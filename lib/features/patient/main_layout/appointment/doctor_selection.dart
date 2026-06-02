import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care_project/features/patient/main_layout/appointment/paient_doctor_cubit/patient_doctors_cubit.dart';
import 'package:health_care_project/features/patient/main_layout/appointment/paient_doctor_cubit/patient_doctors_state.dart';
import 'package:health_care_project/features/patient/main_layout/appointment/patient_doctor_model/patient_doctor_model.dart';
import 'package:health_care_project/features/patient/main_layout/appointment/widgets/doctor_card.dart';
import 'package:health_care_project/features/patient/main_layout/appointment/widgets/filter_chip.dart';

import '../../../../shared/component/filterButton/filter_button.dart';
import '../../../../shared/component/searchField/search_field.dart';
import 'AppointmentTimeScreen.dart';
import 'DoctorDetailsScreen.dart';

class DoctorSelection extends StatefulWidget {
  final String specialization;
  final String title;
  final VoidCallback onBack;

  const DoctorSelection({
    super.key,
    required this.specialization,
    required this.title,
    required this.onBack,
  });

  @override
  State<DoctorSelection> createState() => _DoctorSelectionState();
}

class _DoctorSelectionState extends State<DoctorSelection> {
  final TextEditingController searchController = TextEditingController();

  final List<String> filters = ["السعر", "ذكر أو أنثى", "متاح اليوم"];

  late String currentSpecialization;

  @override
  void initState() {
    super.initState();
    currentSpecialization = widget.specialization;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadDoctors();
    });
  }

  void _loadDoctors() {
    if (currentSpecialization.trim().isEmpty) {
      PatientDoctorsCubit.get(context).getAllDoctors();
    } else {
      PatientDoctorsCubit.get(context).getDoctors(
        specialization: currentSpecialization,
      );
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _searchDoctors() {
    PatientDoctorsCubit.get(context).getDoctors(
      specialization: currentSpecialization,
      name: searchController.text.trim(),
    );
  }

  void _selectSpecialization(String specialization) {
    setState(() {
      currentSpecialization = specialization;
      searchController.clear();
    });

    PatientDoctorsCubit.get(context).getDoctors(
      specialization: specialization,
    );
  }

  void _showAllDoctors() {
    setState(() {
      currentSpecialization = "";
      searchController.clear();
    });

    PatientDoctorsCubit.get(context).getAllDoctors();
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

  Widget _specialtyIcon(String id, String image, String title) {
    final isSelected = currentSpecialization == id;

    return GestureDetector(
      onTap: () => _selectSpecialization(id),
      child: Column(
        children: [
          Container(
            width: 60.w,
            height: 60.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? const Color(0xffEAF2FF) : Colors.white,
              border: Border.all(
                color: isSelected
                    ? const Color(0xff2B73F3)
                    : const Color(0xffE5E7EB),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(14.w),
              child: Image.asset(image),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _doctorItem(PatientDoctorModel doctor) {
    final displayPrice = doctor.effectiveConsultationFee!;

    return DoctorCard(
      name: doctor.fullName,
      specialty: _specializationLabel(doctor.specialization),
      price: "سعر الكشف ${displayPrice.toStringAsFixed(0)} جنيه",
      image: "assets/images/doctor.png",
      isNetworkImage: false,
      onBook: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AppointmentTimeScreen(
              doctor: doctor.toJson(),
            ),
          ),
        );
      },
      onDetails: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DoctorDetailsScreen(
              doctorId: doctor.userId,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PatientDoctorsCubit, PatientDoctorsState>(
      listener: (context, state) {
        if (state is PatientDoctorsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      },
      builder: (context, state) {
        final cubit = PatientDoctorsCubit.get(context);

        // هنا بنعمل الفلترة قبل عرض القائمة
        final activeDoctors = cubit.doctors
            .where((doctor) => doctor.effectiveConsultationFee != null)
            .toList();

        return Scaffold(
          appBar: AppBar(
            title: Text(
              widget.title.isNotEmpty ? widget.title : "التخصص",
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
                    onPressed: widget.onBack,
                    icon: Icon(Icons.arrow_forward_ios, size: 18.sp),
                  ),
                ),
              ),
            ],
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "اختار الطبيب المناسب",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  "اختار الطبيب المناسب بناءا علي المعايير التي تناسبك",
                  style: TextStyle(fontSize: 13.sp),
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Expanded(
                      child: SearchField(
                        hint: "البحث عن طبيب...",
                        onChanged: (_) {},
                        controller: searchController,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    FilterButton(
                      onPressed: _searchDoctors,
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _specialtyIcon("ORTHOPEDICS", "assets/images/bone.png", "عظام"),
                    _specialtyIcon("DENTISTRY", "assets/images/tooth.png", "أسنان"),
                    _specialtyIcon("PSYCHIATRY", "assets/images/brain.png", "نفسي"),
                    _specialtyIcon("EAR_NOSE_THROAT", "assets/images/ear.png", "أنف وأذن"),
                  ],
                ),
                SizedBox(height: 16.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: _showAllDoctors,
                    child: Text(
                      "عرض كل الأطباء",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xff2B73F3),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: filters
                        .map((f) => FilterChipWidget(text: f))
                        .toList(),
                  ),
                ),
                SizedBox(height: 32.h),

                // التحقق هنا بناءً على activeDoctors المفلترة
                if (state is PatientDoctorsLoading)
                  const Center(child: CircularProgressIndicator())
                else if (activeDoctors.isEmpty)
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 100.h),
                      child: Column(
                        children: [
                          Text(
                            "لا يوجد أطباء متاحون",
                            style: TextStyle(fontSize: 16.sp),
                          ),
                          SizedBox(height: 12.h),
                          TextButton(
                            onPressed: _showAllDoctors,
                            child: const Text("عرض كل الأطباء بدون فلترة"),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  ...activeDoctors.map(_doctorItem).toList(),

                SizedBox(height: 80.h),
              ],
            ),
          ),
        );
      },
    );
  }
}