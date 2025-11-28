import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/ theme/app_colors.dart';


class SpecialtyCard extends StatelessWidget {
  final String title, description, iconPath;
  final bool isSelected;
  final VoidCallback onTap;

  const SpecialtyCard({
    required this.title,
    required this.description,
    required this.iconPath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 5)],
        ),
        child: Row(
          children: [
            Icon(Icons.keyboard_arrow_right, size: 24.sp, color: isSelected ? Colors.white : AppColors.primary),
            SizedBox(width: 12.w),
            CircleAvatar(backgroundColor: Colors.white, child: Image.asset(iconPath, width: 30.w, height: 30.h)),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: isSelected ? Colors.white : Colors.black)),
                SizedBox(height: 4.h),
                Text(description, style: TextStyle(fontSize: 12.sp, color: isSelected ? Colors.white70 : Colors.grey[700])),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
