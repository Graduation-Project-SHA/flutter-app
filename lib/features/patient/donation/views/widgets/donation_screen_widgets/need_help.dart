import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care_project/features/patient/donation/views/request_donation.dart';
import 'package:health_care_project/shared/component/defaultbutton/defaultbutton.dart';

class NeedHelp extends StatelessWidget {
  const NeedHelp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 290.h,
      width: 360.w,
      decoration: BoxDecoration(
        color:  Color(0xffF0F6FF),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.only(left: 20.w, right: 20.w, top: 4.h, bottom: 20.h),
        child: Column(children: [
          SizedBox(height: 20.h,),
          CircleAvatar(
            radius: 40.r,
            backgroundColor: Color(0xffDCE7FF),
            child: Image.asset('assets/images/help_icon.png',height: 50.h, width: 50.w,),
          ),  
          SizedBox(height: 20.h,),
          Text('احتاج مساعدة', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),),
          SizedBox(height: 10.h,),
          SizedBox
          
          (
              width: 200.w,
            child: Text('قم بطلب المساعدة اذا كنت بحاجة الي دم او اجهزة طبية', style: TextStyle(fontSize: 14.sp, color: Color(0xff71717A),fontWeight: FontWeight.w400), textAlign: TextAlign.center,)),
            Spacer(),
            SizedBox
            (
              height: 46.h,
              
        
              child: DefaultButton(onPressed: (){
                Navigator.pushNamed(context, RequestDonation.routeName);
                
              }, buttonText: 'انشاء طلب',elevation: 0,))
        ],),
      ),
    );
  }
}
