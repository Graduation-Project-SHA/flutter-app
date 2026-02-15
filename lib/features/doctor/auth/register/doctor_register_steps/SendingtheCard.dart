import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care_project/features/doctor/auth/register/doctor_register_steps/takephotoOfCard.dart';
import 'package:health_care_project/shared/component/defaultbutton/defaultbutton.dart';

import '../../../../auth/cubit/auth_cubit.dart';

class Sendingthecard extends StatefulWidget {
  const Sendingthecard({super.key});

  @override
  State<Sendingthecard> createState() => _SendingthecardState();
}

class _SendingthecardState extends State<Sendingthecard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          "إرسال كارنيه النقابة",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 24.sp,
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
                  setState(() {
                    Navigator.pop(context);
                  });
                },
                icon: Icon(Icons.arrow_forward_ios, size: 18.sp),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            SizedBox(
              height: 30.h,
              width: 380.w,
              child: Image.asset('assets/images/progress_bar3.png'),
            ),
            SizedBox(height: 30),
            Text(
              'لماذا ارسل كارنيه النقابة؟',
              style: TextStyle(
                color: Color.fromRGBO(43, 40, 41, 1),
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'نحن نتأكد من صحة هوية الاطباء قبل اتمام عملية انشاء الحساب حرصا منا على سلامتكم',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                color: Color.fromRGBO(43, 40, 41, 1),
              ),
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Material(
                  elevation: 6,
                  borderRadius: BorderRadius.circular(10),
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                    height: 70.h,
                    width: 85.w,
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/ID_Logo.png',
                      height: 40.h,
                      width: 60.w,
                    ),
                  ),
                ),

                SizedBox(width: 28.w),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'يُرجى إبقاء الكارنيه داخل الإطار المخصص وتصويره من الجهتين',
                        style: TextStyle(fontSize: 15.sp),
                      ),
                      Text(
                        'الأمامية والخلفية',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 40),
            Divider(height: 1, color: Color.fromRGBO(217, 217, 217, 1)),
            SizedBox(height: 25),
            Row(
              children: [
                Material(
                  elevation: 1,
                  borderRadius: BorderRadius.circular(10),
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                    height: 70.h,
                    width: 85.w,
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    alignment: Alignment.center,
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                      child: Image.asset(
                        'assets/images/ID_Logo.png',
                        height: 40.h,
                        width: 60.w,
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 28.w),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'تجنّب الصور الموجودة في',
                        style: TextStyle(fontSize: 15.sp),
                      ),
                      Text(
                        'اضاءة ضعيفة أو الغير الواضحة',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Divider(height: 1, color: Color.fromRGBO(217, 217, 217, 1)),
            Spacer(),
            DefaultButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider.value(
                      value: AuthCubit.get(context),
                      child: const Takephotoofcard(),
                    ),
                  ),
                );

              },
              buttonText: 'التالي',
              buttonTextSize: 14,
            ),
            SizedBox(height: 15.h),
          ],
        ),
      ),
    );
  }
}