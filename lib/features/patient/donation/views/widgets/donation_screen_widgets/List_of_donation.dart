import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:health_care_project/features/patient/main_layout/messages/chat_details_screen.dart';

class ListOfDonation extends StatelessWidget {
  const ListOfDonation({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),

      itemBuilder: (context, index) {
        return Stack(
          children: [
            Container(
              height: 115.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Color(0xffCFDFFC), width: 1.5),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 10.w,
                  right: 10.w,
                  top: 18.h,
                  bottom: 10.h,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30.r,
                      backgroundColor: Color(0xffDCE7FF),
                      child: Image.asset(
                        'assets/images/girl_photo.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'محمد أحمد',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'تبحث عن متبرع بدم',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Color(0xff71717A),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'فصيلة الدم المطلوبة : A+',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Color(0xff18181B),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 5.h),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              top: 30.h,
              left: 10.w,
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatDetailsScreen(),
                    ),
                  );
                },
                icon: SvgPicture.asset(
                  'assets/images/svgs/message_icon.svg',
                  height: 30.h,
                  width: 30.w,
                ),
                color: Color(0xff2B73F3),
              ),
            ),
          ],
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: 15.h),
      itemCount: 5,
    );
  }
}
