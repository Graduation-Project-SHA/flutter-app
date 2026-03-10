import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care_project/shared/component/customAppbarButton/custom_app_bar_button.dart';

import '../../../../core/network/network_checker.dart';
import '../../availabilities/availability_cubit.dart';
import '../../availabilities/availability_state.dart';

class ManageAppointmentsScreen extends StatefulWidget {
  static const String routeName = "ManageAppointmentsScreen";

  const ManageAppointmentsScreen({super.key});

  @override
  State<ManageAppointmentsScreen> createState() =>
      _ManageAppointmentsScreenState();
}

class _ManageAppointmentsScreenState extends State<ManageAppointmentsScreen> {
  final List<String> weekDays = [
    'السبت',
    'الأحد',
    'الاثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
    'الجمعة',
  ];

  final Map<String, String> daysMap = {
    'السبت': 'SATURDAY',
    'الأحد': 'SUNDAY',
    'الاثنين': 'MONDAY',
    'الثلاثاء': 'TUESDAY',
    'الأربعاء': 'WEDNESDAY',
    'الخميس': 'THURSDAY',
    'الجمعة': 'FRIDAY',
  };

  final Map<String, String> reverseDaysMap = {
    'SATURDAY': 'السبت',
    'SUNDAY': 'الأحد',
    'MONDAY': 'الاثنين',
    'TUESDAY': 'الثلاثاء',
    'WEDNESDAY': 'الأربعاء',
    'THURSDAY': 'الخميس',
    'FRIDAY': 'الجمعة',
  };

  final Set<String> selectedDays = {};
  final Map<String, List<Map<String, String>>> dayShifts = {};

  bool _isInitializedFromApi = false;
  bool _isSaving = false;
  bool _isStartBeforeEnd(String start, String end) {
    final startParts = start.split(':');
    final endParts = end.split(':');

    final startHour = int.parse(startParts[0]);
    final startMinute = int.parse(startParts[1]);

    final endHour = int.parse(endParts[0]);
    final endMinute = int.parse(endParts[1]);

    final startTotal = startHour * 60 + startMinute;
    final endTotal = endHour * 60 + endMinute;

    return startTotal < endTotal;
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AvailabilityCubit.get(context).getAvailabilities();
    });
  }

  void _fillDataFromApi(AvailabilityCubit cubit) {
    if (_isInitializedFromApi) return;

    selectedDays.clear();
    dayShifts.clear();

    for (final item in cubit.availabilities) {
      final arabicDay = reverseDaysMap[item.day] ?? item.day;

      selectedDays.add(arabicDay);
      dayShifts[arabicDay] ??= [];
      dayShifts[arabicDay]!.add({
        "id": item.id,
        "start": item.startTime,
        "end": item.endTime,
      });
    }

    _isInitializedFromApi = true;
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }

  Future<void> _pickTime({
    required Map<String, String> shift,
    required String keyName,
  }) async {
    final currentValue = shift[keyName] ?? "09:00";
    final parts = currentValue.split(':');
    final initialHour = int.tryParse(parts[0]) ?? 9;
    final initialMinute = int.tryParse(parts[1]) ?? 0;

    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: initialHour, minute: initialMinute),
    );

    if (picked != null) {
      setState(() {
        shift[keyName] = _formatTimeOfDay(picked);
      });
    }
  }

  bool _validateShifts() {
    if (selectedDays.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("من فضلك اختاري يوم عمل واحد على الأقل"),
          backgroundColor: Colors.redAccent,
        ),
      );
      return false;
    }

    for (final day in selectedDays) {
      final shifts = dayShifts[day] ?? [];

      if (shifts.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("من فضلك أضيفي فترة عمل ليوم $day"),
            backgroundColor: Colors.redAccent,
          ),
        );
        return false;
      }

      for (final shift in shifts) {
        final start = shift["start"];
        final end = shift["end"];

        if (start == null || end == null || start.isEmpty || end.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("من فضلك حددي الوقت ليوم $day"),
              backgroundColor: Colors.redAccent,
            ),
          );
          return false;
        }

        if (start == end) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("وقت البداية ووقت النهاية لا يمكن أن يكونا متساويين في $day"),
              backgroundColor: Colors.redAccent,
            ),
          );
          return false;
        }

        if (!_isStartBeforeEnd(start, end)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("وقت البداية لازم يكون قبل وقت النهاية في $day"),
              backgroundColor: Colors.redAccent,
            ),
          );
          return false;
        }
      }
    }

    return true;
  }

  Future<void> _saveAvailabilities() async {
    final cubit = AvailabilityCubit.get(context);

    final hasInternet = await NetworkChecker.hasInternet();
    if (!hasInternet) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("لا يوجد اتصال بالإنترنت"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (!_validateShifts()) return;

    setState(() {
      _isSaving = true;
    });

    bool hasError = false;

    try {

      for (final item in cubit.availabilities) {
        final deleted =
        await cubit.deleteAvailability(item.id, refreshAfterDelete: false);

        if (!deleted) {
          hasError = true;
          break;
        }
      }

      if (!hasError) {
        for (final day in selectedDays) {
          final shifts = dayShifts[day] ?? [];

          for (final shift in shifts) {
            final created = await cubit.createAvailability(
              day: daysMap[day]!,
              startTime: shift["start"]!,
              endTime: shift["end"]!,
              refreshAfterCreate: false,
            );

            if (!created) {
              hasError = true;
              break;
            }
          }

          if (hasError) break;
        }
      }

      if (hasError) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("فشل حفظ بعض المواعيد، راجعي البيانات وحاول مرة أخرى"),
            backgroundColor: Colors.redAccent,
          ),
        );
        return;
      }

      _isInitializedFromApi = false;
      await cubit.getAvailabilities();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("تم حفظ المواعيد بنجاح"),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      print("SAVE AVAILABILITY ERROR: $e");

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("حدث خطأ أثناء حفظ المواعيد"),
          backgroundColor: Colors.redAccent,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AvailabilityCubit, AvailabilityState>(
      listener: (context, state) {
        if (state is AvailabilityError) {
          print("Availability Error: ${state.error}");
        }
      },
      builder: (context, state) {
        final cubit = AvailabilityCubit.get(context);

        if (state is AvailabilityLoaded) {
          _fillDataFromApi(cubit);
        }

        final isLoading = state is AvailabilityLoading && !_isInitializedFromApi;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            centerTitle: false,
            elevation: 0,
            actions: [
              CustomAppBarBtn(),
            ],
            title: Text(
              "إدارة المواعيد المتاحة",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.all(20.w),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.transparent),
              ),
            ),
            child: ElevatedButton(
              onPressed: _isSaving || isLoading ? null : _saveAvailabilities,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff2B73F3),
                minimumSize: Size(double.infinity, 52.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              child: _isSaving
                  ? SizedBox(
                width: 22.w,
                height: 22.h,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.save_outlined, color: Colors.white),
                  SizedBox(width: 10.w),
                  Text(
                    "حفظ التعديلات",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: isLoading
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 40.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "اختيار ايام العمل",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 24.h),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: weekDays.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8.h,
                    crossAxisSpacing: 8.w,
                    childAspectRatio: 167.5 / 50,
                  ),
                  itemBuilder: (context, index) {
                    final day = weekDays[index];
                    final isSelected = selectedDays.contains(day);
                    return _buildDayItem(day, isSelected);
                  },
                ),
                SizedBox(height: 40.h),
                if (selectedDays.isNotEmpty) ...[
                  Text(
                    "فترات العمل اليومية",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  ...selectedDays.map((day) => _buildDayShiftCard(day)),
                  SizedBox(height: 40.h),
                  Text(
                    "ملخص الجدول الحالي",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  ...selectedDays.map((day) => _buildSummaryCard(day)).toList(),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDayItem(String day, bool isSelected) {
    return InkWell(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedDays.remove(day);
            dayShifts.remove(day);
          } else {
            selectedDays.add(day);
            dayShifts[day] ??= [];
          }
        });
      },
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        width: 167.5.w,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 13.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xff2B73F3) : Colors.white,
          border: Border.all(
            color: isSelected
                ? const Color(0xff2B73F3)
                : Colors.grey.shade200,
          ),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              day,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
            Container(
              width: 16.w,
              height: 16.h,
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: isSelected
                  ? Icon(
                Icons.check,
                size: 16.sp,
                color: const Color(0xff2B73F3),
              )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayShiftCard(String dayName) {
    final shifts = dayShifts[dayName] ?? [];

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                dayName,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    dayShifts[dayName] ??= [];
                    dayShifts[dayName]!.add({
                      "id": "",
                      "start": "09:00",
                      "end": "13:00",
                    });
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.add, size: 16.sp, color: Colors.black),
                      SizedBox(width: 4.w),
                      Text(
                        "إضافة فترة",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Column(
            children: shifts
                .map(
                  (shift) => Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: _buildTimeRow(dayName, shift),
              ),
            )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeRow(String dayName, Map<String, String> shift) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xffF1F5FE),
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: const Color(0xffB7CFFB)),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildTimePickerBox(
              "من",
              shift["start"] ?? "09:00",
                  () => _pickTime(shift: shift, keyName: "start"),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: _buildTimePickerBox(
              "إلى",
              shift["end"] ?? "13:00",
                  () => _pickTime(shift: shift, keyName: "end"),
            ),
          ),
          SizedBox(width: 18.w),
          InkWell(
            onTap: () {
              setState(() {
                dayShifts[dayName]?.remove(shift);
                if ((dayShifts[dayName] ?? []).isEmpty) {
                  dayShifts[dayName] = [];
                }
              });
            },
            child: Icon(
              Icons.delete_outline,
              color: Colors.red,
              size: 20.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimePickerBox(
      String label,
      String time,
      VoidCallback onTap,
      ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.keyboard_arrow_down,
              size: 18.sp,
              color: Colors.grey,
            ),
            Text(
              time,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String dayName) {
    final shifts = dayShifts[dayName] ?? [];

    return Container(
      margin: EdgeInsets.only(bottom: 24.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xffEFF6FF),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xffBEDBFF)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dayName,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                ...shifts.map(
                      (shift) => Text(
                    "${shift["start"]} - ${shift["end"]}",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.access_time,
            color: Color(0xff2B7FFF),
          ),
        ],
      ),
    );
  }
}