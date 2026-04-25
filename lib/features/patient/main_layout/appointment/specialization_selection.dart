import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care_project/features/patient/main_layout/appointment/widgets/specialty_card.dart';
import '../../../../shared/component/filterButton/filter_button.dart';
import '../../../../shared/component/searchField/search_field.dart';


class SpecializationSelection extends StatelessWidget {
  final String selectedSpecialty;
  final void Function({String? specialty, String? title, String? icon}) onSelectSpecialization;
  final VoidCallback onBack;

   SpecializationSelection({
    required this.selectedSpecialty,
    required this.onSelectSpecialization,
    required this.onBack,
  });
  final specialties = [
    {
      "title": "أنف وأذن",
      "id": "EAR_NOSE_THROAT",
      "desc": "مجموعة من الأطباء الخبراء",
      "icon": "assets/images/EAR_NOSE_THROAT.png"
    },
    {
      "title": "أسنان",
      "id": "DENTISTRY",
      "desc": "مجموعة من الأطباء الخبراء",
      "icon": "assets/images/DENTISTRY.png"
    },
    {
      "title": "عظام",
      "id": "ORTHOPEDICS",
      "desc": "مجموعة من الأطباء الخبراء",
      "icon": "assets/images/ORTHOPEDICS.png"
    },
    {
      "title": "نفسي",
      "id": "PSYCHIATRY",
      "desc": "مجموعة من الأطباء الخبراء",
      "icon": "assets/images/PSYCHIATRY.png"
    },
    {
      "title": "باطنة",
      "id": "INTERNAL_MEDICINE",
      "desc": "مجموعة من الأطباء الخبراء",
      "icon": "assets/images/internal_medicine.png"
    },
    {
      "title": "أطفال",
      "id": "PEDIATRICS",
      "desc": "مجموعة من الأطباء الخبراء",
      "icon": "assets/images/pediatrics.png"
    },
    {
      "title": "جلدية",
      "id": "DERMATOLOGY",
      "desc": "مجموعة من الأطباء الخبراء",
      "icon": "assets/images/dermatology.png"
    },
    {
      "title": "قلب",
      "id": "CARDIOLOGY",
      "desc": "مجموعة من الأطباء الخبراء",
      "icon": "assets/images/cardiology.png"
    },
    {
      "title": "نساء وتوليد",
      "id": "GYNECOLOGY_AND_OBSTETRICS",
      "desc": "مجموعة من الأطباء الخبراء",
      "icon": "assets/images/gynecology.png"
    },
    {
      "title": "عيون",
      "id": "OPHTHALMOLOGY",
      "desc": "مجموعة من الأطباء الخبراء",
      "icon": "assets/images/eye.png"
    },
    {
      "title": "مخ وأعصاب",
      "id": "NEUROLOGY",
      "desc": "مجموعة من الأطباء الخبراء",
      "icon": "assets/images/neurology.png"
    },
    {
      "title": "جراحة عامة",
      "id": "GENERAL_SURGERY",
      "desc": "مجموعة من الأطباء الخبراء",
      "icon": "assets/images/surgery.png"
    },
    {
      "title": "مسالك بولية",
      "id": "UROLOGY",
      "desc": "مجموعة من الأطباء الخبراء",
      "icon": "assets/images/urology.png"
    },
    {
      "title": "علاج طبيعي",
      "id": "PHYSICAL_THERAPY",
      "desc": "مجموعة من الأطباء الخبراء",
      "icon": "assets/images/physiotherapy.png"
    },
    {
      "title": "تغذية",
      "id": "NUTRITION",
      "desc": "مجموعة من الأطباء الخبراء",
      "icon": "assets/images/nutrition.png"
    },
    {
      "title": "أورام",
      "id": "ONCOLOGY",
      "desc": "مجموعة من الأطباء الخبراء",
      "icon": "assets/images/oncology.png"
    },
    {
      "title": "أشعة",
      "id": "RADIOLOGY",
      "desc": "مجموعة من الأطباء الخبراء",
      "icon": "assets/images/radiology.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromRGBO(205, 205, 205, 1)),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: IconButton(
                onPressed: (){},
                icon: Icon(Icons.arrow_forward_ios, size: 18.sp),
              ),
            ),
          ),
        ],
        title: const Text("حجز موعد", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("التخصص",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
            SizedBox(height: 4.h),
            Text("جميع التخصصات الطبية في مكان واحد", style: TextStyle(fontSize: 13.sp, color: Colors.black54)),
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
            SizedBox(height: 16.h),
            for (var s in specialties)
              SpecialtyCard(
                title: s['title']!,
                description: s['desc']!,
                iconPath: s['icon']!,
                isSelected: selectedSpecialty == s['id'],
                onTap: () => onSelectSpecialization(
                  specialty: s['id'],
                  title: s['title'],
                  icon: s['icon'],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
