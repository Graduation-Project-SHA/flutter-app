import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_project/shared/component/defaultTextButton/defaultTextButton.dart';
import 'package:health_care_project/shared/component/defaultTextFormField/defaultTextFormField.dart';
import 'package:health_care_project/shared/component/defaultbutton/defaultbutton.dart';
import '../../patient/main_layout/main_layout.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../forgetpassword/forget_password_screen.dart';
import '../register/register_user_screen.dart';

class Loginscreen extends StatefulWidget {
  static const String routeName = "Loginscreen";

  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  static final String _registerRoute = RegisterUserScreen.routeName;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController forgotEmailController = TextEditingController();

  bool userIconsTap = false;
  bool doctorIconsTap = false;
  bool isLogin = true;
  bool isRegiser = false;
  bool obsecure = true;
  bool checkboxValue = false;
  bool isSubmitted = false;

  bool get isEmailValid => emailController.text.contains('@') && emailController.text.contains('.');
  bool get isPasswordValid => passwordController.text.length >= 8;

  void _navigateToRegister() {
    Navigator.of(context).pushReplacementNamed(_registerRoute);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    forgotEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("تم تسجيل الدخول بنجاح!"),
                  backgroundColor: Colors.green,
                ),
              );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainLayout(selectedIndex: 0),
                  ),
                );
            } else if (state is LoginErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("فشل تسجيل الدخول: ${state.error}"),
                  backgroundColor: Colors.redAccent,
                ),
              );
            }
          },
          builder: (context, state) {
            bool isLoading = state is LoginLoadingState;

            return Container(
              height: 1.sh,
              width: 1.sw,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color.fromRGBO(71, 134, 245, 1),
                    const Color.fromRGBO(43, 115, 243, 1),
                    const Color.fromRGBO(48, 119, 243, 1),
                  ],
                ),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: .30.sh,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.centerLeft,
                          colors: [
                            const Color.fromRGBO(255, 255, 255, .3),
                            const Color.fromRGBO(255, 255, 255, .04),
                          ],
                        ),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 15.h),
                                Text(
                                  "لوجو",
                                  style: TextStyle(
                                    fontSize: 32.sp,
                                    fontWeight: FontWeight.bold,
                                    color: const Color.fromRGBO(10, 69, 87, 1),
                                  ),
                                ),
                                Text(
                                  "أبدأ الان",
                                  style: TextStyle(
                                    fontSize: 32.sp,
                                    fontWeight: FontWeight.bold,
                                    color: const Color.fromRGBO(238, 238, 238, 1),
                                  ),
                                ),
                                Text(
                                  'معا لتوفير جميع الخدمات الطبية بطريقة افضل',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: .70.sh,
                      ),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.r),
                            topRight: Radius.circular(20.r),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.w),
                          child: SizedBox(
                            child: (Column(
                              children: [
                                SizedBox(height: 30.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          userIconsTap = true;
                                          doctorIconsTap = false;
                                        });
                                      },
                                      child: Container(
                                        height: 119.h,
                                        width: 99.w,
                                        decoration: BoxDecoration(
                                          color: userIconsTap
                                              ? const Color.fromRGBO(154, 185, 239, 0.55)
                                              : const Color.fromRGBO(237, 241, 243, 1),
                                          border: Border.all(
                                            color: const Color.fromRGBO(237, 241, 243, 1),
                                            width: 1.w,
                                          ),
                                          borderRadius: BorderRadius.circular(10.r),
                                        ),
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: Image.asset(
                                                'assets/images/user_logo.png',
                                              ),
                                            ),
                                            Text(
                                              "مستخدم عادي",
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 20.w),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          doctorIconsTap = true;
                                          userIconsTap = false;
                                        });
                                      },
                                      child: Container(
                                        height: 119.h,
                                        width: 99.w,
                                        decoration: BoxDecoration(
                                          color: doctorIconsTap
                                              ? const Color.fromRGBO(154, 185, 239, 0.55)
                                              : const Color.fromRGBO(237, 241, 243, 1),
                                          border: Border.all(
                                            color: const Color.fromRGBO(237, 241, 243, 1),
                                            width: 1.w,
                                          ),
                                          borderRadius: BorderRadius.circular(10.r),
                                        ),
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: Image.asset(
                                                'assets/images/doctor_logo.png',
                                              ),
                                            ),
                                            SizedBox(height: 8.h),
                                            Text(
                                              "أنا طبيب",
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 25.h),
                                Container(
                                  height: 47.h,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isLogin = true;
                                              isRegiser = false;
                                            });
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "تسجيل الدخول",
                                              style: TextStyle(
                                                color: isLogin
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(6.r),
                                              border: Border.all(
                                                width: 1.w,
                                                color: const Color.fromRGBO(255, 255, 255, .5),
                                              ),
                                              gradient: isLogin
                                                  ? const LinearGradient(
                                                colors: [
                                                  Color.fromRGBO(27, 106, 243, 1),
                                                  Color.fromRGBO(27, 106, 243, 1),
                                                  Color.fromRGBO(27, 106, 243, 1),
                                                ],
                                              )
                                                  : const LinearGradient(
                                                colors: [
                                                  Color.fromARGB(255, 220, 218, 218),
                                                  Color.fromARGB(255, 220, 218, 218),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            _navigateToRegister();
                                            setState(() {
                                              isLogin = false;
                                              isRegiser = true;
                                            });
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "إنشاء حساب",
                                              style: TextStyle(
                                                color: isRegiser
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(6.r),
                                              border: Border.all(
                                                width: 1.w,
                                                color: const Color.fromRGBO(255, 255, 255, .5),
                                              ),
                                              gradient: isRegiser
                                                  ? const LinearGradient(
                                                colors: [
                                                  Color.fromRGBO(27, 106, 243, 1),
                                                  Color.fromRGBO(27, 106, 243, 1),
                                                  Color.fromRGBO(27, 106, 243, 1),
                                                ],
                                              )
                                                  : const LinearGradient(
                                                colors: [
                                                  Color.fromARGB(255, 220, 218, 218),
                                                  Color.fromARGB(255, 220, 218, 218),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 25.h),
                                Column(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "البريد الإلكتورني",
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                            color: const Color.fromRGBO(108, 114, 120, 1),
                                          ),
                                        ),
                                        SizedBox(height: 10.h),
                                        Defaulttextformfield(
                                          controller: emailController,
                                          hintText: 'ادخل بريدك الالكتروني',
                                          hintStyle: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                            color: const Color.fromRGBO(108, 114, 120, 1),
                                          ),
                                          borderColor: (isSubmitted && emailController.text.isEmpty)
                                              ? Colors.redAccent
                                              : null,
                                        ),
                                        SizedBox(height: 25.h),
                                        Text(
                                          "كلمة السر",
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                            color: const Color.fromRGBO(108, 114, 120, 1),
                                          ),
                                        ),
                                        SizedBox(height: 10.h),
                                        Defaulttextformfield(
                                          controller: passwordController,
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                obsecure = !obsecure;
                                              });
                                            },
                                            icon: Icon(
                                              obsecure
                                                  ? Icons.visibility_off_outlined
                                                  : Icons.visibility_outlined,
                                            ),
                                          ),
                                          suffixIconColor: Colors.grey,
                                          obscureText: obsecure,
                                          hintText: "ادخل كلمة السر",
                                          hintStyle: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                            color: const Color.fromRGBO(108, 114, 120, 1),
                                          ),
                                          borderColor: (isSubmitted && passwordController.text.isEmpty)
                                              ? Colors.redAccent
                                              : null,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20.h),
                                    Row(
                                      children: [
                                        DefaultTextButton(
                                          onPressed: () {
                                            forgotEmailController.clear();
                                            showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              builder: (bottomSheetContext) {
                                                final TextEditingController emailController = TextEditingController();
                                                return BlocProvider.value(
                                                  value: AuthCubit.get(context),
                                                  child: BlocConsumer<AuthCubit, AuthState>(
                                                    listener: (context, state) {
                                                      if (state is RequestResetSuccessState) {
                                                        ScaffoldMessenger.of(context).showSnackBar(
                                                          const SnackBar(content: Text('تم إرسال الكود إلى بريدك الإلكتروني')),
                                                        );
                                                        Navigator.pop(context);
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) => ForgetPasswordScreen(email: emailController.text.trim()),
                                                          ),
                                                        );
                                                      } else if (state is RequestResetErrorState) {
                                                        ScaffoldMessenger.of(context).showSnackBar(
                                                          SnackBar(content: Text('حدث خطأ: ${state.error}')),
                                                        );
                                                      }
                                                    },
                                                    builder: (context, state) {
                                                      return Padding(
                                                        padding: EdgeInsets.only(
                                                          bottom: MediaQuery.of(context).viewInsets.bottom,
                                                          left: 16,
                                                          right: 16,
                                                          top: 24,
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            SizedBox(height: 15.h),
                                                            Text(
                                                              "اعادة تعيين كلمة السر",
                                                              style: TextStyle(
                                                                fontSize: 21.sp,
                                                                fontWeight:
                                                                FontWeight.bold,
                                                                color: Colors.black,
                                                              ),
                                                            ),
                                                            SizedBox(height: 20.h),
                                                            Text(
                                                              'البريد الالكتروني',
                                                              style: TextStyle(
                                                                fontSize: 14.sp,
                                                                fontWeight: FontWeight.w500,
                                                                color: Color.fromRGBO(108, 114, 120, 1,),
                                                              ),
                                                            ),
                                                            SizedBox(height: 15.h),
                                                            Defaulttextformfield(
                                                              controller: emailController,

                                                            ),
                                                            SizedBox(height: 20.h),
                                                            state is RequestResetLoadingState
                                                                ? const CircularProgressIndicator()
                                                                : ElevatedButton(
                                                              onPressed: () {
                                                                final email = emailController.text.trim();
                                                                if (email.isEmpty) {
                                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                                    const SnackBar(content: Text('من فضلك أدخل البريد الإلكتروني')),
                                                                  );
                                                                } else {
                                                                  AuthCubit.get(context).requestPasswordReset(email: email);
                                                                }
                                                              },
                                                              child:  Text('ارسال رابط تغيير كلمة السر'),
                                                            ),
                                                             SizedBox(height: 20.h),
                                                            DefaultButton(
                                                              onPressed: () {
                                                                Navigator.pop(context);
                                                              },
                                                              buttonText: 'إلغاء',
                                                              backgroundColor:
                                                              Colors.white,
                                                              foregroundColor:
                                                              Colors.black,
                                                              boderColor: Colors.black,
                                                            ),
                                                            SizedBox(height: 20.h),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                );
                                              }
                                            );
                                          },
                                          textButtonTitle: 'نسيت كلمة السر ؟',
                                        ),
                                        Spacer(),
                                        Text(
                                          'تذكر البيانات',
                                        ),
                                        Checkbox(
                                          checkColor: Colors.white,
                                          activeColor: Colors.blue,
                                          value: checkboxValue,
                                          onChanged: (value) {
                                            setState(() {
                                              checkboxValue = !checkboxValue;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20.h),
                                    DefaultButton(
                                      onPressed: isLoading ? null : () {
                                        setState(() {
                                          isSubmitted = true;
                                        });
                                        if (emailController.text.isEmpty || passwordController.text.isEmpty) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text("من فضلك أدخل البريد الإلكتروني وكلمة السر."),
                                              backgroundColor: Colors.redAccent,
                                            ),
                                          );
                                          return;
                                        }
                                        AuthCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        );
                                      },
                                      buttonText: isLoading ? 'جاري الدخول...' : 'تسجيل الدخول',
                                    ),
                                  ],
                                ),
                              ],
                            )),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
