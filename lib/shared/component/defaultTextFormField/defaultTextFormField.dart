import 'package:flutter/material.dart';

class Defaulttextformfield extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextStyle? hintStyle;
  final bool obscureText;
  final Widget? suffixIcon;
  final Color? suffixIconColor;
  final Function(String)? onChanged;
  final Color? borderColor;
  final double? borderRadius;
  final String? initialValue;
  final bool readOnly;
  final void Function()? onTap;
  final int maxLines;
  TextInputType? keyboardType;

   Defaulttextformfield({
    super.key,
    this.controller,
    this.hintText,
    this.hintStyle,
    this.obscureText = false,
    this.suffixIcon,
    this.suffixIconColor,
    this.onChanged,
    this.borderColor,
    this.initialValue,
    this.readOnly = false,
    this.onTap ,
     this.maxLines=1,
     this.borderRadius,
      this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      onTap: onTap,
      maxLines: maxLines,
      initialValue: initialValue,
      readOnly: readOnly,
      controller: controller,
      obscureText: obscureText,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle,
        suffixIcon: suffixIcon != null
            ? IconTheme(
                data: IconThemeData(color: suffixIconColor ?? Colors.grey),
                child: suffixIcon!,
              )
            : null,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 12,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8),
          borderSide: BorderSide(
            color: borderColor ?? Colors.grey.shade400,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8),
          borderSide: BorderSide(
            color: borderColor ?? Colors.blueAccent,
            width: 1.3,
          ),
        ),
      ),
    );
  }
}
