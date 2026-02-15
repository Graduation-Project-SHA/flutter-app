import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care_project/features/doctor/main_layout/doctor_settings/FAQScreen/FAQScreen.dart';
import 'package:health_care_project/features/doctor/main_layout/doctor_settings/Security%20Screen/SecurityScreen.dart';
import 'package:health_care_project/features/doctor/main_layout/doctor_settings/notification/NotificationScreen.dart';

import '../../../auth/cubit/auth_cubit.dart';
import '../../../auth/login/login_screen.dart';

class DoctorSettingsScreen extends StatelessWidget {
  const DoctorSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> SettingsOptionName = [
      'الاشعارات',
      'الاسئلة الشائعة',
      'الامان',
      'تسجيل الخروج',
    ];
    List<Image> SettingsOptionIcons = [
      Image.asset('assets/images/notificationLogo.png'),
      Image.asset('assets/images/message-question.png'),
      Image.asset('assets/images/lock.png'),
      Image.asset('assets/images/logout.png'),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'الاعدادات',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromRGBO(205, 205, 205, 1),
                ),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: 18.sp,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsetsGeometry.symmetric(vertical: 5.h),
                  child: ListTile(
                    onTap: () {
                      if (index == 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Notificationscreen(),
                          ),
                        );
                      }
                      if (index == 1)
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FaqScreen()),
                        );
                      if (index == 2)
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Securityscreen(),
                          ),
                        );
                      if (index == 3) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            title:
                            Text(
                              'تسجيل الخروج',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp,
                              ),
                            ),
                            content: Text(
                              'ستحتاج إلى إدخال اسم المستخدم الخاص بك وكلمة المرور في المرة القادمة تريد تسجيل الدخول',
                              style: TextStyle(fontSize: 14.sp),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  'إلغاء',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  AuthCubit.get(context).userLogout();
                                  Navigator.pushNamed(context, Loginscreen.routeName);
                                },
                                child: Text(
                                  'تسجيل الخروج',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    title: Row(
                      children: [
                        Text(
                          SettingsOptionName[index],
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: index == 3
                                ? Color.fromRGBO(255, 76, 94, 1)
                                : Color.fromRGBO(36, 36, 36, 1),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        SizedBox(
                          height: 25.h,

                          child: SettingsOptionIcons[index],
                        ),
                      ],
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 25.w),
                child: Divider(
                  height: 1.h,
                  color: Color.fromRGBO(205, 205, 205, 1),
                ),
              ),
              itemCount: SettingsOptionIcons.length,
            ),
          ),
        ],
      ),
    );
  }
}