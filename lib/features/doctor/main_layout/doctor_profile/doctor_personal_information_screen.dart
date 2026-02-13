import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care_project/shared/component/customAppbarButton/custom_app_bar_button.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class DoctorPersonalInformationScreen extends StatefulWidget {
  static const String routeName = "DoctorPersonalInformationScreen";

  DoctorPersonalInformationScreen({super.key});

  @override
  State<DoctorPersonalInformationScreen> createState() => _DoctorPersonalInformationScreenState();
}

class _DoctorPersonalInformationScreenState extends State<DoctorPersonalInformationScreen> {

  late Box authBox;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    authBox = Hive.box('authBox');
    _loadData();
  }


  void _loadData() {
    nameController.text = authBox.get('doctor_name', defaultValue: "د.ريم حسام");
    emailController.text = authBox.get('doctor_email', defaultValue: "email@gmail.com");
    phoneController.text = authBox.get('doctor_phone', defaultValue: "+20123456789");
    passController.text = "********";

    String? savedImage = authBox.get('profile_image_path');
    if (savedImage != null) {
      _selectedImage = File(savedImage);
    }
  }


  Future<void> pickImage() async {
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [CustomAppBarBtn(
        )],
        automaticallyImplyLeading: false,
        title: Text("معلومات شخصية",
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600,color: Colors.black)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: 48.h,),
            Stack(
              children:[
                GestureDetector(
                  onTap: pickImage,
                  child: CircleAvatar(
                    radius: 55.r,
                    backgroundImage:
                    _selectedImage != null ? FileImage(_selectedImage!) : null,
                    child: _selectedImage == null ? Icon(Icons.add_a_photo, size: 30.sp) : null,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 15.r,
                    backgroundColor: Color(0xffF2F4F7),
                    child: Icon(Icons.edit, size: 16.sp, color: Colors.blueAccent),
                  ),
                ),
              ],
            ),
            SizedBox(height: 51.h),
            _buildInput("الاسم", nameController),
            SizedBox(height: 24.h),
            _buildInput("البريد الإلكتروني", emailController),
            SizedBox(height: 24.h),
            _buildInput("رقم الهاتف", phoneController),
            SizedBox(height: 24.h),
            _buildInput("كلمة المرور", passController),
            SizedBox(height: 24.h),
            Text("عندما تقوم بإعداد إعدادات المعلومات الشخصية الخاصة بك، يجب عليك الحرص على تقديم معلومات دقيقة.",style: TextStyle(color: Color(0xff757575)),),
            SizedBox(height: 24.h),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff247CFF),
                minimumSize: Size(double.infinity, 52.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r)),
              ),
              onPressed: () {
                authBox.put('doctor_name', nameController.text);
                authBox.put('doctor_email', emailController.text);
                authBox.put('doctor_phone', phoneController.text);
                Navigator.pop(context);
              },
              child: Text("حفظ", style: TextStyle(fontSize: 16.sp)),
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildInput(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        fillColor:Color(0xffEDEDED) ,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color:Color(0xffEDEDED),),
          borderRadius: BorderRadius.circular(12.r),
        ),

        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }
}