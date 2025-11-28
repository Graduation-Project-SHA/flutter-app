import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class FilterButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const FilterButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.w,
      height: 60.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: const Color(0xffEDF1F3), width: 1),
      ),
      child: IconButton(
        icon: SvgPicture.asset("assets/images/filter.svg", width: 18.w, height: 18.h),
        onPressed: onPressed,
      ),
    );
  }
}
