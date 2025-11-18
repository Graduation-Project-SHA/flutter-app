import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care_project/features/main_layout/appointment/Pin.dart';
import 'package:health_care_project/shared/component/defaultTextFormField/defaultTextFormField.dart';
import 'package:health_care_project/shared/component/defaultbutton/defaultbutton.dart';

class InstaPay extends StatefulWidget {
  const InstaPay({super.key});

  @override
  State<InstaPay> createState() => _InstaPayState();
}

class _InstaPayState extends State<InstaPay> {
  Color insta_pay_button_color = Colors.white;
  Color insta_pay_button_border_color = Color.fromRGBO(220, 220, 220, 1);
  bool insta_pay_button_isClicked = false;

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
          'انستا باي',
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
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w, vertical: 24.h),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    insta_pay_button_isClicked = !insta_pay_button_isClicked;
                    if (insta_pay_button_isClicked) {
                      insta_pay_button_color = Color.fromRGBO(
                        43,
                        115,
                        243,
                        0.1,
                      );
                      insta_pay_button_border_color = Color.fromRGBO(
                        43,
                        115,
                        243,
                        1,
                      );
                    } else {
                      insta_pay_button_color = Colors.white;
                      insta_pay_button_border_color = Color.fromRGBO(
                        220,
                        220,
                        220,
                        1,
                      );
                    }
                  });
                },
                child: Container(
                  height: 50,
                  width: 100,

                  decoration: BoxDecoration(
                    color: insta_pay_button_color,
                    border: BoxBorder.all(color: insta_pay_button_border_color),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: ConditionalBuilder(
                    condition: insta_pay_button_isClicked == false,
                    builder: (context) {
                      return Container(
                        padding: EdgeInsets.all(8.h),
                        child: Image.asset(
                          'assets/images/instapay_bigLogo.png',
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                    fallback: (context) {
                      return Stack(
                        clipBehavior: Clip.none,

                        children: [
                          Positioned(
                            top: -4,
                            right: -4,
                            child: Icon(
                              Icons.check_circle,
                              color: Color.fromRGBO(43, 115, 243, 1),
                              size: 24.sp,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8.h),
                            height: 50,
                            width: 100,
                            child: Image.asset(
                              'assets/images/instapay_bigLogo.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                'اسم المستخدم',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.h),
              Defaulttextformfield(
                hintText: 'Example@instapay.com',
                hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 16.h),
              Text(
                'رقم الهاتف',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.h),
              Defaulttextformfield(hintText: 'رقم الهاتف الخاص بالحساب'),
              SizedBox(height: 16.h),
              Text("""
         الخطوات
        1. اتمم ملئ البيانات بشكل صحيح
        2. اضغط علي طلب الدفع
        3. افتح تطبيق انستا باي واقبل الطلب
         """, style: TextStyle(color: Color.fromRGBO(43, 115, 243, 1))),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),

        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, -3), // changes position of shadow
            ),
          ],
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    '300 جنيه',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'حجز الكشف',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Text(
                    "مجانا",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "إعادة",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
              Text(
                '_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ ',
              ),
          
              SizedBox(height: 15.h),
              Row(
                children: [
                  Text(
                    "300 جنيه",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "المجموع",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              DefaultButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return   Pin();
                      },
                    ),
                  );
                },
                buttonText: 'طلب الدفع',
                buttonTextSize: 16.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
