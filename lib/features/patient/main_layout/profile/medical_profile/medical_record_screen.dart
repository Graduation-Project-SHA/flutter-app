import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../shared/component/customAppbarButton/custom_app_bar_button.dart';
import '../../../../../shared/component/defaultbutton/defaultbutton.dart';
import 'medical_profile_cubit.dart';
import 'medical_profile_model.dart';
import 'medical_profile_state.dart';

class MedicalRecordScreen extends StatefulWidget {
  static const String routeName = "MedicalRecordScreen";

  const MedicalRecordScreen({super.key});

  @override
  State<MedicalRecordScreen> createState() => _MedicalRecordScreenState();
}

class _MedicalRecordScreenState extends State<MedicalRecordScreen> {
  late Box authBox;
  File? _selectedImage;
  Map<String, dynamic> getBMIDetails(double bmi) {
    if (bmi < 18.5) {
      return {"status": "(نحافة)", "color": const Color(0xffFFCC00)};
    } else if (bmi >= 18.5 && bmi < 25) {
      return {"status": "(طبيعي)", "color": const Color(0xff22C55E)};
    } else if (bmi >= 25 && bmi < 30) {
      return {"status": "(زيادة وزن)", "color": const Color(0xffF97316)};
    } else {
      return {"status": "(سمنة مفرطة)", "color": const Color(0xffEF4444)};
    }
  }
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final allergiesController = TextEditingController();
  final chronicDiseasesController = TextEditingController();
  final medicationsController = TextEditingController();
  final emergencyNameController = TextEditingController();
  final emergencyPhoneController = TextEditingController();
  bool isPasswordHidden = true;
  String selectedGender = "ذكر";
  final birthDateController = TextEditingController();
  final bmiController = TextEditingController();

  String selectedBloodType = "A_POSITIVE";

  final Map<String, String> bloodTypeMap = {
    "A_POSITIVE": "A+",
    "A_NEGATIVE": "A-",
    "B_POSITIVE": "B+",
    "B_NEGATIVE": "B-",
    "O_POSITIVE": "O+",
    "O_NEGATIVE": "O-",
    "AB_POSITIVE": "AB+",
    "AB_NEGATIVE": "AB-",
  };

  @override

  void initState() {
    super.initState();
    authBox = Hive.box('authBox');
    _loadLocalImage();
    context.read<MedicalProfileCubit>().getFullProfile();

    heightController.addListener(_calculateBMI);
    weightController.addListener(_calculateBMI);
  }

  void _calculateBMI() {
    double h = double.tryParse(heightController.text) ?? 0;
    double w = double.tryParse(weightController.text) ?? 0;
    if (h > 50 && w > 2) {
      setState(() {
        bmiController.text = (w / ((h / 100) * (h / 100))).toStringAsFixed(1);
      });
    }
    else {
      setState(() {
        bmiController.text = "0";
      });
    }
  }


  @override
  void dispose() {
    heightController.removeListener(_calculateBMI);
    weightController.removeListener(_calculateBMI);
    super.dispose();
  }

  void _loadLocalImage() {
    String? path = authBox.get('profile_image_path');
    if (path != null) {
      setState(() => _selectedImage = File(path));
    }
  }

  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() => _selectedImage = File(image.path));
      authBox.put('profile_image_path', image.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MedicalProfileCubit, MedicalProfileState>(
        listener: (context, state) {
          if (state is MedicalProfileSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("تم تحديث بياناتك بالكامل")),
            );
          }
          else if (state is MedicalProfileLoaded) {
            _fillFields(state.profile, state.medical);
          }
          else if (state is MedicalProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },

      child: Scaffold(
        backgroundColor: const Color(0xffF8F9FB),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: [CustomAppBarBtn()],
          title: Text(
            "معلومات شخصية",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(18.w),
            child: Column(
              children: [
                _buildImageHeader(),
                SizedBox(height: 20.h),

                _buildSectionCard(
                  imagePath: "assets/images/card1_in_pi.png",
                  children: [
                    _buildInputField("الاسم", nameController),
                    SizedBox(height: 16.h),
                    _buildInputField("البريد الإلكتروني", emailController,isEnabled:false),
                    SizedBox(height: 16.h),
                    _buildPasswordField(isEnabled:false),
                    SizedBox(height: 16.h),
                    _buildDateField(),
                    SizedBox(height: 16.h),
                    _buildInputField("رقم الهاتف", phoneController),
                    SizedBox(height: 16.h),
                    _buildGenderField(),
                    SizedBox(height: 24.h),
                    Text(
                      "عندما تقوم بإعداد إعدادات المعلومات الشخصية الخاصة بك، يجب عليك الحرص على تقديم معلومات دقيقة.",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Color(0xFF757575),
                        height: 1.5,
                      ),
                    ),

                  ],
                ),

                SizedBox(height: 24.h),

                _buildSectionCard(
                  imagePath: "assets/images/card2_in_pi.png",
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _buildInputField("الوزن (كجم)", weightController),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: _buildInputField("الطول(سم)", heightController),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    _buildBloodTypeDropdown(),
                    SizedBox(height: 16.h),
                    _buildBMIContainer(),
                    SizedBox(height: 24.h),
                    Text(
                   " عندما تقوم بإعداد إعدادات المعلومات الشخصية الخاصة بك، يجب عليك الحرص على تقديم معلومات دقيقة.",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Color(0xFF757575),
                        height: 1.5,
                      ),
                    ),

                  ],
                ),


                SizedBox(height: 24.h),

                _buildSectionCard(

                  imagePath: "assets/images/card3_in_pi.png",
                  children: [
                    _buildInputField(
                      "الأمراض المزمنة",
                      chronicDiseasesController,
                    ),
                    _buildInputField("الحساسية", allergiesController),
                    _buildInputField(
                      "الأدوية الحالية",
                      medicationsController,
                    ),
                  ],
                ),

                SizedBox(height: 24.h),

                _buildSectionCard(
                  imagePath: "assets/images/card4_in_pi.png",
                  children: [
                    _buildInputField(
                      "اسم جهة الاتصال",
                      emergencyNameController,
                    ),
                    _buildInputField(
                      "رقم الهاتف",
                      emergencyPhoneController,
                    ),
                  ],
                ),

                SizedBox(height: 64.h),

                BlocBuilder<MedicalProfileCubit, MedicalProfileState>(
                  builder: (context, state) {
                    if (state is MedicalProfileLoading) {
                      return const CircularProgressIndicator();
                    }

                    return DefaultButton(
                      onPressed: _saveData,
                      buttonText: "حفظ",
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _fillFields(Map p, Map m) {
    setState(() {
      nameController.text = "${p['firstName']} ${p['lastName']}";
      emailController.text = p['email'] ?? "";
      phoneController.text = p['phone'] ?? "";
      heightController.text = (m['height'] ?? "").toString();
      weightController.text = (m['weight'] ?? "").toString();
      allergiesController.text = m['allergies'] ?? "";
      chronicDiseasesController.text = m['chronicDiseases'] ?? "";
      medicationsController.text = m['currentMedications'] ?? "";
      emergencyNameController.text = m['emergencyContact'] ?? "";
      emergencyPhoneController.text = m['emergencyPhone'] ?? "";
      birthDateController.text = p['dateOfBirth']?.split('T')[0] ?? "";
      selectedGender = p['gender'] == "MALE" ? "ذكر" : "أنثى";
      selectedBloodType = m['bloodType'] ?? "A_POSITIVE";

      _calculateBMI();
    });
  }

  void _saveData() {
    List<String> nameParts = nameController.text.trim().split(" ");

    String fName = nameParts.isNotEmpty ? nameParts.first : "";
    String lName =
    nameParts.length > 1 ? nameParts.sublist(1).join(" ") : "";
    String genderForApi = selectedGender == "ذكر" ? "MALE" : "FEMALE";
    final medicalModel = MedicalProfileModel(
      bloodType: selectedBloodType,
      height: int.tryParse(heightController.text) ?? 0,
      weight: int.tryParse(weightController.text) ?? 0,
      allergies: allergiesController.text,
      chronicDiseases: chronicDiseasesController.text,
      currentMedications: medicationsController.text,
      emergencyContact: emergencyNameController.text,
      emergencyPhone: emergencyPhoneController.text,

    );

    context.read<MedicalProfileCubit>().updateFullProfile(
      firstName: fName,
      lastName: lName,
      medicalModel: medicalModel,
      phone: phoneController.text,
      gender: genderForApi,
      dateOfBirth: birthDateController.text,

    );
  }

  Widget _buildImageHeader() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            GestureDetector(
              onTap: pickImage,
              child: CircleAvatar(
                radius: 48.r,
                backgroundColor: const Color(0xffE9EEF8),
                backgroundImage:
                _selectedImage != null ? FileImage(_selectedImage!) : null,
                child: _selectedImage == null
                    ? Icon(
                  Icons.person,
                  size: 45.sp,
                  color: Colors.grey,
                )
                    : null,
              ),
            ),
            CircleAvatar(
              radius: 15.r,
              backgroundColor:Color(0xFFF2F4F7) ,
              child: Icon(
                Icons.edit,
                size: 16.sp,
                color: const Color(0xff2B73F3),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Text(
          "انقر على القلم لتحديث الصورة",
          style: TextStyle(
            color: Color(0xFF6B7280),
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }


  Widget _buildSectionCard({
    required List<Widget> children,
    required String imagePath,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Image.asset(
              imagePath,
              width: double.infinity,
              height: 64.h,
              fit: BoxFit.cover,
            ),
          ),

          SizedBox(height: 24.h),

          ...children,
        ],
      ),
    );
  }
  Widget _buildInputField(
      String title,
      TextEditingController controller,
      {bool isEnabled = true}
      ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12.sp,
              color: Color(0xFF6C7278),
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 5.h),
          TextFormField(
            controller: controller,
            enabled: isEnabled,
            textDirection: TextDirection.rtl,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xffF8F9FB),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 14.w,
                vertical: 14.h,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBloodTypeDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "فصيلة الدم",
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
              color: Color(0xFF6C7278)
          ),
        ),
        SizedBox(height: 5.h),
        DropdownButtonFormField<String>(
          value: selectedBloodType,
          items: bloodTypeMap.entries
              .map(
                (e) => DropdownMenuItem(
              value: e.key,
              child: Text(e.value),
            ),
          )
              .toList(),
          onChanged: (v) {
            setState(() {
              selectedBloodType = v!;
            });
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xffF8F9FB),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField({bool isEnabled = true,}) {

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "تأكيد كلمة السر",
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: Color(0xFF6C7278)
            ),
          ),
          SizedBox(height: 6.h),
          TextFormField(
            controller: passController,
          enabled: isEnabled,
            obscureText: isPasswordHidden,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xffF8F9FB),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isPasswordHidden = !isPasswordHidden;
                  });
                },
                icon: Icon(
                  isPasswordHidden
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateField() {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "تاريخ الميلاد",
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
               color: Color(0xFF6C7278)
            ),
          ),
          SizedBox(height: 6.h),
          TextFormField(
            controller: birthDateController,
            readOnly: true,
            onTap: () async {
              DateTime? picked = await showDatePicker(
                context: context,
                firstDate: DateTime(1950),
                lastDate: DateTime.now(),
                initialDate: DateTime.now(),
              );

              if (picked != null) {
                birthDateController.text =
                "${picked.year}-${picked.month}-${picked.day}";
              }
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xffF8F9FB),
              suffixIcon: const Icon(Icons.calendar_month),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenderField() {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "النوع",
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: Color(0xFF6C7278)
            ),
          ),
          SizedBox(height: 6.h),
          DropdownButtonFormField<String>(
            value: selectedGender,
            items: const [
              DropdownMenuItem(
                value: "ذكر",
                child: Text("ذكر"),
              ),
              DropdownMenuItem(
                value: "أنثى",
                child: Text("أنثى"),
              ),
            ],
            onChanged: (v) {
              setState(() {
                selectedGender = v!;
              });
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xffF8F9FB),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBMIContainer() {
    double bmiValue = double.tryParse(bmiController.text) ?? 0;

    if (bmiValue == 0) return const Text("برجاء إدخال الطول والوزن صحيحاً");

    var details = getBMIDetails(bmiValue);
    Color mainColor = details['color'];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: mainColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: mainColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerRight,
              child: Row(
                children: [
                  Text(
                    details['status'],
                    style: TextStyle(
                      color: mainColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    bmiValue > 999 ? "999+" : bmiValue.toStringAsFixed(1),
                    style: TextStyle(
                      color: mainColor,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Flexible(
            child: Text(
              "مؤشر كتلة الجسم (BMI)",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: const Color(0xFF374151),
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
