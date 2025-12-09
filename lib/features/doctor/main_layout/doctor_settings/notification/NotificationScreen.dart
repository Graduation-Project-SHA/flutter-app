import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Notificationscreen extends StatefulWidget {
  Notificationscreen({super.key});

  @override
  State<Notificationscreen> createState() => _NotificationscreenState();
}

class _NotificationscreenState extends State<Notificationscreen> {
  List<bool> switches = [false, true, false, true];
  List<String> OptionName = 
  [
    'اشعارات من تطبيق اسعفني',
    'الصوت',
    'الاهتزاز',
    'تحديثات البرنامج',


  ];

  @override
  Widget build(BuildContext context) {
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

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
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
                separatorBuilder: (context, index) => Divider(height: 1,
                color: Color.fromRGBO(205, 205, 205, 1)),
                itemCount: switches.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
