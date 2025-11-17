import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppointmentTimeScreen extends StatefulWidget {
  static const String routeName = "AppointmentTimeScreen";
  const AppointmentTimeScreen({super.key});

  @override
  State<AppointmentTimeScreen> createState() => _AppointmentTimeScreenState();
}

class _AppointmentTimeScreenState extends State<AppointmentTimeScreen> {
  int? _selectedDayIndex;
  int? _selectedTimeIndex;


  Widget _buildDayCard(String day, String date, int index) {
    bool isSelected = _selectedDayIndex == index;
    Color primaryColor = const Color(0xff2B73F3);

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDayIndex = index;
          _selectedTimeIndex = null;
        });
      },
      child: Container(
        width: 72.w,
        margin: EdgeInsets.only(left:12.w),
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? primaryColor : Colors.grey.shade200,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              day,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              date,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeChip(String time, int index) {
    bool isSelected = _selectedTimeIndex == index;
    Color primaryColor = const Color(0xff2B73F3);

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTimeIndex = index;
        });
      },
      child: Container(
        margin: EdgeInsets.only(left: 12.w, bottom: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? primaryColor : Colors.grey.shade200,
            width: 1,
          ),
        ),
        child: Text(
          time,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> days = [
      {"day": "Wed", "date": "10"},
      {"day": "Thu", "date": "11"},
      {"day": "Fri", "date": "12"},
      {"day": "Sat", "date": "13"},
      {"day": "Sun", "date": "30"},
      {"day": "Mon", "date": "21"},


    ];

    final List<String> morningTimes = ["9:30", "10:00", "10:30", "11:00"];
    final List<String> eveningTimes = ["01:00", "01:30", "02:00", "06:00"];
    const Color primaryColor = Color(0xff4786F5);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "حجز موعد",
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,


        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
          alignment: Alignment.topLeft,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "اختر معاد الكشف",
                  style: TextStyle(fontSize:20.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height:8.h ,),
                Text(
                  "تستطيع أن تحدد تاريخ اليوم المناسب لك والساعة المناسبة في هذا اليوم",
                  style: TextStyle(fontSize:12.sp, color: Colors.grey),
                ),
                SizedBox(height: 20.h),
                Text(
                  "اختار يوم من شهر 10 - 2025",
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 12.h),
                SizedBox(
                  height: 90.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    itemCount: days.length,
                    itemBuilder: (context, index) {
                      return _buildDayCard(days[index]['day']!, days[index]['date']!, index);
                    },
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  "مواعيد الصباح",
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12.h),
                Wrap(
                  alignment: WrapAlignment.end,
                  runSpacing: 0,
                  spacing: 0,
                  children: List.generate(morningTimes.length, (index) {
                    return _buildTimeChip(morningTimes[index], index);
                  }),
                ),
                SizedBox(height: 20.h),
                Text(
                  "مواعيد المساء",
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12.h),
                Wrap(
                  alignment: WrapAlignment.end,
                  runSpacing: 0,
                  spacing: 0,
                  children: List.generate(eveningTimes.length, (index) {
                    return _buildTimeChip(eveningTimes[index], index + morningTimes.length);
                  }),
                ),

                SizedBox(height:280.h),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
              ),
              child: ElevatedButton(
                onPressed: _selectedDayIndex != null && _selectedTimeIndex != null
                    ? () {

                }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  disabledBackgroundColor: Colors.grey,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
                  padding: EdgeInsets.symmetric(vertical: 13.5.h),
                ),
                child: Text("تأكيد الحجز", style: TextStyle(fontSize: 14.sp, color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}