import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:health_care_project/features/patient/donation/views/widgets/custom_appbar.dart';
import 'package:health_care_project/features/patient/donation/views/widgets/request_blood_widgets/blood_banner.dart';
import 'package:health_care_project/features/patient/donation/views/widgets/request_blood_widgets/select_box_of_blood.dart';
import 'package:health_care_project/features/patient/donation/views/widgets/success_alert.dart';
import 'package:health_care_project/shared/component/defaultTextFormField/defaultTextFormField.dart';
import 'package:health_care_project/shared/component/defaultbutton/defaultbutton.dart';

class RequestBlood extends StatelessWidget {
  const RequestBlood({super.key});
  static const String routeName = "RequestBlood";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'انشاء طلب'),
      body: Column(
        children: [
          BloodBanner(),
          SizedBox(height: 30.h),
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 25.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'فصيلة الدم',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),
                SelectBoxOfBlood(),
                SizedBox(height: 20.h),
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
          SizedBox(height: 50.h),
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
