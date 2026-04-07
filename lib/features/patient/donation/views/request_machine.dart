import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:health_care_project/features/patient/donation/views/widgets/custom_appbar.dart';
import 'package:health_care_project/features/patient/donation/views/widgets/request_machine/machine_banner.dart';
import 'package:health_care_project/features/patient/donation/views/widgets/request_machine/select_box_machine.dart';
import 'package:health_care_project/features/patient/donation/views/widgets/success_alert.dart';
import 'package:health_care_project/shared/component/defaultTextFormField/defaultTextFormField.dart';
import 'package:health_care_project/shared/component/defaultbutton/defaultbutton.dart';

class RequestMachine extends StatelessWidget {
  const RequestMachine({super.key});
  static const String routeName = "RequestMachine";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'انشاء طلب'),
      body: Column(
        children: [
          MachineBanner(),
          SizedBox(height: 30.h),
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 25.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'نوع الحهاز',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),
                SelectBoxOfMachine(),
                SizedBox(height: 20.h),
                Text(
                  'سبب طلب الجهاز',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),
                Defaulttextformfield(
                  hintText:
                      'والدي يحتاجه ونحن غير قادرين علي التكف بتكلفته في المستشفيات',
                  maxLines: 2,
                ),
                SizedBox(height: 10.h),
                Text(
                  'الموقع',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Expanded(
                      child: Defaulttextformfield(
                        hintText: '15 شارع عباس العقاد',
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.all(12.r),
                      height: 52.h,
                      width: 52.w,
                      decoration: BoxDecoration(
                        color: Color(0xff2B73F3),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: SvgPicture.asset(
                        'assets/images/svgs/location.svg',
                        height: 10.h,
                        width: 10.w,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 30.h),
          Container(
            height: 170.h,
            width: 330.w,
            decoration: BoxDecoration(
              color: Color(0xffEFF6FF),
              borderRadius: BorderRadius.circular(10.r),
              border: BoxBorder.all(color: Color(0xffBEDBFF)),
            ),
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 27.w,
                vertical: 16.h,
              ),
              child: Column(
                children: [
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/svgs/alert.svg',
                        height: 25.h,
                        width: 25.w,
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        'تذكير:',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff1C398E),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 13.h),
                  Text(
                    'يجب التأكد من ان المتبرع بصحة جيدة ودمه نفس الفصيلة المطلوبة واذا كان لديه اي وشم فيجب عدم اخذ اي تبرع منه',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff193CB8),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 20.w),
            child: DefaultButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return SuccessAlert();
                  },
                );
              },
              buttonText: 'متابعة',
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
