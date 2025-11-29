import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBarBtn extends StatelessWidget {
  final VoidCallback? onTap;
  final IconData? icon;

  const CustomAppBarBtn({
    super.key,
    this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Container(
        width: 40.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color.fromRGBO(205, 205, 205, 1)),
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: IconButton(
          onPressed: onTap ?? () {
            Navigator.pop(context);
          },
          padding: EdgeInsets.zero,
          icon: Icon(
            icon ?? Icons.arrow_forward_ios,
            size: 18.sp,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}