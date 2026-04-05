import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'care_map_screen.dart';

class CareScreen extends StatefulWidget {
  static const String routeName = "CareScreen";

  const CareScreen({super.key});

  @override
  State<CareScreen> createState() => _CareScreenState();
}

class _CareScreenState extends State<CareScreen> {
  String? selectedGender ;
  List<String> selectedServices = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "رعاية منزلية",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18.sp),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
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
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_forward_ios, size: 18.sp),
              ),
            ),
          ),
        ],

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 100.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("من هو المريض؟", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 16.h),
              _buildGenderOption("رجل"),
              SizedBox(height: 12.h),
              _buildGenderOption("امرأة"),
              SizedBox(height: 12.h),
              _buildGenderOption("طفل/طفلة"),
              SizedBox(height: 42.h),
              Text("تبرعات", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 16.h),
        
              Wrap(
                spacing: 8.w,
                runSpacing: 10.h,
                alignment: WrapAlignment.start,
                children: [
                  _buildServiceChip("رعاية طويلة الأمد"),
                  _buildServiceChip("رعاية ما بعد العمليات"),
                  _buildServiceChip("حقن ومحاليل"),
                  _buildServiceChip("غيار جروح"),
                  _buildServiceChip("قياسات حيوية"),
                ],
              ),
        
              SizedBox(height: 42.h,),
        
        
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2B73F3),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
                  ),
                  onPressed: () {
                     Navigator.pushNamed(context, CareMapScreen.routeName);
                  },
                  child: Text("متابعة", style: TextStyle(fontSize: 14.sp, color: Colors.white)),
                ),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildGenderOption(String title) {
    bool isSelected = selectedGender == title;
    return GestureDetector(
      onTap: () => setState(() => selectedGender = title),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          border: Border.all(color: isSelected ? Color(0xFF2B73F3) : Colors.grey.shade200),
          borderRadius: BorderRadius.circular(10.r),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(fontSize: 16.sp)),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: isSelected ? Color(0xFF2B73F3) : Colors.grey.shade300, width: 2),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: isSelected
                    ? Icon(Icons.circle, size: 12.sp, color: Color(0xFF2B73F3))
                    : SizedBox(width: 12.sp, height: 12.sp),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildServiceChip(String label) {
    bool isSelected = selectedServices.contains(label);
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected ? selectedServices.remove(label) : selectedServices.add(label);
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF2B73F3) : Colors.white,
          borderRadius: BorderRadius.circular(7.5.r),
          border: Border.all(color: isSelected ? Color(0xFF2B73F3) : Colors.grey.shade200),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade500,
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }
}