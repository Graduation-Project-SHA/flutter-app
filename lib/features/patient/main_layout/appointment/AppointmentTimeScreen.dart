import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care_project/features/patient/main_layout/appointment/patient_appointment_cubit/patient_appointment_cubit.dart';
import 'package:health_care_project/features/patient/main_layout/appointment/patient_appointment_cubit/patient_appointment_states.dart';
import 'package:health_care_project/shared/component/customAppbarButton/custom_app_bar_button.dart';
import 'package:intl/intl.dart';
import 'Payment.dart';

class AppointmentTimeScreen extends StatefulWidget {
  static const String routeName = "AppointmentTimeScreen";
  final dynamic doctor;

  const AppointmentTimeScreen({super.key, required this.doctor});

  @override
  State<AppointmentTimeScreen> createState() => _AppointmentTimeScreenState();
}

class _AppointmentTimeScreenState extends State<AppointmentTimeScreen> {
  int? _selectedDayIndex;
  int? _selectedTimeIndex;
  int? _selectedServiceId;
  List<Map<String, String>> autoDays = [];

  @override
  void initState() {
    super.initState();
    _generateNextSevenDays();
    if (widget.doctor['services'] != null && (widget.doctor['services'] as List).isNotEmpty) {
      _selectedServiceId = widget.doctor['services'][0]['id'];
    }
  }

  void _generateNextSevenDays() {
    DateTime now = DateTime.now();
    for (int i = 0; i < 7; i++) {
      DateTime date = now.add(Duration(days: i));
      autoDays.add({
        "day": DateFormat('E', 'en').format(date),
        "date": date.day.toString(),
        "fullDate": DateFormat('yyyy-MM-dd').format(date),
      });
    }
  }

  void _fetchSlots(BuildContext context) {
    if (_selectedDayIndex != null && _selectedServiceId != null) {
      context.read<AppointmentCubit>().getAvailableSlots(
        userId: widget.doctor['userId'].toString(),
        date: autoDays[_selectedDayIndex!]['fullDate']!,
        serviceId: _selectedServiceId!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xff4786F5);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("حجز موعد", style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold,color: Colors.black)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          CustomAppBarBtn(),

        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocBuilder<AppointmentCubit, AppointmentState>(
        builder: (context, state) {
          List<String> displaySlots = (state is AppointmentSlotsLoaded) ? state.slots : [];

          return SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("اختر معاد الكشف", style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
                SizedBox(height: 8.h),
                Text("تستطيع أن تحدد نوع الخدمة والتاريخ والساعة المناسبة لك",
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey)),

                SizedBox(height: 20.h),
                Text("أختار الخدمة", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
                SizedBox(height: 10.h),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                      value: _selectedServiceId,
                      isExpanded: true,
                      hint: const Text("اختر نوع الخدمة"),
                      items: (widget.doctor['services'] as List).map((service) {
                        return DropdownMenuItem<int>(
                          value: service['id'],
                          child: Text("${service['name']} (${service['price']} جنيه)"),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          _selectedServiceId = val;
                          _selectedTimeIndex = null;
                          _fetchSlots(context);
                        });
                      },
                    ),
                  ),
                ),

                SizedBox(height: 24.h),
                Text("اختار يوم من شهر ${DateFormat('MM - yyyy').format(DateTime.now())}",
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
                SizedBox(height: 12.h),

                SizedBox(
                  height: 90.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    itemCount: autoDays.length,
                    itemBuilder: (ctx, index) => _buildDayCard(
                      autoDays[index]['day']!,
                      autoDays[index]['date']!,
                      index,
                    ),
                  ),
                ),

                SizedBox(height: 30.h),
                Text("المواعيد المتاحة", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                SizedBox(height: 12.h),

                if (state is AppointmentLoading)
                  const Center(child: CircularProgressIndicator())
                else if (displaySlots.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTimeSection("مواعيد الصباح", displaySlots, true),
                      SizedBox(height: 20.h),
                      _buildTimeSection("مواعيد المساء", displaySlots, false),
                    ],
                  )
                else
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: Text(_selectedDayIndex == null ? "برجاء اختيار يوم أولاً" : "لا توجد مواعيد متاحة لهذه الخدمة اليوم",
                          style: TextStyle(color: Colors.grey, fontSize: 14.sp)),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<AppointmentCubit, AppointmentState>(
        builder: (context, state) {
          bool canBook = _selectedDayIndex != null && _selectedTimeIndex != null && state is AppointmentSlotsLoaded;

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: const BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)]),
            child: SafeArea(
              child: ElevatedButton(
                onPressed: canBook ? () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => Payment(
                    doctorProfileId: widget.doctor['id'],
                    serviceId: _selectedServiceId!,
                    appointmentDate: autoDays[_selectedDayIndex!]['fullDate']!,
                    startTime: (state as AppointmentSlotsLoaded).slots[_selectedTimeIndex!],
                  )));
                } : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  disabledBackgroundColor: Colors.grey,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
                  padding: EdgeInsets.symmetric(vertical: 13.5.h),
                ),
                child: Text("تأكيد الحجز", style: TextStyle(fontSize: 14.sp, color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDayCard(String day, String date, int index) {
    bool isSelected = _selectedDayIndex == index;
    Color primaryColor = const Color(0xff2B73F3);

    return GestureDetector(
      onTap: () {
        if (_selectedServiceId == null) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("برجاء اختيار الخدمة أولاً")));
          return;
        }
        setState(() { _selectedDayIndex = index; _selectedTimeIndex = null; });
        _fetchSlots(context);
      },
      child: Container(
        width: 72.w,
        margin: EdgeInsets.only(left: 12.w),
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: isSelected ? primaryColor : Colors.grey.shade200),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(day, style: TextStyle(fontSize: 12.sp, color: isSelected ? Colors.white : Colors.black)),
            SizedBox(height: 4.h),
            Text(date, style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: isSelected ? Colors.white : Colors.black)),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSection(String title, List<String> slots, bool isMorning) {
    var filteredSlots = slots.where((s) {
      int hour = int.parse(s.split(':')[0]);
      return isMorning ? hour < 12 : hour >= 12;
    }).toList();

    if (filteredSlots.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
        SizedBox(height: 12.h),
        Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: filteredSlots.map((time) {
            int globalIndex = slots.indexOf(time);
            return _buildTimeChip(time, globalIndex);
          }).toList(),
        ),
      ],
    );
  }


  Widget _buildTimeChip(String time, int index) {
    bool isSelected = _selectedTimeIndex == index;
    Color primaryColor = const Color(0xff2B73F3);

    return GestureDetector(
      onTap: () => setState(() => _selectedTimeIndex = index),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: isSelected ? primaryColor : Colors.grey.shade200),
        ),
        child: Text(time, style: TextStyle(fontSize: 12.sp, color: isSelected ? Colors.white : Colors.black)),
      ),
    );
  }
}