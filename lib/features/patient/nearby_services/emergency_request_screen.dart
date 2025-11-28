import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care_project/features/patient/nearby_services/wating_emergency_screen.dart';

class EmergencyRequestScreen extends StatelessWidget {
  static const String routeName = "EmergencyRequestScreen";

  const EmergencyRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "طلب سيارة اسعاف",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        automaticallyImplyLeading: false,
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
        padding: EdgeInsets.symmetric(horizontal: 27.w, vertical: 24.h),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: Color(0xffE7000B),
                            size: 30.sp,
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            "تفعيل الطواري",
                            style: TextStyle(
                              color: Color(0xffE7000B),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Colors.red,
                            size: 18.sp,
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            "موقعك الحالي:",
                            style: TextStyle(
                              color: Color(0xff4A5565),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "تعديل",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Icon(
                            Icons.edit,
                            color: Color(0xffE7000B),
                            size: 20.sp,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "طريق الشباب، مدينة الشروق، القاهرة - مصر",
                    style: TextStyle(fontSize: 16.sp, color: Color(0xff4A5565)),
                  ),
                ],
              ),
            ),

            SizedBox(height: 40.h),

            Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: Color(0xff2B73F3),
                        size: 20.sp,
                      ),
                      SizedBox(width: 14.w),
                      Text(
                        "لأهمية الوقت",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 21.5.h),
                  Divider(color: Color(0xffDCDCDC)),
                  SizedBox(height: 16.h),
                  _inputTitle("الأمراض المزمنة"),
                  SizedBox(height: 8.h),
                  _textField("هل يعاني من السكري، القلب، أو الضغط؟"),

                  SizedBox(height: 16.h),

                  _inputTitle("الأعراض الحالية"),
                  SizedBox(height: 8.h),
                  _textField("هل يتنفس؟ هل يتألم؟ هل يتقيأ؟"),

                  SizedBox(height: 16.h),

                  _inputTitle(" البيانات الشخصية"),
                  SizedBox(height: 8.h),
                  _textField(
                    "اسم المريض، عمره، وهل لديه حساسية من أدوية معينة؟",
                  ),

                  SizedBox(height: 16.h),

                  _inputTitle("هل يتناول ادوية بإنتظام ؟"),
                  SizedBox(height: 8.h),
                  _textField("جهز هذه الأدوية أو قائمة بها"),

                  SizedBox(height: 16.h),

                  _inputTitle("ماذا حدث؟"),
                  SizedBox(height: 8.h),
                  _textField("متى وكيف بدأت الأعراض؟ هل سقط؟ هل فقد الوعي؟"),
                  SizedBox(height: 24.h),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return WaitingEmergencyScreen();
                            },
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffE7000B),
                        padding: EdgeInsets.symmetric(vertical: 13.5.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.phone_outlined,
                            size: 15.sp,
                            color: Colors.white,
                          ),
                          SizedBox(width: 9.w),
                          Text(
                            "تاكيد الاتصال",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      textAlign: TextAlign.right,
    );
  }

  Widget _textField(String hint) {
    return TextField(
      maxLines: null,
      keyboardType: TextInputType.multiline,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(fontSize: 12.sp, color: Color(0xff939393)),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: Color(0xffDCDCDC)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: Color(0xffDCDCDC)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: Color(0xffDCDCDC)),
        ),
      ),
    );
  }
}