import 'package:flutter/material.dart';
class AppColors {

  static const Color primaryBlue = Color(0xFF2196F3);
  static const Color gradientColor1 = Color(0xFF4786F5);
  static const Color gradientColor2 = Color(0xFF2B73F3);
  static const Color gradientColor3 = Color(0xFF3077F3);

  static const Color darkBlue = Color(0xFF1976D2);


  static const Color lightBlue = Color(0xFF6C7278);


  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static Color lightGrey = Color(0xFF6C7278);
  static const Color darkGrey = Color(0xFF616161);
  static const Color red = Color(0xFF900B09);
  static const Color green = Color(0xFF00B312);

  static const Color scaffoldBackground = Color(0xFFFFFFFF);

  static const primary = Color(0xff4786F5);
  static const lightGrey2 = Color(0xffEDF1F3);

  static const Color primaryText = Color(0xFF1E1E1E);
  static const Color secondaryText = Color(0xFF757575);

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      gradientColor1,
      gradientColor2,
      gradientColor3,
    ],
  );
}