import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  DefaultButton({
    this.backgroundColor,
    this.shape,
    this.elevation=3,
    this.foregroundColor,
    required this.onPressed,
    required this.buttonText,
    super.key,
    this.buttonTextSize,
    this.buttonTextWeight,
    this.buttonTextColor,
    this.boderColor,
  });
  void Function()? onPressed;
  String buttonText;
  Color? backgroundColor;
  Color? foregroundColor;
  double? elevation;
  OutlinedBorder? shape;
  double? buttonTextSize;
  FontWeight? buttonTextWeight;
  Color? buttonTextColor;
  Color? boderColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        foregroundColor: foregroundColor??Colors.white,
        elevation: elevation,
        shape: shape??RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(6)
        ),
      ),
      child: Ink(
        width: double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor,
            borderRadius:  BorderRadiusGeometry.circular(6),
          gradient: backgroundColor==null? LinearGradient(colors: [
            Color.fromRGBO(27, 106, 243, 1),
            Color.fromRGBO(27, 106, 243, 1),
            Color.fromRGBO(27, 106, 243, 1)
          ]):LinearGradient(colors: [
            ?backgroundColor,
            ?backgroundColor
          ]),
          border: BoxBorder.all(
            width: 1,
            color: boderColor??Color.fromRGBO(255, 255, 255, .5)
            
          )
    
        ),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(14),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: buttonTextSize,
              fontWeight: buttonTextWeight,
              color: buttonTextColor??Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
