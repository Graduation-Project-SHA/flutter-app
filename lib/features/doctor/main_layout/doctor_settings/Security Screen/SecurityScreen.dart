import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Securityscreen extends StatefulWidget {
  const Securityscreen({super.key});

  @override
  State<Securityscreen> createState() => _SecurityscreenState();
}

class _SecurityscreenState extends State<Securityscreen> {
  List<bool> switches = [false, true, false];
  List<String> OptionName = [
    'تذكر كلمة المرور',
    'معرف الوجه',
    'تثبيت',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'الأمان',
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: ListView.separated(
          itemCount: switches.length + 1, // +1 للأداة الأخيرة
          separatorBuilder: (context, index) => Divider(
            height: 1.h,
            color: Color.fromRGBO(205, 205, 205, 1),
          ),
          itemBuilder: (context, index) {
            // لو آخر عنصر → أداة مصادقة جوجل
            if (index == switches.length) {
              return ListTile(
                title: Text(
                  'أداة مصادقة جوجل',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                  ),
                ),
                trailing: Icon(Icons.arrow_forward_ios, size: 18.sp),
                onTap: () {
                  // Navigation أو أي وظيفة تحب تضيفها
                },
              );
            }

            // العناصر العادية (السويتشات)
            return ListTile(
              title: Text(
                OptionName[index],
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: Switch(
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: Color.fromRGBO(217, 222, 226, 1),
                value: switches[index],
                onChanged: (value) {
                  setState(() {
                    switches[index] = value;
                  });
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
