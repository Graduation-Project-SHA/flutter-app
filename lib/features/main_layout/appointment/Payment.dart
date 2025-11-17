import 'package:flutter/material.dart';
import 'package:health_care_project/features/main_layout/appointment/insta_pay.dart';
import 'package:health_care_project/features/main_layout/appointment/visa_pay.dart';
import 'package:health_care_project/shared/component/defaultbutton/defaultbutton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  int radio_index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
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
          'بيانات الدفع',
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15.h),
            Container(
              padding: EdgeInsets.all(20.w),
              color: Colors.white,
              child: Row(
                children: [
                  Container(
                    height: 70.h,
                    width: 70.w,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/doctor.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        " تقييم",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(113, 113, 122, 1),
                        ),
                      ),
                      Text(
                        "د.مرام علي",
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'أنف واذن وحنجرة',
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Color.fromRGBO(113, 113, 122, 1),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.h),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(20.w),
                  color: Colors.white,
                  child: Row(
                    children: [
                      SizedBox(width: 12.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "تاريخ الحجز",
                                style: TextStyle(
                                  color: Color.fromRGBO(17, 24, 38, 1),
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(width: 210.w),
                              GestureDetector(
                                onTap: () {},
                                child: Row(
                                  children: [
                                    Text(
                                      'تعديل',
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w700,
                                        color: Color.fromRGBO(37, 78, 219, 1),
                                      ),
                                    ),
                                    SizedBox(width: 15.w),
                                    Icon(
                                      Icons.edit_outlined,
                                      color: Color.fromRGBO(37, 78, 219, 1),
                                      size: 18.sp,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            children: [
                              Container(
                                height: 64.h,
                                width: 64.w,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(204, 204, 255, 1),
                                  borderRadius: BorderRadius.circular(30.r),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/appointment.png',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: 15.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'الحجز',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Color.fromRGBO(113, 113, 122, 1),
                                    ),
                                  ),
                                  Text(
                                    "Wednesday, 10 Jan 2024, 11:00",
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.h),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 30.w),
              width: double.infinity,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'اختيار طريقه الدفع',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/visa_logo.png',
                        width: 90.w,
                        height: 20.h,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(width: 20.w),
                      Text(
                        "بطاقه بنكيه ",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15.sp,
                        ),
                      ),
                      Spacer(),
                      Radio(
                        value: 0,
                        groupValue: radio_index,
                        activeColor: Color.fromRGBO(37, 78, 219, 1),
                        onChanged: (value) {
                          setState(() {
                            radio_index = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/InstaPay_Logo.png',
                        width: 30.w,
                        height: 30.h,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(width: 20.w),
                      Text('انستا باي', style: TextStyle(fontSize: 15.sp)),
                      Spacer(),
                      Radio(
                        activeColor: Color.fromRGBO(37, 78, 219, 1),
                        value: 1,
                        groupValue: radio_index,
                        onChanged: (value) {
                          setState(() {
                            radio_index = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.h),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 30.w),
              color: Colors.white,
              width: double.infinity,
              child: Column(
                spacing: 15.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'مجموع المدفوعات',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'كشف',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(113, 113, 122, 1),
                        ),
                      ),
                      SizedBox(width: 150.w),
                      Text(
                        '300 جنيه',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 15.sp,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'إعادة',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(113, 113, 122, 1),
                        ),
                      ),
                      SizedBox(width: 150.w),
                      Text(
                        'مجانية',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 15.sp,
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
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
        height: 120.h,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8.r,
              offset: Offset(0, -2.h),
            ),
          ],
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'المجموع',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '300 جنيه',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            Spacer(),
            Container(
              height: 50.h,
              width: 160.w,
              child: DefaultButton(
                onPressed: () {
                  if (radio_index == 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InstaPay(),
                      ),
                    );
                  } else if (radio_index == 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VisaPay(),
                      ),
                    );
                  }
                },
                buttonText: 'ادفع',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
