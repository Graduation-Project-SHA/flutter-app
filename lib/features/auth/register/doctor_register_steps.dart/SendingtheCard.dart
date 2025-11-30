import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Sendingthecard extends StatefulWidget {
  const Sendingthecard({super.key});

  @override
  State<Sendingthecard> createState() => _SendingthecardState();
}

class _SendingthecardState extends State<Sendingthecard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30,),
        Text('لماذا ارسل كارنيه النقابة؟',style: TextStyle(
          color: Color.fromRGBO(43, 40, 41, 1),
          fontSize: 24.sp,
          fontWeight: FontWeight.w700,

        ),
        
        
        ),
        SizedBox(height: 8.h,),
        Text('نحن نتأكد من صحة هوية الاطباء قبل اتمام عملية انشاء الحساب حرصا منا على سلامتكم',
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16.sp,
          color: Color.fromRGBO(43, 40, 41, 1),
        ),),
        SizedBox(height: 30,),
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
        child: Image.asset('assets/images/ID_Logo.png',     height: 40.h,
          width: 60.w,),
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
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    )
  ],
),

SizedBox(height: 40,)
,
Divider(height: 1,color: Color.fromRGBO(217, 217, 217, 1),),
SizedBox(height: 25,),
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
          child: Image.asset('assets/images/ID_Logo.png',
          height: 40.h,
          width: 60.w,)),
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
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    )
  ],
),
SizedBox(height: 40,)
,
Divider(height: 1,color: Color.fromRGBO(217, 217, 217, 1),),


      ],
    );
  }
}
