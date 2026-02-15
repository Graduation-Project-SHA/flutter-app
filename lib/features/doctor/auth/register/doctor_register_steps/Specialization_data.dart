import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care_project/shared/component/defaultTextFormField/defaultTextFormField.dart';

class SpecializationData extends StatelessWidget {

  final String? selectedSpecialization;
  final Function(String?) onSpecializationChanged;
  final TextEditingController bioController;
  final TextEditingController experienceController;

  const SpecializationData({
    super.key,
    required this.selectedSpecialization,
    required this.onSpecializationChanged,
    required this.bioController,
    required this.experienceController,
  });


  final List<Map<String, String>> specializations = const [
    {'display': 'طب أطفال', 'value': 'PEDIATRICS'},
    {'display': 'باطنة', 'value': 'INTERNAL_MEDICINE'},
    {'display': 'جراحة', 'value': 'SURGERY'},
    {'display': 'أسنان', 'value': 'DENTISTRY'},
    {'display': 'نساء وتوليد', 'value': 'OBSTETRICS'},
    {'display': 'تغذية', 'value': 'NUTRITION'},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              Text(
                'موقعك الحالي',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                  color: const Color(0xff6C7278),
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {

                },
                child: Text(
                  'تغير الموقع',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13.sp,
                    color: const Color(0xff2853AF),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5.h),
          Container(
            width: double.infinity,
            height: 140.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              image: const DecorationImage(
                image: AssetImage('assets/images/mapImage.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Image.asset('assets/images/markOnMap.png', height: 40.h),
            ),
          ),

          SizedBox(height: 20.h),


          Text(
            'مجال تخصصك',
            style: TextStyle(fontSize: 12.sp, color: const Color(0xff6C7278)),
          ),
          SizedBox(height: 10.h),
          DropdownButtonFormField<String>(
            value: selectedSpecialization,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xffEDF1F3), width: 2),
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            hint: const Text('اختر تخصصك'),
            items: specializations.map((spec) {
              return DropdownMenuItem(
                value: spec['value'],
                child: Text(spec['display']!),
              );
            }).toList(),
            onChanged: onSpecializationChanged,
          ),

          SizedBox(height: 20.h),


          Text(
            'تكلم عن نفسك',
            style: TextStyle(fontSize: 12.sp, color: const Color(0xff6C7278)),
          ),
          SizedBox(height: 10.h),
          Defaulttextformfield(
            maxLines: 4,
            controller: bioController,
            hintText: 'اكتب نبذة عنك...',
          ),
          Text(
            'أكتب ما لا يقل عن 25 كلمة',
            style: TextStyle(fontSize: 9.sp, color: const Color(0xffABAFB1)),
          ),

          SizedBox(height: 20.h),

          Text(
            'خبراتك العملية',
            style: TextStyle(fontSize: 12.sp, color: const Color(0xff6C7278)),
          ),
          SizedBox(height: 10.h),
          Defaulttextformfield(
            controller: experienceController,
            hintText: 'مثال: مستشفى القصر العيني لمدة ٥ سنوات',
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}