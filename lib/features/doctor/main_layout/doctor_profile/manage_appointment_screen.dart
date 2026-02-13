import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care_project/shared/component/customAppbarButton/custom_app_bar_button.dart';

class ManageAppointmentsScreen extends StatefulWidget {
  static const String routeName = "ManageAppointmentsScreen";
  const ManageAppointmentsScreen({super.key});

  @override
  State<ManageAppointmentsScreen> createState() => _ManageAppointmentsScreenState();
}

class _ManageAppointmentsScreenState extends State<ManageAppointmentsScreen> {
  final List<String> weekDays = [
    'السبت', 'الأحد', 'الاثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة'
  ];

  final Set<String> selectedDays = {};

  final Map<String, List<int>> dayShifts = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0,
        actions: [
          CustomAppBarBtn()
        ],
        title: Text(
          "إدارة المواعيد المتاحة",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),

      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.transparent)),
        ),
        child: ElevatedButton(
          onPressed: () {

          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff2B73F3),
            minimumSize: Size(double.infinity, 52.h),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.save_outlined, color: Colors.white),
              SizedBox(width: 10.w),
              Text(
                "حفظ التعديلات",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.white),
              ),
            ],
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 40.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("اختيار ايام العمل", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 24.h),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
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
              Text("فترات العمل اليومية", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
              SizedBox(height: 24.h),
              ...selectedDays.map((day) => _buildDayShiftCard(day)),

              SizedBox(height: 40.h),

              Text("ملخص الجدول الحالي",
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 24.h),
              ...selectedDays.map((day) => _buildSummaryCard(day)).toList(),

            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDayItem(String day, bool isSelected) {
    return InkWell(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedDays.remove(day);
          } else {
            selectedDays.add(day);
          }
        });
      },
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        width: 167.5.w,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 13.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xff2B73F3) : Colors.white,
          border: Border.all(color: isSelected ? const Color(0xff2B73F3) : Colors.grey.shade200),
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
                  ? Icon(Icons.check, size: 16.sp, color: const Color(0xff2B73F3))
                  : null,
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildDayShiftCard(String dayName) {
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
              Text(dayName, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
              InkWell(
                onTap: () {
                  setState(() {
                    dayShifts[dayName] ??= [];
                    dayShifts[dayName]!.add(dayShifts[dayName]!.length + 1);
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
                      Text("إضافة فترة",
                          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              )
            ],
          ),

          SizedBox(height: 16.h),

          Column(
            children:(dayShifts[dayName] ?? [])
                .map((id) => Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: _buildTimeRow(dayName, id),
            ))
                .toList(),

          )
        ],
      ),
    );
  }

  Widget _buildTimeRow(String dayName, int id) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xffF1F5FE),
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: const Color(0xffB7CFFB)),
      ),
      child: Row(
        children: [
          Expanded(child: _buildTimePickerBox("من", "09:00 ص")),
          SizedBox(width: 8.w),
          Expanded(child: _buildTimePickerBox("إلى", "13:00 م")),
          SizedBox(width: 18.w),
          InkWell(
            onTap: () {
              setState(() {
                dayShifts[dayName]?.remove(id);
              });
            },
            child: Icon(Icons.delete_outline, color: Colors.red, size: 20.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildTimePickerBox(String label, String time) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.keyboard_arrow_down, size: 18.sp, color: Colors.grey),
          Text(time, style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600)),
          Text(label, style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String dayName) {
    final shifts = dayShifts[dayName] ?? [];
    return Container(
      margin: EdgeInsets.only(bottom: 24.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Color(0xffEFF6FF),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Color(0xffBEDBFF)),
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
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 8.h),

                ...shifts.map(
                      (_) => Text(
                    "09:00 - 13:00",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ),

          Icon(Icons.access_time, color: Color(0xff2B7FFF)),

        ],
      ),
    );
  }

}