import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care_project/features/patient/main_layout/main_layout.dart';
import 'package:health_care_project/shared/component/defaultbutton/defaultbutton.dart';

class SuccessAlert extends StatelessWidget {
  const SuccessAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/images/pay_done_back1.png',
                    width: 200,
                    height: 124,
                  ),
                  Image.asset(
                    'assets/images/pay_done_back2.png',
                    width: 185,
                    height: 160,
                  ),
                  Image.asset(
                    'assets/images/pay_done.png',
                    width: 148,
                    height: 148,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'تم تأكيد الطلب',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: 240.w,
                child: const Text(
                  textAlign: TextAlign.center,
                  'تم نشر طلبك في صفحة التبرعات وترقب الرد من المتبرعين وشكرا علي ثقتك',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 24),
              DefaultButton(
                onPressed: () {
              

    
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MainLayout(selectedIndex: 0)),
        (route) => false,
      );
    
                },
                buttonText: 'الصفحة الرئيسية',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
