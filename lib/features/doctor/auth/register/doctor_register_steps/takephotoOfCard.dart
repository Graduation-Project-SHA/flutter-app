import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care_project/features/doctor/auth/register/doctor_register_steps/Facialrecognition.dart';
import '../../../../auth/cubit/auth_cubit.dart';

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
    _initializeCamera();
  }

  void _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        _controller = CameraController(cameras[0], ResolutionPreset.medium);
        await _controller!.initialize();
        if (mounted) setState(() {});
      }
    } catch (e) {
      print("Error initializing camera: $e");
    }
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
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromRGBO(205, 205, 205, 1)),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
                icon: Icon(Icons.arrow_forward_ios, size: 18.sp),
              ),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("إرسال كارنيه النقابة",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 24.sp)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: 30.h),
            Text('التقط صورة للجهة الأمامية من كارنيه النقابة الطبية',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24.sp)),
            SizedBox(height: 8.h),
            Text('حافظ على وجود الكارنيه في الاطار المحدد',
                style: TextStyle(fontWeight: FontWeight.w200, fontSize:20.sp)),
            SizedBox(height: 30.h),

            Container(
              height: 250.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: Colors.blue, width: 2),
              ),
              child: _controller == null || !_controller!.value.isInitialized
                  ? const Center(child: CircularProgressIndicator())
                  : ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: CameraPreview(_controller!),
              ),
            ),

            const Spacer(),


            Padding(
              padding: EdgeInsets.only(bottom: 50.h),
              child: GestureDetector(
                onTap: () async {
                  if (_controller != null && _controller!.value.isInitialized) {
                    final image = await _controller!.takePicture();
                    AuthCubit.get(context).syndicateCardPath = image.path;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Facialrecognition()),
                    );
                  }
                },
                child: CircleAvatar(
                  radius: 38.r,
                  backgroundColor: const Color(0xff0D5BE3),
                  child: CircleAvatar(
                    radius: 33.r,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 30.r,
                      backgroundColor: const Color(0xff0D5BE3),
                      child: Icon(Icons.camera_alt, color: Colors.white, size: 30.sp),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}