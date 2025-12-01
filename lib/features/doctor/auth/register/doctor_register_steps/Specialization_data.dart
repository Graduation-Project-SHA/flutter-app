import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care_project/shared/component/defaultTextFormField/defaultTextFormField.dart';

class SpecializationData extends StatefulWidget {
  const SpecializationData({super.key});

  @override
  State<SpecializationData> createState() => _SpecializationDataState();
}

class _SpecializationDataState extends State<SpecializationData> {
  String? selectedSpecialization;

  final List<String> specializations = [
    'طب أطفال',
    'باطنة',
    'جراحة',
    'أسنان',
    'نساء وتوليد',
  ];
  TextEditingController? talkAboutYourSelfControler;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
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
                  color: Color.fromRGBO(108, 114, 120, 1),
                ),
              ),
              Spacer(),
              TextButton(
                onPressed: () {},
                child: Text(
                  'تغير الموقع',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13.sp,
                    color: Color.fromRGBO(40, 83, 175, 1),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5.h),
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 5),
            child: Container(
                width: 380.w,
                height: 140.h,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 172, 160, 160),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(children: [

                  ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(12),
                    child: Image.asset('assets/images/mapImage.png',
                      height: 140.h,
                      width: 380.w,

                      fit: BoxFit.cover,),
                  ),
                  Align(
                    alignment: AlignmentGeometry.center,
                    child: Image.asset('assets/images/markOnMap.png',

                    ),
                  ),

                ],)
            ),
          ),
          SizedBox(height: 15.h),
          Text(
            'مجال تخصصك',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: Color.fromRGBO(108, 114, 120, 1),
            ),
          ),
          SizedBox(height: 10.h),
          DropdownButtonFormField<String>(
            value: selectedSpecialization,
            decoration: InputDecoration(enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(237, 241, 243, 1),
                width: 2,
              ),

            )),
            hint: Text('اختر تخصصك'),
            items: specializations.map((specialization) {
              return DropdownMenuItem(
                value: specialization,
                child: Text(specialization),
              );
            }).toList(),
            onChanged: (val) {
              setState(() {
                selectedSpecialization = val;
              });
            },
          ),

          SizedBox(height: 15.h),
          Text(
            'تكلم عن نفسك',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12.sp,
              color: Color.fromRGBO(108, 114, 120, 1),
            ),
          ),

          SizedBox(height: 15.h),
          Defaulttextformfield(
            maxLines: 5,
            controller: talkAboutYourSelfControler,

          ),
          Text(
            'أكتب ما لا يقل عن 25 كلمة',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 9.sp,
                color: Color.fromRGBO(171, 175, 177, 1)
            ),
          ),

          SizedBox(height: 15.h,),
          Text(
            'خبراتك العملية',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12.sp,
              color: Color.fromRGBO(108, 114, 120, 1),
            ),
          ),
          SizedBox(height: 15.h,),
          Defaulttextformfield()

        ],
      ),
    );
  }
}