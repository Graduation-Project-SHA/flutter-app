import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:health_care_project/features/patient/donation/donation_cubit/donation_cubit.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      offset: Offset(40.w, 40.h), 
      onSelected: (value) {
        final cubit = DonationCubit.get(context);

        if (value == "ALL") {
           cubit.getDonationData(type: null);
        } else if (value == "BLOOD") {
          cubit.getDonationData(type: "BLOOD");
        } else if (value == "DEVICE") {
          cubit.getDonationData(type: "MEDICAL_DEVICE");
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(value: "ALL", child: Text("الكل")),
        const PopupMenuItem(value: "BLOOD", child: Text("تبرعات الدم")),
        const PopupMenuItem(value: "DEVICE", child: Text("تبرعات الأجهزة")),
      ],
      child: Container(
        width: 50.w,
        height: 50.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xffEDF1F3)),
        ),
        child: Center(
          child: SvgPicture.asset(
            "assets/images/filter.svg",
            width: 18.w,
            height: 18.h,
          ),
        ),
      ),
    );
  }
}
