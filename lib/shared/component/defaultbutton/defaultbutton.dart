import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultButton extends StatelessWidget {
  DefaultButton({
    this.backgroundColor,
    this.shape,
    this.elevation = 3,
    this.foregroundColor,
    required this.onPressed,
    this.buttonText,
    this.child,
    super.key,
    this.buttonTextSize,
    this.buttonTextWeight,
    this.buttonTextColor,
    this.boderColor,
  });

  final void Function()? onPressed;
  final String? buttonText;
  final Widget? child;

  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? elevation;
  final OutlinedBorder? shape;
  final double? buttonTextSize;
  final FontWeight? buttonTextWeight;
  final Color? buttonTextColor;
  final Color? boderColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        foregroundColor: foregroundColor ?? Colors.white,
        elevation: elevation,
        shape: shape ??
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
      ),
      child: Ink(
        width: double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8.r),
          gradient: backgroundColor == null
              ? const LinearGradient(
                  colors: [
                    Color.fromRGBO(27, 106, 243, 1),
                    Color.fromRGBO(27, 106, 243, 1),
                  ],
                )
              : LinearGradient(
                  colors: [backgroundColor!, backgroundColor!],
                ),
          border: Border.all(
            width: 1,
            color: boderColor ?? const Color.fromRGBO(255, 255, 255, .5),
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(14),
          child: child ??
              Text(
                buttonText ?? "",
                style: TextStyle(
                  fontSize: buttonTextSize,
                  fontWeight: buttonTextWeight,
                  color: buttonTextColor ?? Colors.white,
                ),
              ),
        ),
      ),
    );
  }
}