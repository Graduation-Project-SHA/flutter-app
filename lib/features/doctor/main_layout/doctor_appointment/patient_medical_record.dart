import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care_project/shared/component/customAppbarButton/custom_app_bar_button.dart';

class PatientDetailsScreen extends StatelessWidget {
  const PatientDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildCurrentSessionCard(),
            _buildMedicalProfileCard(),
            _buildMedicalHistoryCard(),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: const [
            Color(0xFF4786F5),
            Color(0xFF2B73F3),
            Color(0xFF3077F3),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 30.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text("معلومات المريض",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold)),
              ) ,
              CustomAppBarBtn(),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 23.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                  radius: 22.r,
                  backgroundImage:
                  AssetImage("assets/images/person_image.png"),
                ),
                  SizedBox(width:16.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("سارة أحمد",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500)),
                      SizedBox(height: 4.h),
                      Text("رقم السجل: 8765-4321",
                          style: TextStyle(
                              color: Colors.white70, fontSize: 12.sp)),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 28.5.h,)
        ],
      ),
    );
  }

  Widget _buildCurrentSessionCard() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 17.17.h, left: 25.w, right: 25.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color:  Color(0xffBEDBFF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Color(0xffEFF6FF),
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.description_outlined,
                        color: Color(0xff195BD1)),
                    SizedBox(width: 4.w),
                    Text("الجلسة الحالية",
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.bold,color: Colors.black)),
                  ],
                ),
                SizedBox(height: 8.h,),
                Row(
                  children: [
                    Text("الاحد 16 نوفمبر 2025",
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w400,color: Color(0xff155DFC))),
                  ],
                ),
                SizedBox(height: 27.h),
              ],
            ),
          ),
          SizedBox(height:20.h),
          Container(
            padding: EdgeInsets.all(16.w),
            child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("الشكوي الرئيسية",style: TextStyle(color: Colors.black,fontSize: 12.sp),),
                SizedBox(height:8.h ,),
                _buildField("الم في الصدر"),
                Text("التشخيص",style: TextStyle(color: Colors.black,fontSize: 12.sp),),
                SizedBox(height:8.h ,),
                _buildField("ذبحة صدرية"),
                Text("ملاحظات الطبيب",style: TextStyle(color: Colors.black,fontSize: 12.sp),),
                SizedBox(height:8.h ,),
                _buildField("ذبحة صدرية"),
              ],
            ),
          ),
          SizedBox(height: 11.h),
          Padding(
               padding: const EdgeInsets.only(right:16 ,left:16 ),
               child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff2B73F3),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r)),
                  elevation: 0,
                ),
                child: const Text("إنشاء روشتة إلكترونية",
                    style: TextStyle(color: Colors.white,fontSize: 14)),
                           ),
             ),
          SizedBox(height: 8.h),
          Padding(
            padding: const EdgeInsets.only(right:16 ,left:16 ,bottom: 16),
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xff2B73F3)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r)),
              ),
              child: const Text("حفظ ملاحظات الجلسة",
                  style: TextStyle(color: Color(0xff2B73F3),fontSize: 14)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildField(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom:16.h),
      child: TextFormField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: Color(0xff939393)),
          ) ,
          labelText: label,
          labelStyle: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w400,color: Color(0xff939393)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: Color(0xff939393)),
          ),
        ),
      ),
    );
  }

  Widget _buildMedicalProfileCard() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xffFEE685)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Color(0xffFFFBEB),
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Icon(Icons.medication_liquid_sharp,
                    color: Color(0xff7B3306), size: 20.sp),
                SizedBox(width: 8.w),
                Text("الملف الدوائي",
                    style: TextStyle(
                        fontSize: 16.sp, fontWeight: FontWeight.bold,color: Color(0xff7B3306))),
                SizedBox(height: 57.h),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          Container(
            padding: EdgeInsets.all(16.w),
            margin: EdgeInsets.only(right: 25.w),
            decoration: BoxDecoration(
              color: const Color(0xffFFC9C9),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.warning_amber_rounded, color: Color(0xff9F0712),),
                Text(
                  "حساسية",
                  style: TextStyle(
                      color: Color(0xff9F0712),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold),
                ), Text(
                  "البنسلين، سم النحل",
                  style: TextStyle(
                      color: Color(0xff9F0712),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(16.w),
            child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("الأدوية الحالية والمزمنة",style: TextStyle(color: Color(0xff45556C)),),
                _medicine("ليسينوبريل", " 81 ملجم - مرة واحدة يومياًً"),
                _medicine("أسبرين", "500 ملجم - عند اللزوم"),
                _medicine("أتورفاستاتين", "20 ملجم - مرة واحدة يومياً (مساءً) "),
              ],
            ),)

        ],
      ),
    );
  }

  Widget _medicine(String name, String dose) {
    return Container(
      padding: EdgeInsets.all(12.w),
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Icon(Icons.medical_services_outlined,
              color: Colors.blue, size: 20.sp),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: TextStyle(
                      fontSize: 14.sp, fontWeight: FontWeight.bold)),
              Text(dose,
                  style: TextStyle(color: Colors.grey, fontSize: 12.sp)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMedicalHistoryCard() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xffD4EFDF)),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.w),
            color: Color(0xffF0FDF4),
            child: Row(
              children: [
                Icon(Icons.my_library_books_sharp, color: Color(0xff0D542B), size: 20.sp),
                SizedBox(width: 8.w),
                Text("التاريخ الطبي",
                    style: TextStyle(
                        fontSize: 15.sp, fontWeight: FontWeight.bold,color: Color(0xff0D542B))),
                SizedBox(height: 57.h,)
              ],
            ),
          ),
          SizedBox(height:24.h),
          Container(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                _historyItem(
                  "13 نوفمبر 2024",
                  "التهاب فيروسي في الجهاز التنفسي العلوي",
                  "مضاد للاحتقان"),
                SizedBox(height:9.h),
                _historyItem(
                    "10 أكتوبر 2024",
                    "التهاب اللوزتين الحاد",
                    "أموكسيسيلين 500 ملجم"),],
            ),
          )
        ],
      ),
    );
  }

  Widget _historyItem(String date, String title, String details) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(date, style: TextStyle(color: Colors.grey)),
              Text(title,
                  style: TextStyle(
                      fontSize: 14.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 4.h),
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(details,
                    style:
                    TextStyle(color: Colors.black87, fontSize: 12.sp)),
              ),
            ],
          ),
        ),
        SizedBox(width: 10.w),
        Column(
          children: [
            Container(
              width: 10.w,
              height: 10.w,
              decoration: const BoxDecoration(
                  color: Colors.green, shape: BoxShape.circle),
            ),
            Container(
              width: 2.w,
              height: 55.h,
              color: Colors.green.withOpacity(0.3),
            ),
          ],
        ),
      ],
    );
  }
}