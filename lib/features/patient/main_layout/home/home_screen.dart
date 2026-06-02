import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:health_care_project/core/%20theme/app_colors.dart';
import 'package:health_care_project/features/chat/presentation/screens/chat_details_screen.dart';
import 'package:health_care_project/features/chat/presentation/screens/messages_screen.dart';
import 'package:health_care_project/features/doctor/main_layout/doctor_profile/doctor_services/doctor_services.dart';
import 'package:health_care_project/features/patient/donation/views/donation_screen.dart';
import 'package:health_care_project/features/patient/main_layout/appointment/all_doctors_screen.dart';
import 'package:health_care_project/features/patient/main_layout/appointment/appointment_screen.dart';
import 'package:health_care_project/features/patient/main_layout/appointment/paient_doctor_cubit/patient_doctors_cubit.dart';
import 'package:health_care_project/features/patient/main_layout/appointment/patient_appointment_cubit/patient_appointment_cubit.dart';
import 'package:health_care_project/features/patient/main_layout/appointment/patient_appointment_cubit/patient_appointment_states.dart';
import 'package:health_care_project/features/patient/main_layout/appointment/patient_appointment_model/patient_appointment_model.dart';
import 'package:health_care_project/features/patient/main_layout/appointment/patient_doctor_model/patient_doctor_model.dart';
import 'package:health_care_project/features/patient/main_layout/appointment/paient_doctor_cubit/patient_doctors_state.dart';
import 'package:health_care_project/features/patient/main_layout/main_layout.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import '../../../../shared/component/filterButton/filter_button.dart';
import '../../../../shared/component/searchField/search_field.dart';
import '../../care/care_screen.dart';
import '../../nearby_services/find_nearby_services_screen.dart';
import '../main_layout.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "HomeScreen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Box authBox;
  late final PageController _upcomingAppointmentsController;
  int _currentUpcomingAppointmentIndex = 0;

  @override
  void initState() {
    super.initState();
    authBox = Hive.box('authBox');
    _upcomingAppointmentsController = PageController(viewportFraction: 1.0);
    context.read<AppointmentCubit>().getMyAppointments();
    context.read<PatientDoctorsCubit>().getDoctors();
  }

  @override
  void dispose() {
    _upcomingAppointmentsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final firstName = authBox.get('firstName', defaultValue: "");
    final lastName = authBox.get('lastName', defaultValue: "");
    final userName = "$firstName $lastName";

    final localImage = authBox.get('profile_image_path');
    final serverImage = authBox.get('profileImage');

    final location = 'القاهرة, دار السلام';

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24.r,
                        backgroundImage: localImage != null
                            ? FileImage(File(localImage))
                            : (serverImage != null
                                      ? NetworkImage(serverImage)
                                      : const AssetImage(
                                              "assets/images/FaceId.png",
                                            )
                                            as ImageProvider)
                                  as ImageProvider,
                      ),
                      SizedBox(width: 24.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            " $userName ",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 16.sp,
                                color: Colors.black,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                location,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Icon(
                                Icons.keyboard_arrow_down_sharp,
                                size: 16.sp,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 30.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: SvgPicture.asset("assets/images/bill_icon.svg"),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Text(
                "المواعيد القادمة",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8.h),
              BlocBuilder<AppointmentCubit, AppointmentState>(
                builder: (context, state) {
                  if (state is AppointmentLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is AppointmentLoaded) {
                    final upcomingAppointments = state.upcoming;
                    if (upcomingAppointments.isEmpty) {
                      return const Text("لا توجد مواعيد قادمة");
                    }
                    final currentIndex =
                        _currentUpcomingAppointmentIndex >=
                            upcomingAppointments.length
                        ? upcomingAppointments.length - 1
                        : _currentUpcomingAppointmentIndex;

                    return Column(
                      children: [
                        SizedBox(
                          height: 150.h,
                          child: PageView.builder(
                            controller: _upcomingAppointmentsController,
                            reverse: true,
                            itemCount: upcomingAppointments.length,
                            onPageChanged: (index) {
                              setState(() {
                                _currentUpcomingAppointmentIndex = index;
                              });
                            },
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4.w),
                                child: _buildUpcomingAppointmentCard(
                                  appointment: upcomingAppointments[index],
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 12.h),
                        _buildAppointmentsIndicator(
                          context: context,
                          totalItems: upcomingAppointments.length,
                          currentPage: currentIndex,
                        ),
                      ],
                    );
                  } else if (state is AppointmentError) {
                    return Text(state.message);
                  }
                  return const SizedBox.shrink();
                },
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: SearchField(
                      hint: "البحث عن طبيب...",
                      onChanged: (value) {
                        print("بحث عن: $value");
                      },
                    ),
                  ),
                  SizedBox(width: 8.w),
                  FilterButton(
                    onPressed: () {
                      print("فتح الفلتر");
                    },
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: _buildSideBySideCard(
                      title: "حجز موعد",
                      description: "اختر الدكتور المناسب في التخصص الذي تحتاجه",
                      buttonText: "حجز موعد",
                      cardColor: const Color(0xffF0F0FF),
                      buttonColor: const Color(0xff6161FF),
                      icon: "assets/images/appointment.png",
                      bgicon: const Color(0xffCCCCFF),
                      onButtonPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const MainLayout(selectedIndex: 2),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: _buildSideBySideCard(
                      title: "مسعف قريب",
                      description:
                          "استكشف المستشفيات والاطباء والممرضين الاقرب",
                      buttonText: "ابحث عن مسعف",
                      cardColor: const Color(0xffFDF1F2),
                      buttonColor: const Color(0xffE6474F),
                      icon: "assets/images/hospital.png",
                      bgicon: const Color(0xffF9D2D4),
                      onButtonPressed: () {
                        Navigator.pushNamed(
                          context,
                          FindNearbyServicesScreen.routeName,
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "خدماتنا",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  // Text(
                  //   "عرض الكل",
                  //   style: TextStyle(
                  //       fontSize: 12.sp,
                  //       fontWeight: FontWeight.bold,
                  //       color: AppColors.gradientColor2),
                  // ),
                ],
              ),
              SizedBox(height: 12.h),
              SizedBox(
                height: 100.h,
                child: Directionality(
                  textDirection: ui.TextDirection.ltr,
                  child: ListView(
                    
                    
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildServiceCard(
                        "assets/images/Home_care.png",
                        "رعاية منزلية",
                        onTap: () {
                          Navigator.pushNamed(context, CareScreen.routeName);
                        },
                      ),
                        SizedBox(width: 18.w,),
                        _buildServiceCard(
                        "assets/images/donors.png",
                        "متبرعون",
                        onTap: () {
                          Navigator.pushNamed(context, DonationScreen.routeName);
                        },
                      ),
                        SizedBox(width: 18.w,),
                      _buildServiceCard(
                        "assets/images/doctor_logo.png",
                        "طبيب",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return AppointmentScreen();
                              },
                            ),
                          );
                        },
                      ),
                      // _buildServiceCard("assets/images/Medicine.png", "أدوية"),
                      // _buildServiceCard("assets/images/Nurse.png", "ممرضة"),
                    
                      
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "أشهر الأطباء",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AllDoctorsScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "عرض الكل",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.gradientColor2,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              BlocBuilder<PatientDoctorsCubit, PatientDoctorsState>(
                builder: (context, state) {
                  if (state is PatientDoctorsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is PatientDoctorsLoaded) {
                    final doctors = state.doctors.take(2).toList();
                    return ListView.builder(
                      itemCount: doctors.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return _buildDoctorCard(doctor: doctors[index]);
                      },
                    );
                  } else if (state is PatientDoctorsError) {
                    return Text(state.error);
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSideBySideCard({
    required String title,
    required String description,
    required String buttonText,
    required Color cardColor,
    required Color buttonColor,
    required String icon,
    required Color bgicon,
    VoidCallback? onButtonPressed,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: bgicon,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(icon, height: 45.w),
                ),
                SizedBox(height: 12.h),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.h),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  ),

                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          SizedBox(height: 15.h),
          SizedBox(
            height: 40.h,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onButtonPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 8.h),
              ),
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(
    String imagePath,
    String title, {
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 95.w,
        height:95.h,
        margin: EdgeInsets.only(right: 16.w),
        padding: EdgeInsets.symmetric(vertical: 7.5.h, horizontal: 5.w),
        decoration: BoxDecoration(
          color: const Color(0xffFFFFFF),
          borderRadius: BorderRadius.circular(7.5.r),
          border: Border.all(color: const Color(0xffEDF1F3), width: 0.75),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
      
          children: [

            Image.asset(
              imagePath, height: 61.h, width: 65.w,fit: BoxFit.cover,
              ),

            Text(
              title,
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorCard({required PatientDoctorModel doctor}) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xffEDF1F3), width: 0.75),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 89.w,
                height: 112.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  image: const DecorationImage(
                    image: AssetImage("assets/images/doctor.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        SizedBox(width: 4.w),
                        Text(
                          doctor.rating?.toString() ?? 'N/A',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "${doctor.firstName} ${doctor.lastName}",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      doctor.specialization ?? 'N/A',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatDetailsScreen(
                    myId: Hive.box('authBox').get('userId').toString(),
                    conversationId: '',
                    targetUserId: doctor.id.toString(),
                    targetUserName: "${doctor.firstName} ${doctor.lastName}",
                  ),
                ),
              );
            },
            child: Text("ارسال رسالة"),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentsIndicator({
    required BuildContext context,
    required int totalItems,
    required int currentPage,
  }) {
    final displayCurrentPage = totalItems - 1 - currentPage;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalItems,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.symmetric(horizontal: 3.w),
          height: 8.h,
          width: index == displayCurrentPage ? 22.w : 8.w,
          decoration: BoxDecoration(
            color: index == displayCurrentPage
                ? const Color(0xff4786F5)
                : const Color(0xff4786F5).withOpacity(0.25),
            borderRadius: BorderRadius.circular(999.r),
          ),
        ),
      ),
    );
  }

  Widget _buildUpcomingAppointmentCard({
    required AppointmentModel appointment,
  }) {
    final formattedDate = DateFormat(
      'EEEE, d MMMM, y',
      'ar',
    ).format(appointment.appointmentDate);
    final formattedTime = appointment.startTime.isNotEmpty
        ? appointment.startTime
        : DateFormat('h:mm a').format(appointment.appointmentDate);

    return Container(
      width: double.infinity,
      height: 160.h,
      decoration: BoxDecoration(
        color: const Color(0xff4786F5),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -2.46.h,
            left: -42.w,
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                'assets/images/Blob1.png',
                width: 175.17.w,
                height: 107.93.h,
              ),
            ),
          ),
          Positioned(
            top: -17.h,
            left: -33.38.w,
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                'assets/images/Blob2.png',
                width: 158.84.w,
                height: 137.h,
              ),
            ),
          ),
          Positioned(
            top: 47.54.h,
            left: 205.w,
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                'assets/images/Blob3.png',
                width: 175.17.w,
                height: 107.93.h,
              ),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 48.w,
                        height: 48.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          image: const DecorationImage(
                            image: AssetImage("assets/images/doctor.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "د. ${appointment.doctor.firstName} ${appointment.doctor.lastName}",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            appointment.doctor.specialization ?? 'N/A',
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 12.5.h),
                  Container(
                    width: double.infinity,
                    height: 44.h,
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 18.sp,
                          color: Colors.grey.shade600,
                        ),
                        Text("الموعد:"),
                        Text(
                          formattedTime,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        Icon(
                          Icons.calendar_month,
                          size: 18.sp,
                          color: Colors.grey.shade600,
                        ),
                        Text(
                          formattedDate,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
