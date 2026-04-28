import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care_project/features/patient/main_layout/appointment/patient_appointment_cubit/patient_appointment_cubit.dart';
import 'package:health_care_project/features/patient/main_layout/appointment/patient_appointment_cubit/patient_appointment_states.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';

import 'DoctorDetailsScreen.dart';

class Appointment extends StatefulWidget {
  static const String routeName = "Appointment";
  const Appointment({super.key});

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  bool isUpcomingMode = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppointmentCubit()..getMyAppointments(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: Size(double.infinity, 1.h),
            child: Container(color: const Color.fromRGBO(237, 237, 237, 1), height: 1.h),
          ),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Text(
            'مواعيدي',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18.sp),
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
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.arrow_forward_ios, size: 18.sp),
                ),
              ),
            ),
          ],
        ),
        body: BlocConsumer<AppointmentCubit, AppointmentState>(
          listener: (context, state) {
            if (state is CancelAppointmentSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("تم إلغاء الموعد بنجاح"), backgroundColor: Colors.green),
              );
              AppointmentCubit.get(context).getMyAppointments();
            }
            if (state is AppointmentError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message), backgroundColor: Colors.redAccent),
              );
            }
          },
          builder: (context, state) {
            final cubit = AppointmentCubit.get(context);

            if (state is AppointmentLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            final list = isUpcomingMode ? cubit.upcoming : cubit.past;

            return Column(
              children: [
                SizedBox(height: 24.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Row(
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
                SizedBox(height: 20.h),
                const Divider(height: 1, color: Color.fromRGBO(207, 223, 252, 1)),
                SizedBox(height: 20.h),
                Expanded(
                  child: list.isEmpty
                      ? Center(child: Text("لا توجد مواعيد ${isUpcomingMode ? 'قادمة' : 'سابقة'}"))
                      : ListView.separated(
                    padding: EdgeInsets.only(bottom: 20.h),
                    itemCount: list.length,
                    separatorBuilder: (context, index) => SizedBox(height: 24.h),
                    itemBuilder: (context, index) {
                      final appointment = list[index];
                      return isUpcomingMode
                          ? _buildUpcomingCard(context, appointment)
                          : _buildPastCard(appointment);
                    },
                  ),
                ),
              ],
            );
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
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2B73F3) : Colors.white,
          border: Border.all(color: const Color(0xFF2B73F3)),
          borderRadius: isRight
              ? BorderRadius.only(topRight: Radius.circular(8.r), bottomRight: Radius.circular(8.r))
              : BorderRadius.only(topLeft: Radius.circular(8.r), bottomLeft: Radius.circular(8.r)),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 14.sp, color: isSelected ? Colors.white : const Color(0xFF2B73F3)),
        ),
      ),
    );
  }

  Widget _buildUpcomingCard(BuildContext context, appointment) {
    return Center(
      child: Container(
        width: 340.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
          border: Border.all(color: const Color(0xFFDCDCDC)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: const Color(0xFF2B73F3),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(12.r), topRight: Radius.circular(12.r)),
              ),
              alignment: Alignment.centerLeft,
              child: Text(appointment.startTime, style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                children: [
                  _buildDoctorHeader(appointment),
                  SizedBox(height: 16.h),
                  _buildInfoRow(Icons.calendar_month_outlined, "التاريخ", DateFormat('EEEE، d MMMM yyyy', 'ar').format(appointment.appointmentDate)),
                  SizedBox(height: 12.h),
                  _buildInfoRow(Icons.access_time, "الوقت", appointment.startTime),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2B73F3), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r))),
                          child: const Text('ضبط تنبيه', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => _showCancelBottomSheet(context, appointment.id),
                          style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFF2B73F3)), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r))),
                          child: const Text('إلغاء', style: TextStyle(color: Color(0xFF2B73F3))),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPastCard(appointment) {
    bool isCancelled = appointment.status == "CANCELLED";
    Color statusBg = isCancelled ? const Color(0xffFEEBEB) : const Color(0xffFFF9E7);
    Color statusText = isCancelled ? const Color(0xffF34236) : const Color(0xffF2B544);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromRGBO(207, 223, 252, 1)),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(11.r), bottomRight: Radius.circular(14.r)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(width: 6.w, height: 6.h, decoration: BoxDecoration(color: statusText, shape: BoxShape.circle)),
                    SizedBox(width: 4.w),
                    Text(isCancelled ? 'ألغيت' : 'تمت', style: TextStyle(color: statusText, fontSize: 12.sp, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 35.r,
                    backgroundImage: appointment.doctor.profileImage != null
                        ? NetworkImage(appointment.doctor.profileImage!)
                        : const AssetImage('assets/images/doctor.png') as ImageProvider,
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(appointment.doctor.fullName, style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold)),
                        Text(appointment.doctor.specialization, style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
                        SizedBox(height: 12.h),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DoctorDetailsScreen(
                                        doctorId: appointment.doctor.id.toString(),
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2B73F3), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r))),
                                child: const Text('حجز مرة اخرى', style: TextStyle(color: Colors.white,)),
                              ),
                            ),
                            if (!isCancelled) ...[
                              SizedBox(width: 8.w),
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {},
                                  style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFF2B73F3)), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r))),
                                  child: const Text('تقييم', style: TextStyle(color: Color(0xFF2B73F3), )),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorHeader(appointment) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20.r,
          backgroundImage: appointment.doctor.profileImage != null
              ? NetworkImage(appointment.doctor.profileImage!)
              : const AssetImage('assets/images/doctor.png') as ImageProvider,
        ),
        SizedBox(width: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('دكتور', style: TextStyle(fontSize: 11.sp, color: Colors.grey)),
            Text(appointment.doctor.fullName, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20.sp, color: const Color(0xFF2B73F3)),
        SizedBox(width: 12.w),
        Text("$label: ", style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
        Text(value, style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600)),
      ],
    );
  }

  void _showCancelBottomSheet(BuildContext context, int appointmentId) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(24.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('إلغاء الحجز', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: const Color(0xffF34236))),
              SizedBox(height: 12.h),
              const Divider(color: Color(0xffECECEC)),
              SizedBox(height: 12.h),
              Text('هل أنت متأكد من رغبتك في إلغاء هذا الحجز؟', textAlign: TextAlign.center, style: TextStyle(fontSize: 14.sp, color: Colors.grey[700])),
              SizedBox(height: 30.h),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2B73F3), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r))),
                      child: const Text('تراجع', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        BlocProvider.of<AppointmentCubit>(context).cancelAppointment(
                          appointmentId: appointmentId,
                          reason: "Personal emergency",
                        );
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: const Color(0xffFEEBEB),
                        side: const BorderSide(color: Color(0xffF34236)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                      ),
                      child: const Text('نعم، إلغاء', style: TextStyle(color: Color(0xffF34236))),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}