import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../shared/component/defaultbutton/defaultbutton.dart';
import '../../doctor/auth/register/doctor_register_steps/completeRegisterScreen.dart';
import '../login/login_screen.dart';

class SuccessRegisterScreen extends StatelessWidget {
  static const String routeName = "SuccessRegisterScreen";
  final bool isDoctor;
  final String firstName;
  const SuccessRegisterScreen({super.key,required this.firstName,this.isDoctor = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment:Alignment.center,
                children: [
                  Image.asset(
                    'assets/images/bg.png',
                    width: 266.w,
                    height: 208.03.h,
                  ), Image.asset(
                    'assets/images/success.png',
                    width: 158.w,
                    height: 158.h,
                  ),
                ],
              ),
              SizedBox(height:8.h),
              Text(
                ' مرحبا $firstName !',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height:8.h),
              Text(
                'لقد أنشأت حسابك بنجاح',
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Color.fromRGBO(138, 136, 148, 1),
                  fontWeight: FontWeight.w400
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height:17.h),
              Text(
                'قم بتسجيل الدخول في الخطوة التالية وأبدا بملئ بياناتك فى\n ملفك الشخصي',
                style: TextStyle(
                    fontSize: 10.sp,
                    color: Color.fromRGBO(138, 136, 148, 1),
                    fontWeight: FontWeight.w400
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height:32.h),
              DefaultButton(
                buttonText: 'تسجيل الدخول',
                onPressed: () {
                  if (isDoctor) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const Completeregisterscreen(),
                      ),
                    );
                  } else {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      Loginscreen.routeName,
                          (route) => false,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}