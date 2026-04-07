import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class BloodBanner extends StatelessWidget {
  const BloodBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 180.h,
        width: 360.w,
        decoration: BoxDecoration(
          color:  Color(0xffFFF5F7),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Padding(
          padding: EdgeInsetsGeometry.only(left: 20.w, right: 20.w, top: 4.h, bottom: 20.h),
          child: Column(
            
            children: [
            SizedBox(height: 20.h,),
            CircleAvatar(
              radius: 40.r,
              backgroundColor: Color(0xffFBDFE0),
              child: Image.asset('assets/images/blood.png',height: 50.h, width: 50.w,),
            ),  
            SizedBox(height: 20.h,),
            Text('حدد فصيلة الدم وتفاصيل التبرع', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),),
            SizedBox(height: 10.h,),
          
            
          ],),
        ),
      ),
    );
  }
}