import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care_project/features/chat/presentation/screens/chat_details_screen.dart';
import 'package:health_care_project/features/patient/donation/views/widgets/custom_appbar.dart';
import 'package:health_care_project/features/patient/main_layout/appointment/paient_doctor_cubit/patient_doctors_cubit.dart';
import 'package:health_care_project/features/patient/main_layout/appointment/paient_doctor_cubit/patient_doctors_state.dart';
import 'package:health_care_project/features/patient/main_layout/appointment/patient_doctor_model/patient_doctor_model.dart';
import 'package:hive/hive.dart';

class AllDoctorsScreen extends StatelessWidget {
  static const String routeName = 'all_doctors_screen';
  const AllDoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "جميع الأطباء"),
      body: BlocBuilder<PatientDoctorsCubit, PatientDoctorsState>(
        builder: (context, state) {
          if (state is PatientDoctorsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PatientDoctorsLoaded) {
            final doctors = state.doctors;
            if (doctors.isEmpty) {
              return const Center(child: Text('لا يوجد أطباء حالياً'));
            }
            return ListView.builder(
              padding: EdgeInsets.all(16.w),
              itemCount: doctors.length,
              itemBuilder: (context, index) {
                return DoctorCardWidget(doctor: doctors[index]);
              },
            );
          } else if (state is PatientDoctorsError) {
            return Center(child: Text(state.error));
          }
          return const Center(child: Text('اسحب لتحديث القائمة'));
        },
      ),
    );
  }
}


class DoctorCardWidget extends StatelessWidget {
  final PatientDoctorModel doctor;

  const DoctorCardWidget({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
          border: Border.all(color: const Color(0xffEDF1F3), width: 0.75)),
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
                      fit: BoxFit.cover),
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
                        Text(doctor.rating?.toString() ?? 'N/A',
                            style: TextStyle(
                                fontSize: 13.sp, color: Colors.black54)),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text("${doctor.firstName} ${doctor.lastName}",
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8.h),
                    Text(doctor.specialization ?? 'N/A',
                        style: TextStyle(
                            fontSize: 13.sp, color: Colors.grey[700])),
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
              child: const Text("ارسال رسالة")),
        ],
      ),
    );
  }
}