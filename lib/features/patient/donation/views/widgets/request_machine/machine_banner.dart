import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MachineBanner extends StatelessWidget {
  const MachineBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 180.h,
        width: 360.w,
        decoration: BoxDecoration(
          color:  Color(0xffF0F6FF),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Padding(
          padding: EdgeInsetsGeometry.only(left: 20.w, right: 20.w, top: 4.h, bottom: 20.h),
          child: Column(
            
            children: [
            SizedBox(height: 20.h,),
            CircleAvatar(
              radius: 40.r,
              backgroundColor: Color(0xffDCE7FF),
              child: Image.asset('assets/images/medical_machine.png',height: 50.h, width: 50.w,),
            ),  
            SizedBox(height: 20.h,),
            Text('حدد نوع الجهاز وسبب احتياجك له', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),),
            SizedBox(height: 10.h,),
          
            
          ],),
        ),
      );
  }
}