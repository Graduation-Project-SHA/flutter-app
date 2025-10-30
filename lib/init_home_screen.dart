import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'features/auth/cubit/auth_cubit.dart';
import 'features/auth/login/login_screen.dart';


class HomeScreen extends StatelessWidget {
  static const String routeName = "HomeScreen";
  const HomeScreen({super.key});

  void _logout(BuildContext context) {

    AuthCubit.get(context).userLogout();
    Navigator.pushNamedAndRemoveUntil(
      context,
      Loginscreen.routeName,
          (route) => false,
    );
  }

  String _getUserName() {
    final authBox = Hive.box('authBox');
    return authBox.get('userName') ?? 'ضيف';
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: AuthCubit.get(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'الرئيسية',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.redAccent),
              onPressed: () => _logout(context),
              tooltip: 'تسجيل الخروج',
            ),
          ],
        ),
        body: Center(
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
              SizedBox(height: 30.h),
              Text(
                'أهلاً بك! ${_getUserName()}',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 10.h),
              Text(
                'لقد تم تسجيل الدخول بنجاح.',
                style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}