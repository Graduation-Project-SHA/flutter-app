import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../shared/component/filterButton/filter_button.dart';
import '../../../shared/component/searchField/search_field.dart';
import '../main_layout/appointment/Payment.dart';
import 'nurse_details_screen.dart';

class NursesListScreen extends StatelessWidget {
  static const String routeName = "NursesListScreen";


  final List<Map<String, dynamic>> nurses = [
    {
      "name": "احمد محمود السيد",
      "specialty": "ممرض متخصص في العناية المركزة",
      "rate": "4.8",
      "price": "50 جنيه",
      "image": "assets/images/nurse_ahmed.png",
    },
    {
      "name": "فاطمة عبدالرحمن",
      "specialty": "ممرضة اطفال معتمدة",
      "rate": "4.8",
      "price": "50 جنيه",
      "image": "assets/images/nurse_fatma.png",
    },
    {
      "name": "سارة محمد يوسف",
      "specialty": "ممرضة رعاية مسنين",
      "rate": "4.8",
      "price": "50 جنيه",
      "image": "assets/images/nurse_sara.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "رعاية منزلية",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color.fromRGBO(205, 205, 205, 1)),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_forward_ios, size: 18.sp, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            Row(
              children: [ Expanded(
                child: SearchField(
                  hint: "البحث عن ممرضة..",
                  onChanged: (_) {},
                ),
              ),

                SizedBox(width: 8.w),
                FilterButton(onPressed: () {}),
              ],
            ),
            SizedBox(height: 40.h),
            Text(
              "ممرضين قريبون",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.h),

            Expanded(
              child: ListView.builder(
                itemCount: nurses.length,
                itemBuilder: (context, index) {
                  return _buildNurseCard(context, nurses[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNurseCard(BuildContext context, Map<String, dynamic> nurse) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(
                nurse['image'],
                width: 89.w,
                height: 112.h,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 89.w,
                    height: 112.h,
                    color: Colors.grey[200],
                    child: Icon(Icons.person, color: Colors.grey, size: 40.sp),
                  );
                },
              ),
            ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.star, color: Colors.orange, size: 16.sp),
                        SizedBox(width: 4.w),
                        Text(nurse['rate'],
                            style: TextStyle(color: Colors.black, fontSize: 12.sp)),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      nurse['name'],
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      nurse['specialty'],
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                    ),
                  ],
                ),
              ),



            ],
          ),
          SizedBox(height: 16.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 16.h),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F6FE),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              children: [
                Text(
                  "سعر ساعة الرعاية المنزلية",
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
                ),
                Text(
                  nurse['price'],
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2B73F3),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Payment(
                          doctorProfileId: nurse['id']?.toString() ?? "0",
                          serviceId: 1,
                          appointmentDate: "2026-04-25",
                          startTime: "10:00 AM",
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2B73F3),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.r)),
                    elevation: 0,
                  ),
                  child: const Text("حجز",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NurseDetailsScreen(nurse: nurse),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF2B73F3)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.r)),
                  ),
                  child: const Text("تفاصيل",
                      style: TextStyle(
                          color: Color(0xFF2B73F3), fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}