import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'doctor_details_cubit/doctor_details_cubit.dart';
import 'doctor_details_cubit/doctor_details_state.dart';
import 'doctor_details_model/doctor_details_model.dart';
import 'AppointmentTimeScreen.dart';

class DoctorDetailsScreen extends StatefulWidget {
  static const String routeName = "DoctorDetailsScreen";

  final String doctorId;

  const DoctorDetailsScreen({
    super.key,
    required this.doctorId,
  });

  @override
  State<DoctorDetailsScreen> createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      DoctorDetailsCubit.get(context).getDoctorDetails(widget.doctorId);
    });
  }

  String _specializationLabel(String value) {
    const map = {
      "EAR_NOSE_THROAT": "أنف وأذن وحنجرة",
      "DENTISTRY": "أسنان",
      "ORTHOPEDICS": "عظام",
      "PSYCHIATRY": "نفسي",
      "INTERNAL_MEDICINE": "باطنة",
      "PEDIATRICS": "أطفال",
      "DERMATOLOGY": "جلدية",
      "CARDIOLOGY": "قلب",
      "GENERAL_SURGERY": "جراحة عامة",
      "GYNECOLOGY_AND_OBSTETRICS": "نساء وتوليد",
      "OPHTHALMOLOGY": "رمد",
      "NEUROLOGY": "مخ وأعصاب",
      "UROLOGY": "مسالك بولية",
      "PHYSICAL_THERAPY": "علاج طبيعي",
      "NUTRITION": "تغذية",
      "ONCOLOGY": "أورام",
      "RADIOLOGY": "أشعة",
    };

    return map[value] ?? value;
  }

  Widget _wrapInContainer(Widget child) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: child,
    );
  }

  Widget _buildContent(DoctorDetailsModel doctor) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          _wrapInContainer(
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 35.r,
                      backgroundImage: (doctor.profileImage != null &&
                          doctor.profileImage!.isNotEmpty)
                          ? NetworkImage(doctor.profileImage!)
                          : const AssetImage("assets/images/doctor.png")
                      as ImageProvider,
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doctor.fullName,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            _specializationLabel(doctor.specialization),
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            "سعر الكشف: ${doctor.consultationFee?.toStringAsFixed(0) ?? "-"} جنيه",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            "التقييم: ${doctor.rating?.toStringAsFixed(1) ?? "-"}",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const Icon(Icons.location_on_outlined),
                          SizedBox(height: 6.h),
                          Text(
                            doctor.city?.isNotEmpty == true ? doctor.city! : "غير محدد",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          const Icon(Icons.local_hospital_outlined),
                          SizedBox(height: 6.h),
                          Text(
                            doctor.clinicAddress?.isNotEmpty == true
                                ? doctor.clinicAddress!
                                : "العنوان غير متاح",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _wrapInContainer(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "السيرة الذاتية",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  doctor.bio?.isNotEmpty == true
                      ? doctor.bio!
                      : "لا توجد سيرة ذاتية متاحة",
                  style: TextStyle(fontSize: 13.sp),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AppointmentTimeScreen(
                      doctorId: doctor.id,
                    ),
                  ),
                );
              },
              child: const Text("حجز موعد"),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorDetailsCubit, DoctorDetailsState>(
      listener: (context, state) {
        if (state is DoctorDetailsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "تفاصيل الطبيب",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            centerTitle: true,
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromRGBO(205, 205, 205, 1),
                    ),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_forward_ios, size: 18.sp),
                  ),
                ),
              ),
            ],
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: state is DoctorDetailsLoading
              ? const Center(child: CircularProgressIndicator())
              : state is DoctorDetailsLoaded
              ? _buildContent(state.doctor)
              : const Center(child: Text("لا توجد بيانات")),
        );
      },
    );
  }
}