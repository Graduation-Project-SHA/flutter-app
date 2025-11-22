import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchField extends StatelessWidget {
  final String hint;
  final void Function(String)? onChanged;

  const SearchField({
    super.key,
    this.hint = "البحث...",
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.right,
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hint,
        hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 15.w),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: const BorderSide(color: Color(0xffEDF1F3), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: const BorderSide(color: Color(0xffEDF1F3), width: 1),
        ),
      ),
    );
  }
}
