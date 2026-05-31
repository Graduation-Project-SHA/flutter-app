import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care_project/shared/component/customAppbarButton/custom_app_bar_button.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key, required this.title, this.horizontalPadding});
  final String title;
  final double? horizontalPadding;
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actionsPadding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 15.w),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 22.sp,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      ),
      automaticallyImplyLeading: false,
      actions: [CustomAppBarBtn()],
    );
  }
}
