import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care_project/features/main_layout/appointment/widgets/specialty_card.dart';
import '../../../shared/component/filterButton/filter_button.dart';
import '../../../shared/component/searchField/search_field.dart';

class SpecializationSelection extends StatelessWidget {
  final String selectedSpecialty;
  final void Function({String? specialty, String? title, String? icon}) onSelectSpecialization;
  final VoidCallback onBack;

  const SpecializationSelection({
    required this.selectedSpecialty,
    required this.onSelectSpecialization,
    required this.onBack,
  });

  final List<Map<String,String>> specialties = const [
    {"id":"ent","title":"أنف وأذن وحنجرة","desc":"مجموعة من الأطباء الخبراء","icon":"assets/images/ear.png"},
    {"id":"psych","title":"معالج نفسي","desc":"مجموعة من الأطباء الخبراء","icon":"assets/images/brain.png"},
    {"id":"teeth","title":"أسنان","desc":"مجموعة من الأطباء الخبراء","icon":"assets/images/tooth.png"},
    {"id":"bones","title":"عظام","desc":"مجموعة من الأطباء الخبراء","icon":"assets/images/bone.png"},
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
                onPressed: () {
                 // Navigator.pop(context);
                },
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
