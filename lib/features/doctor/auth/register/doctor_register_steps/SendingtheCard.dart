import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../auth/cubit/auth_cubit.dart';
import 'Facialrecognition.dart';

class Sendingthecard extends StatefulWidget {
  const Sendingthecard({super.key});

  @override
  State<Sendingthecard> createState() => _SendingthecardState();
}

class _SendingthecardState extends State<Sendingthecard> {
  final ImagePicker picker = ImagePicker();

  int step = 0;

  File? frontImage;
  File? backImage;

  bool? isFrontClear;
  bool? isBackClear;

  Future<File?> _captureImage() async {
    final XFile? picked = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 40,
    );
    if (picked != null) {
      return File(picked.path);
    }
    return null;
  }

  bool _isImageClear(File img) => img.lengthSync() >= 80 * 1024;

  Future<void> _onCapturePressed() async {
    final img = await _captureImage();
    if (img == null) return;

    final cubit = AuthCubit.get(context);

    if (step == 0) {
      final clear = _isImageClear(img);

      setState(() {
        frontImage = img;
        isFrontClear = clear;
      });

      if (!clear) return;

      cubit.dSyndicateCardFront = img;

      await Future.delayed(const Duration(milliseconds: 200));
      setState(() => step = 1);
    } else {
      final clear = _isImageClear(img);

      setState(() {
        backImage = img;
        isBackClear = clear;
      });

      if (!clear) return;

      cubit.dSyndicateCardBack = img;

      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const Facialrecognition()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isFrontStep = step == 0;

    final titleText = isFrontStep
        ? "التقط صورة للجهة الأمامية من كارنيه النقابة الطبية"
        : "التقط صورة للجهة الخلفية من كارنيه النقابة الطبية";

    const hintText = "حافظ على وجود الكارنيه في الإطار المحدد";

    final statusText = isFrontStep ? isFrontClear : isBackClear;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color.fromRGBO(205, 205, 205, 1)),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: IconButton(
                onPressed: () {
                  if (step == 1) {
                    setState(() => step = 0);
                  } else {
                    Navigator.pop(context);
                  }
                },
                icon: Icon(Icons.arrow_forward_ios, size: 18.sp),
              ),
            ),
          ),
        ],
        centerTitle: true,
        title: Text(
          "إرسال كارنيه النقابة",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 24.sp,
          ),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12.h),

            Text(
              titleText,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
            ),

            SizedBox(height: 6.h),

            Text(
              hintText,
              style: TextStyle(
                fontSize: 20.sp,
                color: const Color.fromRGBO(143, 148, 162, 1),
              ),
            ),

            SizedBox(height: 84.h),


            Center(
              child: Container(
                height: 200.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: const Color.fromRGBO(180, 187, 198, 1),
                    width: 1.w,
                  ),
                  image: (isFrontStep ? frontImage : backImage) != null
                      ? DecorationImage(
                    image: FileImage((isFrontStep ? frontImage : backImage)!),
                    fit: BoxFit.cover,
                  )
                      : null,
                ),
                child: (isFrontStep ? frontImage : backImage) == null
                    ? Center(
                  child: Icon(
                    Icons.image_outlined,
                    size: 40.sp,
                    color: Colors.grey,
                  ),
                )
                    : null,
              ),
            ),

            SizedBox(height: 8.h),


            if (statusText != null)
              Center(
                child: Text(
                  statusText == true ? "الصورة مثالية" : "قم بإعادة التقاط الصورة",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: statusText == true ? Colors.green : Colors.red,
                  ),
                ),
              ),

            Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                GestureDetector(
                  onTap: _onCapturePressed,
                  child: Container(
                    width: 74.w,
                    height: 74.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xff0D5BE3),
                    ),
                    child: Center(
                      child: Container(
                        width: 60.w,
                        height: 60.w,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Container(
                            width: 52.w,
                            height: 52.w,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xff0D5BE3),
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 28.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 20.w),

                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xff0D5BE3), width: 2.w),
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.refresh,
                      color: Color(0xff0D5BE3),
                      size: 22.sp,
                    ),
                    onPressed: () {
                      setState(() {
                        if (isFrontStep) {
                          frontImage = null;
                          isFrontClear = null;
                        } else {
                          backImage = null;
                          isBackClear = null;
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 28.h),
          ],
        ),
      ),
    );
  }
}
