import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care_project/features/doctor/auth/register/doctor_register_steps/completeRegisterScreen.dart';

class Facialrecognition extends StatefulWidget {
  const Facialrecognition({super.key});

  @override
  State<Facialrecognition> createState() => _FacialrecognitionState();
}

class _FacialrecognitionState extends State<Facialrecognition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          "التعرف علي الوجه",
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
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_forward_ios, size: 18.sp),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: 12.w,
            vertical: 20.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              SizedBox(height: 16.h),
              Text(
                'التأكد من ملكية الكارنيه',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(30, 30, 30, 1),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'إذا كان هناك اي بيانات غير صحيحة قم بإعادة تصوير الكارنيه',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(117, 117, 117, 1),
                ),
              ),
              SizedBox(height: 30.h),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: 16.w,
                  vertical: 20.h,
                ),
                child: Container(
                  height: 400.h,
                  width: 400.w,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/FaceId.png'),
                    ),
                    borderRadius: BorderRadius.circular(850),
                    color: Color.fromRGBO(30, 108, 245, 1),
                  ),
                ),
              ),
              SizedBox(height: 110.h),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 150.w),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Completeregisterscreen();
                        },
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 38,
                        backgroundColor: Color.fromRGBO(13, 91, 227, 1),
                        child: CircleAvatar(
                          radius: 33,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 31,
                            backgroundColor: Color.fromRGBO(13, 91, 227, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
