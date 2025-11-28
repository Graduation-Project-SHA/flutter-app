import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/ theme/app_colors.dart';

class DoctorCard extends StatelessWidget {
  final String name;
  final String specialty;
  final String price;
  final String image;
  final VoidCallback onBook;
  final VoidCallback onDetails;

  const DoctorCard({
    super.key,
    required this.name,
    required this.specialty,
    required this.price,
    required this.image,
    required this.onBook,
    required this.onDetails,
  });

  static Widget specialtyIcon(String id, String iconPath, String label, String selectedId){
    bool isSelected = id == selectedId;
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xffC6D4F1)),
            color: isSelected ? AppColors.primary : const Color(0xffF9F5FF),
            shape: BoxShape.circle,
          ),
          child: Image.asset(iconPath, width: 30.w, height: 30.h),
        ),
        SizedBox(height: 4.h),
        Text(label, style: TextStyle(fontSize: 10.sp)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 24.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xffCFDFFC)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(radius: 30.r, backgroundImage: AssetImage(image)),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(name, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
                          Text(specialty, style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
                          SizedBox(height: 8.h),
                          Text(price, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height:28.h),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onBook,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r))
                        ),
                        child: const Text("حجز موعد", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: onDetails,
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(color: AppColors.primary.withOpacity(0.5)),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r))
                        ),
                        child: const Text("تفاصيل", style: TextStyle(color: AppColors.primary)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              Row(
                children: [Text("4.5", style: TextStyle(fontSize: 12.sp, color: Colors.grey)), SizedBox(width: 4.w), Icon(Icons.star, color: Colors.amber, size: 20.sp)],
              ),
              SizedBox(height: 16.h),
              Image.asset("assets/images/message-text_icon.png", color: Color(0xff2B73F3), width: 24.w, height: 24.h),
            ],
          ),
        ],
      ),
    );
  }
}
