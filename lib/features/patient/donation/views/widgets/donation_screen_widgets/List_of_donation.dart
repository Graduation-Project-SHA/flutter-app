import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_care_project/features/patient/donation/donation_cubit/donation_cubit.dart';
import 'package:health_care_project/features/patient/donation/donation_cubit/donation_states.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../chat/presentation/screens/chat_details_screen.dart';

class ListOfDonation extends StatelessWidget {
  const ListOfDonation({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = DonationCubit.get(context);

    return BlocConsumer<DonationCubit, DonationState>(
      listener: (context, state) {
        
      },

      builder: (context, state) {
      
      
        
        return ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: cubit.donations.length,
        separatorBuilder: (context, index) => SizedBox(height: 15.h),
        itemBuilder: (context, index) {
            final item = cubit.donations[index];
              final isBlood = item.donationType == "BLOOD";
      
          return Stack(
            children: [
              Container(
                height: 115.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: const Color(0xffCFDFFC), width: 1.5),
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
                        backgroundColor: const Color(0xffDCE7FF),
                        child: Image.asset(
                          'assets/images/girl_photo.png',
                          fit: BoxFit.cover,
                        ),
                      ),
      
                      SizedBox(width: 10.w),
      
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${item.firstName} ${item.lastName}",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
      
                          SizedBox(height: 4.h),
      
                          Text(
                            isBlood
                                ? "تبحث عن متبرع بدم"
                                : "تبحث عن متبرع بجهاز طبي",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: const Color(0xff71717A),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
      
                          SizedBox(height: 5.h),
      
                        Row(
        children: [
      Text(
        isBlood
            ? "فصيلة الدم المطلوبة : "
            : "نوع الجهاز المطلوب : ",
        style: TextStyle(
          fontSize: 14.sp,
          color: const Color(0xff18181B),
          fontWeight: FontWeight.w700,
        ),
      ),
      
      Directionality(
        textDirection: TextDirection.ltr,
        child: Text(
          isBlood
              ? (item.bloodType ?? 'غير محدد')
              : (item.deviceType ?? 'غير محدد'),
          style: TextStyle(
            fontSize: 14.sp,
            color: const Color(0xff18181B),
            fontWeight: FontWeight.w700,
            fontFamily: "Roboto",
          ),
        ),
      ),
        ],
      )
                        ],
                      ),
                    ],
                  ),
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
                      builder: (context) => ChatDetailsScreen(myId: '',conversationId: '', targetUserId: '', targetUserName: '',),
                    ),
                  );
                },
                icon: SvgPicture.asset(
                  'assets/images/svgs/message_icon.svg',
                  height: 30.h,
                  width: 30.w,
                ),
              ),
            ],
          );
        },
      );
    
        
      
      },
    );
  }
}