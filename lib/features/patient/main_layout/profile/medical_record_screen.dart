import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care_project/shared/component/customAppbarButton/custom_app_bar_button.dart';

class MedicalRecordScreen extends StatelessWidget {
  static const String routeName = "MedicalRecordScreen";

  const MedicalRecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.more_horiz, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          CustomAppBarBtn(),
        ],
        title: Text("السجل الطبي",
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical:32.h),
          children: [
            _buildSectionTitle("هذا الشهر"),
            SizedBox(height: 24.h),
            _buildRecordItem(
              date: "25 فبراير",
              title: "نهاية المراقبة",
              details: [],
            ),

            _buildRecordItem(
              date: "25 فبراير",
              title: "تحليل الدم",
              details: [
                "خلايا الدم الحمراء: 4.10 مليون خلية/مل",
                "الهيموجوبلين: 142 جرام/لتر",
                "الهيماتوكريت: 33.6 %",
                "خلايا الدم البيضاء: 3.850 خلية/مل",
              ],
            ),

            _buildRecordItem(
              date: "25 فبراير",
              title: "تحليل الدم",
              details: [
                "خلايا الدم الحمراء: 3.90 مليون خلية/مل",
                "الهيموجوبلين: 122 جرام/لتر",
                "الهيماتوكريت: 47.7 %",
                "خلايا الدم البيضاء: 4.300 خلية/مل",
              ],
            ),

            SizedBox(height: 32.h),

            _buildSectionTitle("يناير"),
            SizedBox(height: 24.h),
            _buildRecordItem(
              date: "25 فبراير",
              title: "نهاية المراقبة",
              details: [],
            ),
            _buildRecordItem(
              date: "25 فبراير",
              title: "تحليل الدم",
              details: [
                "خلايا الدم الحمراء: 4.30 مليون خلية/مل",
                "الهيموجوبلين: 132 جرام/لتر",
                "الهيماتوكريت: 37.7 %",
                "خلايا الدم البيضاء: 4.700 خلية/مل",
              ],
            ),
            _buildRecordItem(
              date: "25 فبراير",
              title: "تحليل الدم",
              details: [
                "خلايا الدم الحمراء: 3.90 مليون خلية/مل",
                "الهيموجوبلين: 118 جرام/لتر",
                "الهيماتوكريت: 38.7 %",
                "خلايا الدم البيضاء: 4.500 خلية/مل",
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h, top: 8.h),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildRecordItem({
    required String date,
    required String title,
    required List<String> details,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 70.w,
            child: Text(
              date,
              style: TextStyle(
                fontSize: 14.sp,
                color: Color(0xff757575),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(width: 20.w,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),

                if (details.isNotEmpty) ...[
                  SizedBox(height: 8.h),
                  ...details.map((detail) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 4.h),
                      child: Text(
                        detail,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Color(0xff242424),
                          height: 1.4,
                        ),
                      ),
                    );
                  }),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}