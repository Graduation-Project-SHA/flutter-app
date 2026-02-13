import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_project/features/auth/register/verify_email.dart';
import 'package:intl/intl.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/ theme/app_colors.dart';
import '../../../shared/component/defaultTextFormField/defaultTextFormField.dart';
import '../../../shared/component/defaultbutton/defaultbutton.dart';
import '../../doctor/auth/register/doctor_register_steps/SendingtheCard.dart';
import '../../doctor/auth/register/doctor_register_steps/Specialization_data.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../login/login_screen.dart';

class RegisterUserScreen extends StatefulWidget {
  static const String routeName = "RegisterUserScreen";
  const RegisterUserScreen({super.key});

  @override
  State<RegisterUserScreen> createState() => _RegisterUserScreenState();
}

class _RegisterUserScreenState extends State<RegisterUserScreen> {
  int currentIndex = 0;
  bool isDoctor = false;
  bool isSubmitted = false;
  bool isRegisterTabSelected = true;
  String selectedGender = '';
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  String fullPhoneNumber = '';
  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isPasswordMatched = true;
  bool hasUpperLower = false;
  bool hasNumber = false;
  bool hasSymbol = false;
  bool hasMinLength = false;
  int currentStep = 0;
  String profileImagePath = "assets/images/default_user.png";


  String? selectedSpecialization;

  final TextEditingController bioController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();

  double currentLat = 30.0444;
  double currentLng = 31.2357;

  String? syndicateCardFrontPath;
  String? syndicateCardBackPath;

  void _navigateToLogin() {
    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.pushNamedAndRemoveUntil(
        context,
        Loginscreen.routeName,
            (route) => false,
      );
    });
  }

  Future<void> _pickDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        birthDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Widget buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h, top: 8.h),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
          color: const Color.fromRGBO(90, 97, 104, 1),
        ),
      ),
    );
  }

  void _validateEmail(String value) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    setState(() {
      isEmailValid = emailRegex.hasMatch(value);
    });
  }

  void _validatePassword(String value) {
    setState(() {
      hasUpperLower = value.contains(RegExp(r'(?=.*[a-z])(?=.*[A-Z])'));
      hasNumber = value.contains(RegExp(r'[0-9]'));
      hasSymbol = value.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>/]'));
      hasMinLength = value.length >= 8;
      isPasswordValid = hasUpperLower && hasNumber && hasSymbol && hasMinLength;
      isPasswordMatched =
          passwordController.text == confirmPasswordController.text;
    });
  }

  Widget _buildCheck(String text, bool condition) {
    return Row(
      children: [
        Icon(
          condition ? Icons.check_circle : Icons.cancel,
          color: condition ? Colors.green : Colors.redAccent,
          size: 18.sp,
        ),
        SizedBox(width: 6.w),
        Text(
          text,
          style: TextStyle(
            color: condition ? Colors.green : Colors.redAccent,
            fontSize: 13.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildUserTypeSelector() {
    const Color selectedColor = Color.fromRGBO(154, 185, 239, 0.55);
    const Color unselectedColor = Color.fromRGBO(237, 241, 243, 1);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isDoctor = false;
            });
          },
          child: Container(
            height: 119.h,
            width: 99.w,
            decoration: BoxDecoration(
              color: isDoctor ? unselectedColor : selectedColor,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: isDoctor ? unselectedColor : AppColors.primaryBlue,
                width: 1,
              ),
            ),
            child: Column(
              children: [
                Expanded(child: Image.asset('assets/images/user_logo.png')),
                Text(
                  "مستخدم عادي",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 20.w),
        GestureDetector(
          onTap: () {
            setState(() {
              isDoctor = true;
            });
          },
          child: Container(
            height: 119.h,
            width: 99.w,
            decoration: BoxDecoration(
              color: isDoctor ? selectedColor : unselectedColor,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: isDoctor ? AppColors.primaryBlue : unselectedColor,
                width: 1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Image.asset('assets/images/doctor_logo.png')),
                SizedBox(height: 8.h),
                Text(
                  "أنا طبيب",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGenderSelector() {
    const Color selectedColor = Color.fromRGBO(154, 185, 239, 0.55);
    const Color unselectedColor = Color.fromRGBO(237, 241, 243, 1);
    final borderColorIfError = (isSubmitted && selectedGender.isEmpty)
        ? Colors.redAccent
        : Colors.grey.shade300;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildLabel("النوع"),
        SizedBox(height: 6.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedGender = 'male';
                });
              },
              child: Container(
                height: 60.h,
                width: 120.w,
                decoration: BoxDecoration(
                  color: selectedGender == 'male'
                      ? selectedColor
                      : unselectedColor,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: selectedGender == 'male'
                        ? AppColors.primaryBlue
                        : borderColorIfError,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.male,
                      color: selectedGender == 'male'
                          ? AppColors.primaryBlue
                          : Colors.grey,
                      size: 22.sp,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      "ذكر",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedGender = 'female';
                });
              },
              child: Container(
                height: 60.h,
                width: 120.w,
                decoration: BoxDecoration(
                  color: selectedGender == 'female'
                      ? selectedColor
                      : unselectedColor,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: selectedGender == 'female'
                        ? AppColors.primaryBlue
                        : borderColorIfError,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.female,
                      color: selectedGender == 'female'
                          ? AppColors.primaryBlue
                          : Colors.grey,
                      size: 22.sp,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      "أنثى",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAuthTabBar() {
    const Color selectedBackground = Color.fromRGBO(27, 106, 243, 1);
    const Color unselectedBackground = Color.fromARGB(255, 220, 218, 218);

    return Container(
      height: 47.h,
      decoration: BoxDecoration(
        color: unselectedBackground,
        borderRadius: BorderRadius.circular(8.r),
      ),

      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                _navigateToLogin();
                setState(() {
                  isRegisterTabSelected = false;
                });
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.w,
                    color: Color.fromRGBO(255, 255, 255, .5),
                  ),
                  borderRadius: BorderRadius.circular(6.r),
                  color: isRegisterTabSelected
                      ? unselectedBackground
                      : selectedBackground,
                ),
                child: Text(
                  "تسجيل الدخول",
                  style: TextStyle(
                    color: isRegisterTabSelected ? Colors.black : Colors.white,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isRegisterTabSelected = true;
                });
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.r),
                  color: isRegisterTabSelected
                      ? selectedBackground
                      : unselectedBackground,
                ),
                child: Text(
                  "إنشاء حساب",
                  style: TextStyle(
                    color: isRegisterTabSelected ? Colors.white : Colors.black,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget firstForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildLabel("الاسم الاول"),
                  Defaulttextformfield(
                    controller: firstNameController,
                    hintText: "الاسم الاول",
                    borderColor:
                    (isSubmitted && firstNameController.text.isEmpty)
                        ? Colors.redAccent
                        : null,
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildLabel("الاسم الأخير"),
                  Defaulttextformfield(
                    controller: lastNameController,
                    hintText: "الاسم الأخير",
                    borderColor:
                    (isSubmitted && lastNameController.text.isEmpty)
                        ? Colors.redAccent
                        : null,
                  ),
                ],
              ),
            ),
          ],
        ),

        SizedBox(height: 16.h),

        buildLabel("البريد الإلكتروني"),
        Defaulttextformfield(
          controller: emailController,
          hintText: "example@email.com",
          onChanged: _validateEmail,
          suffixIcon: Icon(
            isEmailValid ? Icons.check_circle : Icons.cancel,
            color: isEmailValid ? AppColors.green : Colors.redAccent,
            size: 22.sp,
          ),
          borderColor: (isSubmitted && !isEmailValid) ? Colors.redAccent : null,
        ),

        SizedBox(height: 16.h),

        buildLabel("رقم الهاتف"),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: (isSubmitted && fullPhoneNumber.isEmpty)
                  ? Colors.redAccent
                  : Colors.grey.shade400,
            ),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: PhoneFormField(
            countrySelectorNavigator:
            const CountrySelectorNavigator.modalBottomSheet(),
            decoration: InputDecoration(
              hintText: '0123456789',
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                vertical: 16.h,
                horizontal: 10.w,
              ),
            ),
            countryButtonStyle: const CountryButtonStyle(showFlag: true),
            onChanged: (phoneNumber) {
              if (phoneNumber != null) {
                fullPhoneNumber = phoneNumber.international;
              }
            },
          ),
        ),

        SizedBox(height: 16.h),

        buildLabel("تاريخ الميلاد"),
        GestureDetector(
          onTap: () => _pickDate(context),
          child: AbsorbPointer(
            child: Defaulttextformfield(
              controller: birthDateController,
              hintText: "01-03-2004",
              suffixIcon: Icon(
                Icons.calendar_today_rounded,
                color: Colors.grey,
                size: 20.sp,
              ),
              borderColor: (isSubmitted && birthDateController.text.isEmpty)
                  ? Colors.redAccent
                  : null,
            ),
          ),
        ),
        SizedBox(height: 16.h),

        _buildGenderSelector(),

        SizedBox(height: 16.h),

        buildLabel("كلمة المرور"),
        Defaulttextformfield(
          controller: passwordController,
          hintText: "••••••••",
          obscureText: obscurePassword,
          onChanged: _validatePassword,
          suffixIcon: IconButton(
            icon: Icon(
              obscurePassword ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
              size: 22.sp,
            ),
            onPressed: () {
              setState(() {
                obscurePassword = !obscurePassword;
              });
            },
          ),
          borderColor:
          (isSubmitted &&
              (!isPasswordValid || passwordController.text.isEmpty))
              ? Colors.redAccent
              : null,
        ),

        SizedBox(height: 16.h),

        buildLabel("تأكيد كلمة المرور"),
        Defaulttextformfield(
          controller: confirmPasswordController,
          hintText: "••••••••",
          obscureText: obscureConfirmPassword,
          onChanged: (val) {
            _validatePassword(passwordController.text);
            setState(() {
              isPasswordMatched = val == passwordController.text;
            });
          },
          suffixIcon: IconButton(
            icon: Icon(
              obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
              size: 22.sp,
            ),
            onPressed: () {
              setState(() {
                obscureConfirmPassword = !obscureConfirmPassword;
              });
            },
          ),
          borderColor: (isSubmitted && !isPasswordMatched)
              ? Colors.redAccent
              : null,
        ),

        SizedBox(height: 14.h),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCheck("كلمة السر تحتوي على 8 أحرف", hasMinLength),
            _buildCheck("تحتوي على حرف كبير وصغير", hasUpperLower),
            _buildCheck("تحتوي على رقم", hasNumber),
            _buildCheck("تحتوي على رمز مثل @ أو /", hasSymbol),
            _buildCheck("كلمة السر متطابقة", isPasswordMatched),
          ],
        ),

        SizedBox(height: 24.h),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: (isDoctor && currentIndex == 1 || isDoctor && currentIndex == 2)
            ? AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Text(
            currentIndex == 1
                ? 'بيانات التخصص'
                : currentIndex == 2
                ? "إرسال كارنيه النقابة"
                : "",
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
                  border: Border.all(
                    color: Color.fromRGBO(205, 205, 205, 1),
                  ),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      currentIndex -= 1;
                    });
                  },
                  icon: Icon(Icons.arrow_forward_ios, size: 18.sp),
                ),
              ),
            ),
          ],
        )
            : null,
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is RegisterSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("تم إنشاء الحساب بنجاح"),
                  backgroundColor: Colors.green,
                ),
              );

              var cubit = AuthCubit.get(context);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider.value(
                    value: cubit,
                    child: VerifyEmailScreen(
                      email: emailController.text,
                      firstName: firstNameController.text,
                    ),
                  ),
                ),
              );
            } else if (state is RegisterErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.redAccent,
                  duration: Duration(seconds: 3),
                ),
              );
            }
          },
          builder: (context, state) {
            bool isLoading = state is RegisterLoadingState;

            return SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15.h),

                    if (isDoctor && (currentIndex == 0 || currentIndex == 1) ||
                        !isDoctor) ...[
                      _buildUserTypeSelector(),
                      SizedBox(height: 25.h),
                      _buildAuthTabBar(),
                      SizedBox(height: 25.h),
                    ],

                    if (isDoctor)
                      if (currentIndex == 0)
                        SizedBox(
                          height: 30.h,
                          width: 380.w,
                          child: Image.asset('assets/images/progress_bar1.png'),
                        )
                      else if (currentIndex == 1)
                        SizedBox(
                          height: 30.h,
                          width: 380.w,
                          child: Image.asset('assets/images/progress_bar2.png'),
                        )
                      else
                        SizedBox(
                          height: 30.h,
                          width: 380.w,
                          child: Image.asset('assets/images/progress_bar3.png'),
                        ),
                    if (!isDoctor)
                      firstForm()
                    else if (isDoctor && currentIndex == 0)
                      firstForm()
                    else if (isDoctor && currentIndex == 1)
                       SpecializationData(
                          selectedSpecialization: selectedSpecialization,
                          onSpecializationChanged: (val) {
                            setState(() {
                              selectedSpecialization = val;
                            });
                          },
                          bioController: bioController,
                          experienceController: experienceController,
                        )
                      else if (isDoctor && currentIndex == 2)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'لماذا ارسل كارنيه النقابة؟',
                                  style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w700),
                                ),
                                SizedBox(height: 10.h),
                                Sendingthecard(
                                  label: "وجه الكارنيه",
                                  syndicateCardPath: syndicateCardFrontPath,
                                  onImagePicked: (path) => setState(() => syndicateCardFrontPath = path),
                                ),
                                SizedBox(height: 15.h),
                                Sendingthecard(
                                  label: "ظهر الكارنيه",
                                  syndicateCardPath: syndicateCardBackPath,
                                  onImagePicked: (path) => setState(() => syndicateCardBackPath = path),
                                ),
                              ],
                            ),
                    SizedBox(height: 25.h),
                    DefaultButton(
                      onPressed: isLoading
                          ? null
                          : () {
                        setState(() {
                          isSubmitted = true;
                        });


                        if (firstNameController.text.isEmpty ||
                            lastNameController.text.isEmpty ||
                            emailController.text.isEmpty ||
                            fullPhoneNumber.isEmpty ||
                            birthDateController.text.isEmpty ||
                            passwordController.text.isEmpty ||
                            confirmPasswordController.text.isEmpty ||
                            selectedGender.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("من فضلك املأ كل الحقول المطلوبة"),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                          return;
                        }

                        if (!isPasswordMatched || !isPasswordValid) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("تأكد من صحة كلمة المرور"),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                          return;
                        }

                        if (selectedGender.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("من فضلك اختر النوع (ذكر/أنثى)")),
                          );
                          return;
                        }
                        if (isDoctor) {
                          if (currentIndex == 0) {
                            setState(() => currentIndex = 1);
                            return;
                          }

                          if (currentIndex == 1) {
                            if (selectedSpecialization == null ||
                                bioController.text.isEmpty ||
                                experienceController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("من فضلك أكمل بيانات التخصص"),
                                  backgroundColor: Colors.redAccent,
                                ),
                              );
                              return;
                            }
                            setState(() => currentIndex = 2);
                            return;
                          }

                          if (currentIndex == 2) {
                            if (syndicateCardFrontPath == null || syndicateCardBackPath == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("من فضلك أرسل صورة الكارنيه (وجه وظهر)"),
                                  backgroundColor: Colors.redAccent,
                                ),
                              );
                              return;
                            }

                            AuthCubit.get(context).registerDoctor(
                              firstName: firstNameController.text,
                              lastName: lastNameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              phone: fullPhoneNumber,
                              gender: selectedGender,
                              dateOfBirth: birthDateController.text,
                              //profileImagePath: profileImagePath!,

                              specialization: selectedSpecialization!,
                              bio: bioController.text,
                              practicalExperience: experienceController.text,
                              latitude: currentLat,
                              longitude: currentLng,

                              syndicateCardPath: syndicateCardFrontPath!,
                              syndicateCardBackPath: syndicateCardBackPath!,
                            );
                          }
                        }

                        else {
                          AuthCubit.get(context).registerUser(
                            firstName: firstNameController.text,
                            lastName: lastNameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            phone: fullPhoneNumber,
                            gender: selectedGender,
                            dateOfBirth: birthDateController.text,
                           // profileImagePath: profileImagePath,
                          );
                        }
                      },

                      buttonText: isDoctor
                          ? (currentIndex == 2 ? "إنهاء التسجيل" : "التالي")
                          : "إنشاء حساب",
                    ),

                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}