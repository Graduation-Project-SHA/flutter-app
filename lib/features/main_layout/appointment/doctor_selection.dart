import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care_project/features/main_layout/appointment/widgets/doctor_card.dart';
import 'package:health_care_project/features/main_layout/appointment/widgets/filter_chip.dart';
import '../../../shared/component/filterButton/filter_button.dart';
import '../../../shared/component/searchField/search_field.dart';
import 'AppointmentTimeScreen.dart';
import 'DoctorDetailsScreen.dart';

class DoctorSelection extends StatelessWidget {
  final String selectedSpecialty;
  final String selectedIcon;
  final String selectedSpecialtyId;
  final VoidCallback onBack;

   DoctorSelection({
    required this.selectedSpecialty,
    required this.selectedIcon,
    required this.selectedSpecialtyId,
    required this.onBack,
  });

  final List<String> filters = ["السعر","ذكر أو أنثى","متاح اليوم"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedSpecialty.isNotEmpty ? selectedSpecialty : "التخصص",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.arrow_forward_ios_outlined, color: Colors.black), onPressed: onBack),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("اختار الطبيب المناسب",style: TextStyle(fontWeight: FontWeight.bold),),
            SizedBox(height: 16.h),
            Text("اختار الطبيب المناسب بناءا علي المعايير التي تناسبك"),
            SizedBox(height: 16.h),
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
            SizedBox(height:16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DoctorCard.specialtyIcon("bones", "assets/images/bone.png", "عظام", selectedSpecialtyId),
                DoctorCard.specialtyIcon("teeth", "assets/images/tooth.png", "أسنان", selectedSpecialtyId),
                DoctorCard.specialtyIcon("psych", "assets/images/brain.png", "معالج نفسي", selectedSpecialtyId),
                DoctorCard.specialtyIcon("ent", "assets/images/ear.png", "أنف وأذن", selectedSpecialtyId),
              ],
            ),
            SizedBox(height: 28.h),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: filters.map((f) => FilterChipWidget(text: f)).toList(),
              ),
            ),
            SizedBox(height: 32.h),
            DoctorCard(
              name: "د. مرام علي",
              specialty: selectedSpecialty.isNotEmpty ? selectedSpecialty : "أنف وأذن وحنجرة",
              price: "سعر الكشف 300 جنيه",
              image: "assets/images/doctor.png",
              onBook: () => Navigator.pushNamed(context, AppointmentTimeScreen.routeName),
              onDetails: () => Navigator.pushNamed(context, DoctorDetailsScreen.routeName),
            ),
            DoctorCard(
              name: "د. أسامة مراد",
              specialty: selectedSpecialty.isNotEmpty ? selectedSpecialty : "أنف وأذن وحنجرة",
              price: "سعر الكشف 400 جنيه",
              image: "assets/images/doctor.png",
              onBook: () => Navigator.pushNamed(context, AppointmentTimeScreen.routeName),
              onDetails: () => Navigator.pushNamed(context, DoctorDetailsScreen.routeName),
            ),
            SizedBox(height: 80.h),
          ],
        ),
      ),
    );
  }
}
