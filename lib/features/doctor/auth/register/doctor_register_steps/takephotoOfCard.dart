import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care_project/features/doctor/auth/register/doctor_register_steps/Facialrecognition.dart';

class Takephotoofcard extends StatefulWidget {
  const Takephotoofcard({super.key});

  @override
  State<Takephotoofcard> createState() => _TakephotoofcardState();
}

class _TakephotoofcardState extends State<Takephotoofcard> {
  CameraController? _controller;

  @override
  void initState() {
    super.initState();
    availableCameras().then((cameras) {
      _controller = CameraController(cameras[0], ResolutionPreset.medium);
      _controller!.initialize().then((_) {
        if (mounted) setState(() {});
      });
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          "إرسال كارنيه النقابة",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 24.sp,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromRGBO(205, 205, 205, 1)),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_forward_ios, size: 18.sp),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Text(
              'التقط صورة للجهة الأمامية من كارنيه النقابة الطبية',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 24.sp,
                color: Color.fromRGBO(30, 30, 30, 1),
              ),
            ),
            Text(
              'حافظ على وجود الكارنيه في الاطار المحدد',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
                color: Color.fromRGBO(117, 117, 117, 1),
              ),
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Container(
                height: 250.h,
                width: 340.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: Colors.black, // خلفية افتراضية للكاميرا قبل التحميل
                ),
                child: _controller == null || !_controller!.value.isInitialized
                    ? Center(child: CircularProgressIndicator())
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: CameraPreview(_controller!), // 👈 الكاميرا لايف
                      ),
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 30.h,
                      width: 30.w,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/camerarotate.png'),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 90.w),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Facialrecognition();
                          },
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 38,
                          backgroundColor: Color.fromRGBO(13, 91, 227, 1),
                          child: CircleAvatar(
                            radius: 33,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 31,
                              backgroundColor: Color.fromRGBO(13, 91, 227, 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 80.h),
          ],
        ),
      ),
    );
  }
}
