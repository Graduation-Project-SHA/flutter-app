import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../auth/cubit/auth_cubit.dart';
import '../../../../auth/cubit/auth_state.dart';
import '../../../../auth/register/verify_email.dart';

class Facialrecognition extends StatefulWidget {
  const Facialrecognition({super.key});

  @override
  State<Facialrecognition> createState() => _FacialrecognitionState();
}

class _FacialrecognitionState extends State<Facialrecognition> {
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => VerifyEmailScreen(
                email: AuthCubit.get(context).dEmail ?? "",
                firstName: AuthCubit.get(context).dFirstName ?? "",
              ),
            ),
                (route) => false,
          );
        } else if (state is RegisterErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        bool isLoading = state is RegisterLoadingState;

        return Scaffold(
          appBar: AppBar(
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
            surfaceTintColor: Colors.white,
            automaticallyImplyLeading: false,
            title: Text("التعرف علي الوجه",
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 24.sp)),
          ),
          body: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),
                  Text('التأكد من ملكية الكارنيه',
                      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600)),
                  SizedBox(height: 8.h),
                  Text('إذا كان هناك اي بيانات غير صحيحة قم بإعادة تصوير الكارنيه',
                      style: TextStyle(fontSize: 16.sp, color: const Color.fromRGBO(117, 117, 117, 1))),

                  const Spacer(),

                  Center(
                    child: Container(
                      height: 300.h,
                      width: 300.w,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/FaceId.png'),
                        ),
                        borderRadius: BorderRadius.circular(150),
                        color: const Color.fromRGBO(30, 108, 245, 1),
                      ),
                    ),
                  ),

                  const Spacer(),

                  Center(
                    child: GestureDetector(
                      onTap: isLoading ? null : () {
                        print(" dPhone VALUE BEFORE REGISTER: ${cubit.dPhone}");
                        cubit.registerDoctor(
                          firstName: cubit.dFirstName ?? "",
                          lastName: cubit.dLastName ?? "",
                          email: cubit.dEmail ?? "",
                          password: cubit.dPassword ?? "",
                          phone: cubit.dPhone ?? "",
                          gender: cubit.dGender ?? "",
                          dateOfBirth: cubit.dBirthDate ?? "",
                          specialization: cubit.dSpecialization ?? "",
                          bio: cubit.dBio ?? "",
                          practicalExperience: cubit.dExperience ?? "",
                          latitude: cubit.dLat ?? 30.0,
                          longitude: cubit.dLng ?? 31.0,
                        );
                      },
                      child: isLoading
                          ? const CircularProgressIndicator(color: Color(0xff0D5BE3))
                          : Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            radius: 38.r,
                            backgroundColor: const Color(0xff0D5BE3),
                            child: CircleAvatar(
                              radius: 33.r,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 31.r,
                                backgroundColor: const Color(0xff0D5BE3),
                                child: Icon(Icons.check, color: Colors.white, size: 30.sp),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 50.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}