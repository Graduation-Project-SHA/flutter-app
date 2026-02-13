import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../shared/component/customAppbarButton/custom_app_bar_button.dart';

class UserPersonalInformationScreen extends StatefulWidget {
  static const String routeName = "UserPersonalInformationScreen";

  const UserPersonalInformationScreen({super.key});

  @override
  State<UserPersonalInformationScreen> createState() => _UserPersonalInformationScreenState();
}

class _UserPersonalInformationScreenState extends State<UserPersonalInformationScreen> {
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
    String firstName = authBox.get('firstName', defaultValue: "");
    String lastName = authBox.get('lastName', defaultValue: "");

    nameController.text = "$firstName $lastName";
    emailController.text = authBox.get('email', defaultValue: "");
    phoneController.text = authBox.get('phone', defaultValue: "");
    passController.text = "********";

    String? savedImage = authBox.get('profile_image_path');
    if (savedImage != null) {
      _selectedImage = File(savedImage);
    }

    setState(() {});
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
          // onTap: () {
          //   var box = Hive.box('authBox');
          //
          //   box.put('doctor_name', nameController.text);
          //   box.put('doctor_email', emailController.text);
          //   box.put('doctor_phone', phoneController.text);
          //   // box.put('doctor_password', passwordController.text);
          //
          //   Navigator.pop(context);
          // },
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
            SizedBox(height: 24.h),
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
                FocusScope.of(context).unfocus();

                List<String> nameParts = nameController.text.trim().split(" ");

                String firstName = nameParts.isNotEmpty ? nameParts.first : "";
                String lastName =
                nameParts.length > 1 ? nameParts.sublist(1).join(" ") : "";

                authBox.put('firstName', firstName);
                authBox.put('lastName', lastName);
                authBox.put('email', emailController.text);
                authBox.put('phone', phoneController.text);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("تم حفظ التعديلات بنجاح")),
                );

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