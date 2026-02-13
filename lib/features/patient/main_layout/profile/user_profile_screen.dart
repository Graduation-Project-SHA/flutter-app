import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileScreen extends StatefulWidget {
  static const String routeName = "UserProfileScreen";

  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late Box authBox;

  String name = "";
  String email = "";
  String phone = "";

  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    authBox = Hive.box('authBox');
    _loadData();
  }


  void _loadData() {
    setState(() {

      String firstName = authBox.get('firstName', defaultValue: "");
      String lastName = authBox.get('lastName', defaultValue: "");

      name = "$firstName $lastName";
      email = authBox.get('email', defaultValue: "");
      phone = authBox.get('phone', defaultValue: "");

      String? imagePath = authBox.get('profile_image_path');
      if (imagePath != null) {
        _selectedImage = File(imagePath);
      }
    });
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });

      authBox.put('profile_image_path', image.path);

    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xff247CFF),
      body: SafeArea(
        bottom: false,
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: 180.h,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              color: const Color(0xff247CFF),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.settings_outlined, color: Colors.white, size: 24.sp),
                  Text(
                    "حسابي",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios_outlined, color: Colors.white, size: 20.sp),
                ],
              ),
            ),
            Positioned(
              top: 148.h,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.r),
                    topRight: Radius.circular(24.r),
                  ),
                ),

                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.r),
                    topRight: Radius.circular(24.r),
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      children: [
                        SizedBox(height: 60.h),
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          email,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
                          decoration: BoxDecoration(
                            color: const Color(0xffF8F8F8),
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: IntrinsicHeight(
                            child: Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {},
                                    borderRadius: BorderRadius.circular(10.r),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 16.h),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "خدماتي",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff242424),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                VerticalDivider(
                                  color: Colors.grey.shade300,
                                  thickness: 1.5,
                                  indent: 10.h,
                                  endIndent: 10.h,
                                  width: 20.w,
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {},
                                    borderRadius: BorderRadius.circular(10.r),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 16.h),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "حجوزاتي",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff242424),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height:24.h),

                        _buildOptionItem(
                          image:"assets/images/personalcard.png",
                          color: Colors.blue,
                          title: "معلومات شخصية",
                          onTap: () {
                            Navigator.pushNamed(context, "UserPersonalInformationScreen").then((_) {
                              _loadData();
                            });
                          },
                        ),
                        _buildOptionItem(
                          image: "assets/images/review.png",
                          color: Colors.green,
                          title: "تقييماتي",
                          onTap: (){},
                        ),
                        _buildOptionItem(
                          image: "assets/images/wallet.png",
                          color: Colors.redAccent,
                          title: "طرق الدفع",
                          onTap: (){
                            Navigator.pushNamed(context, "UserPaymentMethodsScreen");
                          },
                        ),
                        _buildOptionItem(
                          image: "assets/images/clock.png",
                          color: Colors.purple,
                          title: "السجل الطبي",
                          isLast: true,
                          onTap: () {
                            Navigator.pushNamed(context, "MedicalRecordScreen");
                          },
                        ),
                        SizedBox(height:16.h),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 90.h,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4.w),
                    ),
                    child: CircleAvatar(
                      radius: 50.r,
                      backgroundImage: _selectedImage != null
                          ? FileImage(_selectedImage!)
                          : const AssetImage("assets/images/person_image.png") as ImageProvider,
                    ),
                  ),
                  InkWell(
                    onTap: _pickImage,
                    child: Container(
                      height: 30.h,
                      width: 30.w,
                      decoration: const BoxDecoration(
                        color: Colors.black12,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.edit, color: Colors.blue, size: 16.sp),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionItem({
    required String image,
    required Color color,
    required String title,
    bool isLast = false,
    VoidCallback? onTap,

  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10.sp),
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child:Image.asset(image),
                ),
                SizedBox(width:13.w),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff242424),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (!isLast) Divider(color: Color(0xffEDEDED), height: 1),
      ],
    );
  }
}