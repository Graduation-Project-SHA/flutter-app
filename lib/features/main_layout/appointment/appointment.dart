import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care_project/shared/component/defaultbutton/defaultbutton.dart';

class Appointment extends StatefulWidget {
  const Appointment({super.key});

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
   bool isClicked1 = true;  
  bool isClicked2 = false; 

  Color button_color1 = Colors.blue;
  Color border_color1 = Color.fromRGBO(43, 115, 243, 1);
  Color button_text_color1 = Colors.white;

  Color button_color2 = Colors.white;
  Color border_color2 = Color.fromRGBO(205, 205, 205, 1);
  Color button_text_color2 = Color.fromRGBO(43, 115, 243, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, 10.h),
          child: Container(
            color: Color.fromRGBO(237, 237, 237, 1),
            height: 2.h,
          ),
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'مواعيدي',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
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

      body: Column(
        children: [
          SizedBox(height: 24.h),

          Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isClicked1 = true;
                  isClicked2 = false;

                  button_color1 = Colors.blue;
                  border_color1 = Color.fromRGBO(43, 115, 243, 1);
                  button_text_color1 = Colors.white;

                  button_color2 = Colors.white;
                  border_color2 = Color.fromRGBO(205, 205, 205, 1);
                  button_text_color2 = Color.fromRGBO(43, 115, 243, 1);
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 18.r, vertical: 8.r),
                decoration: BoxDecoration(
                  color: button_color1,
                  border: Border.all(color: border_color1),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8.r),
                    bottomRight: Radius.circular(8.r),
                  ),
                ),
                child: Text(
                  'مواعيد سابقة',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: button_text_color1,
                  ),
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                setState(() {
                  isClicked2 = true;
                  isClicked1 = false;

                  button_color2 = Colors.blue;
                  border_color2 = Color.fromRGBO(43, 115, 243, 1);
                  button_text_color2 = Colors.white;

                  button_color1 = Colors.white;
                  border_color1 = Color.fromRGBO(205, 205, 205, 1);
                  button_text_color1 = Color.fromRGBO(43, 115, 243, 1);
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 18.r, vertical: 8.r),
                decoration: BoxDecoration(
                  color: button_color2,
                  border: Border.all(color: border_color2),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.r),
                    bottomLeft: Radius.circular(8.r),
                  ),
                ),
                child: Text(
                  'مواعيد قادمة',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: button_text_color2,
                  ),
                ),
              ),
            ),
          ],
        ),
          SizedBox(height: 40.h),
          Divider(height: 3.h, color: Color.fromRGBO(207, 223, 252, 1)),
          SizedBox(height: 40.h),

          ConditionalBuilder(
            condition: isClicked2,
            builder: (context) {
              return Center(
                child: Container(
                  width: 327.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 327.w,
                        height: 59.h,
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        decoration: BoxDecoration(
                          color: Color(0xFF2B73F3),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12.r),
                            topRight: Radius.circular(12.r),
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "20:01:54",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      Container(
                        width: 327.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12.r),
                            bottomRight: Radius.circular(12.r),
                          ),
                          border: Border.all(color: Color(0xFFDCDCDC)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(14.r),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 40.r,
                                    height: 40.r,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(183, 207, 251, 1),
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: AssetImage(
                                          "assets/images/doctor.png",
                                        ),
                                        fit: BoxFit.cover,

                                        alignment: Alignment.topCenter,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [ 
                                      Text(
                                        'دكتور',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      Text(
                                        'مرام على',
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                ]),
                                ],
                              ),

                              SizedBox(height: 18.h),

                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Color.fromRGBO(
                                      231,
                                      239,
                                      254,
                                      1,
                                    ),

                                    child: Icon(
                                      Icons.star_border,
                                      size: 22.sp,
                                      color: Color(0xFF2B73F3),
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "التخصص",
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        SizedBox(height: 4.h),
                                        Text(
                                          "أنف وأذن وحنجرة",
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  
                                ],
                              ),

                              SizedBox(height: 18.h),

                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Color.fromRGBO(
                                      231,
                                      239,
                                      254,
                                      1,
                                    ),

                                    child: Icon(
                                      Icons.calendar_month_outlined,
                                      size: 22.sp,
                                      color: Color(0xFF2B73F3),
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "التاريخ",
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        SizedBox(height: 4.h),
                                        Text(
                                          "الأربعاء، 10 نوفمبر 2025",
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  
                                ],
                              ),

                              SizedBox(height: 18.h),

                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Color.fromRGBO(
                                      231,
                                      239,
                                      254,
                                      1,
                                    ),
                                    child: Icon(
                                      Icons.access_time,
                                      size: 22.sp,
                                      color: Color(0xFF2B73F3),
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "الوقت",
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        SizedBox(height: 4.h),
                                        Text(
                                          "10:00 صباحًا",
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  
                                ],
                              ),

                              SizedBox(height: 18.h),

                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(12.r),
                                decoration: BoxDecoration(
                                  color: Color(0xFFF1F5FF),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Text(
                                  "حاسس ب آلام شديد في الجيوب الأنفية من حوالي أسبوع وبدأ الموضوع يكون له مضاعفات",
                                  style: TextStyle(fontSize: 12.sp),
                                ),
                              ),

                              SizedBox(height: 20.h),

                              Row(
                                children: [
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color.fromRGBO(
                                          43,
                                          115,
                                          243,
                                          1,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8.r,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'ضبط تنبيه',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color.fromRGBO(
                                          255,
                                          255,
                                          255,
                                          1,
                                        ),
                                        side: BorderSide(
                                          color: Color.fromRGBO(
                                            43,
                                            115,
                                            243,
                                            1,
                                          ),
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8.r,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'إلغاء',
                                        style: TextStyle(
                                          color: Color.fromRGBO(
                                            43,
                                            115,
                                            243,
                                            1,
                                          ),
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },

            fallback: (context) {
            return Column(
              children: [
                Stack(
                          children: [
                Positioned(
                  top: 0,
                  left: 24.w,
                  child: Container(
                    width: 54.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(244, 228, 227, 1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.r),
                        bottomRight: Radius.circular(14.r),
                      ),
                    ),
                    child: Center(
                      child: Text('ألغيت',
                        style: TextStyle(
                          color: Color.fromRGBO(243, 66, 54, 1),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromRGBO(207, 223, 252, 1)
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 12.h),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Color.fromRGBO(183, 207, 251, 1),
                              backgroundImage: AssetImage('assets/images/doctor.png'),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'د. مرام علي',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        'أنف وأذن وحنجرة',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(113, 113, 122, 1),
                        ),
                      ),
                      SizedBox(height: 6.h),
                      SizedBox(
                        width: 172.w,
                        height: 26.h,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text('حجز مرة اخري'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(43, 115, 243, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                          ),
                        ),
                      ),
                    ],
                              ),
                            ),
                          ],
                        ),
                      ),
                  ),
                        ]
                ),
                SizedBox(height: 24.h),
              Stack(
          children: [
            Positioned(
              top: 0,
              left: 24.w,
              child: Container(
                width: 54.w,
                height: 30.h,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(251, 248, 244, 1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.r),
                    bottomRight: Radius.circular(14.r),
                  ),
                ),
                child: Center(
                  child: Text('تمت',
                    style: TextStyle(
                      color: Color.fromRGBO(242, 181, 68, 1),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromRGBO(207, 223, 252, 1)
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 12.h),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Color.fromRGBO(183, 207, 251, 1),
                          backgroundImage: AssetImage('assets/images/doctor.png'),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'د. مرام علي',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    'أنف وأذن وحنجرة',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(113, 113, 122, 1),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      SizedBox(
                        width: 110.w,
                        height: 30.h,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text('حجز مرة اخري',style: TextStyle(fontSize: 11),),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(43, 115, 243, 1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.r),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                        Container(
                        width: 100.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blue,
                            width: 2
                          ),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: ElevatedButton(
                          
                          onPressed: () {},
                          child: Text('تقييم',style: TextStyle(fontSize: 11,
                          color: Colors.blue),),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                          ),
                        ),
                      ],
                    ),
                  ),
              ),
        ]
            )
              ],
            );
            
            },
          ),
        ],
      ),
    );
  }
}
