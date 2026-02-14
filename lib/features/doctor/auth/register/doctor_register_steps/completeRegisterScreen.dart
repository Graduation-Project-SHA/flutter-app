import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care_project/features/doctor/main_layout/doctor_main_layout.dart';
import 'package:health_care_project/features/patient/main_layout/main_layout.dart';
import 'package:health_care_project/shared/component/defaultbutton/defaultbutton.dart';

class Completeregisterscreen extends StatefulWidget {
  const Completeregisterscreen({super.key});

  @override
  State<Completeregisterscreen> createState() => _CompleteregisterscreenState();
}

class _CompleteregisterscreenState extends State<Completeregisterscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          "تمت بنجاح",
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
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 25.w, vertical: 20.h),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'انتظر بضع دقائق',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.sp),
              ),
              SizedBox(height: 5.h),
              Text(
                "انتظر حتى نتأكد من صحة البيانات المقدمة وبعدها يمكنك استخدام الحساب الخاص بك",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                  color: Color.fromRGBO(117, 117, 117, 1),
                ),
              ),
              SizedBox(height: 40.h),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 65.w),
                child: Container(
                  width: 270.w,
                  height: 235.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/completeRegister.png'),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Color.fromRGBO(0, 179, 18, 1),
                    child: Icon(Icons.check),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'تم رفع البيانات بنجاح',
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
                  CircleAvatar(
                    backgroundColor: Color.fromRGBO(4, 29, 72, .5),
                    child: Image(
                      height: 20.h,
                      image: AssetImage('assets/images/Loader.png'),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'تم التأكد من بياناتك وقبولك',
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
                  CircleAvatar(
                    backgroundColor: Color.fromRGBO(4, 29, 72, .5),
                    child: Image(
                      height: 20.h,
                      image: AssetImage('assets/images/Loader.png'),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'تم التأكد من صورة الوجه',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
              Spacer(),
              DefaultButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const DoctorMainLayout(selectedIndex: 0);
                      },
                    ),
                  );
                },
                buttonText: "التالي",
                backgroundColor: Color.fromRGBO(27, 106, 243, .5),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
