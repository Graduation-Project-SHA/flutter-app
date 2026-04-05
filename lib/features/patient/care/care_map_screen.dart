import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'nurses_list_screen.dart';

class CareMapScreen extends StatefulWidget {
  static const routeName = "CareMapScreen";

  @override
  State<CareMapScreen> createState() => _CareMapScreenState();
}

class _CareMapScreenState extends State<CareMapScreen> {
  bool isRepeated = true;
  String selectedHours = "4";
  String selectedDays = "14";

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  String location = "15 شارع عباس العقاد";



  Future<void> pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> pickTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  bool isFormValid() {
    return selectedDate != null && selectedTime != null;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "رعاية منزلية",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18.sp),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromRGBO(205, 205, 205, 1)),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_forward_ios, size: 18.sp),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("الموقع"),
            SizedBox(height: 24.w),
            Row(
              children: [
                Expanded(
                  child: _buildSimpleBox(location, isHint: false),
                ),
                SizedBox(width: 8.w),
                _buildBlueIconBox(Icons.location_on_outlined),
              ],
            ),
            SizedBox(height: 24.h),
            Container(
              height: 120.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: Colors.grey.shade200,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.asset("assets/images/Maps.png",
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 24.h),


            Container(
              height: 47.h,
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(7.r)),
              child: Row(
                children: [
                  _buildToggleBtn("زيارة متكررة", isRepeated,
                          () => setState(() => isRepeated = true)),
                  _buildToggleBtn("زيارة واحدة", !isRepeated,
                          () => setState(() => isRepeated = false)),
                ],
              ),
            ),

            SizedBox(height: 34.h),


            _buildSectionTitle("عدد الساعات"),
            Row(
              children: [
                _buildSelectCard(
                    "4\nساعات",
                    selectedHours == "4",
                        () => setState(() => selectedHours = "4")),
                SizedBox(width: 12.w),
                _buildSelectCard(
                    "8\nساعات",
                    selectedHours == "8",
                        () => setState(() => selectedHours = "8")),
              ],
            ),

            SizedBox(height: 32.h),

            _buildSectionTitle("التاريخ"),
            GestureDetector(
              onTap: pickDate,
              child: _buildSimpleBox(
                selectedDate == null
                    ? "dd/mm/yyyy"
                    : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                isHint: selectedDate == null,
              ),
            ),

            SizedBox(height: 32.h),


            _buildSectionTitle("وقت البداية"),
            GestureDetector(
              onTap: pickTime,
              child: _buildSimpleBox(
                selectedTime == null
                    ? "09:00 AM"
                    : selectedTime!.format(context),
                isHint: selectedTime == null,
              ),
            ),


            if (isRepeated) ...[
              SizedBox(height: 32.h),
              _buildSectionTitle("مدة العقد"),
              Container(
                height: 51.h,
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8.r)),
                child: Row(
                  children: [
                    _buildToggleBtn("أيام", true, () {}),
                    _buildToggleBtn("أشهر", false, () {}),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  _buildSelectCard(
                      "14\nيوم",
                      selectedDays == "14",
                          () => setState(() => selectedDays = "14")),
                  SizedBox(width: 12.w),
                  _buildSelectCard(
                      "7\nأيام",
                      selectedDays == "7",
                          () => setState(() => selectedDays = "7")),
                ],
              ),
            ],

            SizedBox(height: 24.h),

            _buildMainBtn(
              "التالي",
              isFormValid()
                  ? () {
                 Navigator.pushNamed(context, NursesListScreen.routeName);

                print("Location: $location");
                print("Repeated: $isRepeated");
                print("Hours: $selectedHours");
                print("Date: $selectedDate");
                print("Time: $selectedTime");
                print("Days: $selectedDays");
              }
                  : null,
              isEnabled: isFormValid(),
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }


  Widget _buildSectionTitle(String title) => Padding(
    padding: EdgeInsets.only(bottom: 8.h),
    child: Text(title,
        style:
        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
  );

  Widget _buildToggleBtn(
      String title, bool active, VoidCallback onTap) =>
      Expanded(
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: active ? Color(0xFF247CFF) : Colors.transparent,
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Text(title,
                style: TextStyle(
                    color: active ? Colors.white : Colors.grey,
                    fontSize: 13.sp)),
          ),
        ),
      );

  Widget _buildSelectCard(
      String title, bool active, VoidCallback onTap) =>
      Expanded(
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            height: 70.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: active ? Color(0xFF247CFF) : Colors.white,
              border: Border.all(
                  color:
                  active ? Color(0xFF247CFF) : Colors.grey.shade200),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: active ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold)),
          ),
        ),
      );

  Widget _buildSimpleBox(String text, {bool isHint = false}) =>
      Container(
        height: 45.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(8.r)),
        alignment: Alignment.centerRight,
        child: Text(text,
            style: TextStyle(
                color: isHint ? Colors.grey : Colors.black,
                fontSize: 13.sp)),
      );

  Widget _buildBlueIconBox(IconData icon) => Container(
    height: 45.h,
    width: 45.w,
    decoration: BoxDecoration(
        color: Color(0xFF247CFF),
        borderRadius: BorderRadius.circular(8.r)),
    child: Icon(icon, color: Colors.white),
  );

  Widget _buildMainBtn(
      String title, VoidCallback? onTap,
      {bool isEnabled = true}) =>
      SizedBox(
        width: double.infinity,
        height: 50.h,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:
            isEnabled ? Color(0xFF247CFF) : Colors.grey,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r)),
          ),
          onPressed: onTap,
          child: Text(title,
              style:
              TextStyle(color: Colors.white, fontSize: 16.sp)),
        ),
      );
}