import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_project/shared/component/defaultbutton/defaultbutton.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../success_register/success_register_screen.dart';

class VerifyEmailScreen extends StatefulWidget {
  final String email;
  final String firstName;
  const VerifyEmailScreen({super.key, required this.email, required this.firstName,});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final TextEditingController pinCodeController = TextEditingController();
  String enteredPinCode = '';



  @override
  void dispose() {

    pinCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {

        if (state is VerifyEmailSuccessState) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) =>  SuccessRegisterScreen(
                  firstName: widget.firstName,),
            ),
          );
        }

        if (state is VerifyEmailErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.redAccent,
            ),
          );
        }


      },
      builder: (context, state) {
        bool isVerifying = state is VerifyEmailLoadingState;


        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12.h),
                Text(
                  'التحقق من البريد الإلكتروني',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromRGBO(43, 40, 41, 1),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  "تم إرسال رمز التحقق إلى بريدك الإلكتروني للتحقق من ملكية الحساب.",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromRGBO(43, 40, 41, 1),
                  ),
                ),
                SizedBox(height: 30.h),
                Text(
                  "البريد الإلكتروني",
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromRGBO(108, 114, 120, 1),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(widget.email, style: TextStyle(fontSize: 14.sp)),
                SizedBox(height: 20.h),
                Text(
                  'أدخل الرمز المرسل إلى بريدك الإلكتروني',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromRGBO(64, 64, 64, 1),
                  ),
                ),
                SizedBox(height: 10.h),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: PinCodeTextField(
                    length: 6,
                    controller: pinCodeController,
                    appContext: context,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        enteredPinCode = value;
                      });
                    },
                    enableActiveFill: true,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5.r),
                      fieldHeight: 50.h,
                      fieldWidth: 50.w,
                      activeFillColor: const Color.fromRGBO(12, 61, 173, 0.02),
                      inactiveFillColor: const Color.fromRGBO(12, 61, 173, 0.02),
                      selectedFillColor: const Color.fromRGBO(12, 61, 173, 0.02),
                      activeColor: Colors.blue,
                      inactiveColor: const Color.fromRGBO(207, 219, 236, 1),
                      selectedColor: Colors.blue,
                    ),
                  ),
                ),

                SizedBox(height: 30.h),
                DefaultButton(
                  buttonText: isVerifying ? 'جاري التحقق...' : 'تأكيد واستمرار',
                  onPressed: isVerifying
                      ? null
                      : () {
                    if (enteredPinCode.length != 6 && !isVerifying) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("الرجاء إدخال الرمز المكون من 6 أرقام"),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                      return;
                    }

                    AuthCubit.get(context).verifyEmail(
                      email: widget.email,
                      code: enteredPinCode,
                    );
                  },
                ),

              ],
            ),
          ),
        );
      },
    );
  }
}
