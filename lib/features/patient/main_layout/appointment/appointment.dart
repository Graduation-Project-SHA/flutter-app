import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care_project/features/patient/main_layout/appointment/patient_appointment_cubit/patient_appointment_cubit.dart';
import 'package:health_care_project/features/patient/main_layout/appointment/patient_appointment_cubit/patient_appointment_states.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';


class Appointment extends StatefulWidget {
  const Appointment({super.key});

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  bool isUpcomingMode = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppointmentCubit()..getMyAppointments(),
      child: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: Size(double.infinity, 10.h),
            child: Container(
              color: const Color.fromRGBO(237, 237, 237, 1),
              height: 2.h,
            ),
          ),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Text(
            'مواعيدي',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color.fromRGBO(205, 205, 205, 1)),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: IconButton(
                  onPressed:(){},
                  icon: Icon(Icons.arrow_forward_ios, size: 18.sp),
                ),
              ),
            ),
          ],
        ),
        body: BlocBuilder<AppointmentCubit, AppointmentState>(
          builder: (context, state) {
            if (state is AppointmentLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AppointmentError) {
              return Center(child: Text(state.message));
            } else if (state is AppointmentLoaded) {

              final list = isUpcomingMode ? state.upcoming : state.past;

              return Column(
                children: [
                  SizedBox(height: 24.h),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Expanded(
                          child: _buildToggleButton(
                            text: 'مواعيد سابقة',
                            isSelected: !isUpcomingMode,
                            onTap: () => setState(() => isUpcomingMode = false),
                            isRight: true,
                          ),
                        ),
                        Expanded(
                          child: _buildToggleButton(
                            text: 'مواعيد قادمة',
                            isSelected: isUpcomingMode,
                            onTap: () => setState(() => isUpcomingMode = true),
                            isRight: false,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 40.h),
                  Divider(height: 3.h, color: const Color.fromRGBO(207, 223, 252, 1)),
                  SizedBox(height: 40.h),

                  Expanded(
                    child: list.isEmpty
                        ? const Center(child: Text("لا توجد مواعيد"))
                        : ListView.separated(
                      padding: EdgeInsets.only(bottom: 20.h),
                      itemCount: list.length,
                      separatorBuilder: (context, index) => SizedBox(height: 24.h),
                      itemBuilder: (context, index) {
                        final appointment = list[index];

                        return ConditionalBuilder(
                          condition: isUpcomingMode,
                          builder: (context) => _buildUpcomingCard(appointment),
                          fallback: (context) => _buildPastCard(appointment),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }


  Widget _buildToggleButton({required String text, required bool isSelected, required VoidCallback onTap, required bool isRight}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 18.r, vertical: 8.r),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
          border: Border.all(color: isSelected ? const Color.fromRGBO(43, 115, 243, 1) : const Color.fromRGBO(205, 205, 205, 1)),
          borderRadius: isRight
              ? BorderRadius.only(topRight: Radius.circular(8.r), bottomRight: Radius.circular(8.r))
              : BorderRadius.only(topLeft: Radius.circular(8.r), bottomLeft: Radius.circular(8.r)),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: isSelected ? Colors.white : const Color.fromRGBO(43, 115, 243, 1),
          ),
        ),
      ),
    );
  }

  Widget _buildUpcomingCard(appointment) {
    final String myId = Hive.box('authBox').get('userId').toString();
    return Center(
      child: Container(
        width: 327.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3))],
        ),
        child: Column(
          children: [
            Container(
              width: 327.w,
              height: 59.h,
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              decoration: BoxDecoration(
                color: const Color(0xFF2B73F3),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(12.r), topRight: Radius.circular(12.r)),
              ),
              alignment: Alignment.centerLeft,
              child: Text(
                appointment.startTime,
                style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: 327.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12.r), bottomRight: Radius.circular(12.r)),
                border: Border.all(color: const Color(0xFFDCDCDC)),
              ),
              child: Padding(
                padding: EdgeInsets.all(14.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDoctorHeader(appointment),
                    SizedBox(height: 18.h),
                    _buildInfoRow(Icons.star_border, "التخصص", appointment.doctor.specialization),
                    SizedBox(height: 18.h),
                    _buildInfoRow(Icons.calendar_month_outlined, "التاريخ", DateFormat('EEEE، d MMMM yyyy', 'ar').format(appointment.appointmentDate)),
                    SizedBox(height: 18.h),
                    _buildInfoRow(Icons.access_time, "الوقت", appointment.startTime),
                    SizedBox(height: 18.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12.r),
                      decoration: BoxDecoration(color: const Color(0xFFF1F5FF), borderRadius: BorderRadius.circular(10.r)),
                      child: Text(appointment.notes.isEmpty ? "لا توجد ملاحظات" : appointment.notes, style: TextStyle(fontSize: 12.sp)),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // Navigator.push(context, MaterialPageRoute(builder: (_) => ChatDetailsScreen(
                              //   myId: myId,
                              //   targetUserId: appointment.doctor.userId,
                              //   conversationId: "",
                              //   targetUserName: appointment.doctor.fullName,
                              // )));
                            },
                            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2B73F3), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r))),
                            child: Text('ضبط تنبيه', style: TextStyle(color: Colors.white, fontSize: 14.sp)),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.white, side: const BorderSide(color: Color(0xFF2B73F3)), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r))),
                            child: Text('إلغاء', style: TextStyle(color: const Color(0xFF2B73F3), fontSize: 14.sp)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPastCard(appointment) {
    bool isCancelled = appointment.status == "CANCELLED";
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 24.w,
          child: Container(
            width: 54.w,
            height: 30.h,
            decoration: BoxDecoration(
              color: isCancelled ? const Color.fromRGBO(244, 228, 227, 1) : const Color.fromRGBO(251, 248, 244, 1),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(8.r), bottomRight: Radius.circular(14.r)),
            ),
            child: Center(
              child: Text(isCancelled ? 'ألغيت' : 'تمت',
                style: TextStyle(
                  color: isCancelled ? const Color.fromRGBO(243, 66, 54, 1) : const Color.fromRGBO(242, 181, 68, 1),
                  fontSize: 12.sp,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Container(
            decoration: BoxDecoration(border: Border.all(color: const Color.fromRGBO(207, 223, 252, 1)), borderRadius: BorderRadius.circular(12.r)),
            padding: EdgeInsets.all(12.r),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40.r,
                  backgroundColor: const Color.fromRGBO(183, 207, 251, 1),
                  backgroundImage: appointment.doctor.profileImage != null
                      ? NetworkImage(appointment.doctor.profileImage!)
                      : const AssetImage('assets/images/doctor.png') as ImageProvider,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(appointment.doctor.fullName, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700)),
                      Text(appointment.doctor.specialization, style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
                      SizedBox(height: 10.h),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2B73F3)),
                        child: Text(isCancelled ? 'حجز مرة أخرى' : 'تقييم', style: const TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDoctorHeader(appointment) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20.r,
          backgroundColor: const Color.fromRGBO(183, 207, 251, 1),
          backgroundImage: appointment.doctor.profileImage != null
              ? NetworkImage(appointment.doctor.profileImage!)
              : const AssetImage('assets/images/doctor.png') as ImageProvider,
        ),
        SizedBox(width: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('دكتور', style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
            Text(appointment.doctor.fullName, style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: const Color.fromRGBO(231, 239, 254, 1),
          child: Icon(icon, size: 22.sp, color: const Color(0xFF2B73F3)),
        ),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
            Text(value, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    );
  }
}