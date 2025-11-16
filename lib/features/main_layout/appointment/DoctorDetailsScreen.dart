import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'AppointmentTimeScreen.dart';

class DoctorDetailsScreen extends StatelessWidget {
  static const String routeName = "DoctorDetailsScreen";
  const DoctorDetailsScreen({super.key});

  Widget _buildUserReview(String name, String date, String review, String image) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),

      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 0.w),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(radius: 20.r, backgroundImage: AssetImage("assets/images/doctor.png")),
                    SizedBox(width: 12.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name, style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold)),
                        SizedBox(height: 4.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("4.5", style: TextStyle(fontSize: 13.sp, color: Colors.black87)),
                            SizedBox(width: 4.w),
                            Icon(Icons.star, color: Colors.amber, size: 16.sp),
                            Icon(Icons.star, color: Colors.amber, size: 16.sp),
                            Icon(Icons.star, color: Colors.amber, size: 16.sp),
                            Icon(Icons.star, color: Colors.amber, size: 16.sp),
                            Icon(Icons.star, color: Colors.grey.shade300, size: 16.sp),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(width: 8.w),

                  ],
                ),
              ),
              SizedBox(
                width: 50.w,
                child: Text(
                  date,
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              review,
              style: TextStyle(fontSize: 13.sp, color: Colors.black87),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xff4786F5);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "أطباء أنف وأذن وحنجرة",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(radius: 35.r, backgroundImage: const AssetImage("assets/images/doctor.png")),
                    SizedBox(width: 24.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("د. مرام علي", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                          Text("أنف وأذن وحنجرة", style: TextStyle(fontSize: 14.sp, color: Colors.grey)),
                          SizedBox(height: 4.h),
                          Text("سعر الكشف: 300 جنيه", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.black87)),
                          SizedBox(height: 16.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text("ساعات العمل", style: TextStyle(fontSize: 13.sp, color: Colors.black87)),
                                      SizedBox(width: 4.w),
                                      Icon(Icons.access_time_filled, color: primaryColor, size: 16.sp),
                                    ],
                                  ),
                                  SizedBox(height: 4.h),
                                  Text("07:00 صباحاً - 07:00 مساءً", style: TextStyle(fontSize: 15.sp, color: Colors.black, fontWeight: FontWeight.w600)),
                                ],
                              ),
                              SizedBox(width: 15.w),
                              Container(
                                height: 40.h,
                                width: 1.w,
                                color: Colors.grey.shade300,
                              ),
                              SizedBox(width: 15.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.local_hospital, color: Colors.red.shade700, size: 16.sp),
                                      SizedBox(width: 4.w),
                                      Text("المستشفى", style: TextStyle(fontSize: 13.sp, color: Colors.black87)),
                                    ],
                                  ),
                                  SizedBox(height: 4.h),
                                  Text("القصر العيني", style: TextStyle(fontSize: 15.sp, color: Colors.black, fontWeight: FontWeight.w600)),
                                ],
                              ),

                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 24.w),
                  ],
                ),
                SizedBox(height: 28.h),
                Text("سيرة ذاتية", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold), textAlign: TextAlign.right),
                SizedBox(height: 8.h),
                Text(
                  "دكتورة مرام علي، أخصائية أنف وأذن وحنجرة، وتعمل في القصر العيني. إنها حقيقة مثبتة منذ زمن طويل أن المحتوى المقروء سيشتت انتباه القارئ......",
                  style: TextStyle(fontSize: 13.sp, color: Colors.black87),
                  textAlign: TextAlign.right,
                ),
                SizedBox(height: 28.h),

                Text("موقع العيادة", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold), textAlign: TextAlign.right),
                SizedBox(height: 8.h),
                Text(
                  "العميل: قسم مصر القديمة، محافظة القاهرة 11956",
                  style: TextStyle(fontSize: 13.sp, color: Colors.black87),
                  textAlign: TextAlign.right,
                ),
                Container(
                  height: 150.h,
                  margin: EdgeInsets.symmetric(vertical: 8.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: Colors.grey[200],
                  ),
                  child: Center(child: Text("خريطة", style: TextStyle(fontSize: 16.sp))),
                ),
                SizedBox(height: 20.h),

                Text("التقييمات (74)", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold), textAlign: TextAlign.right),
                SizedBox(height: 12.h),

                _buildUserReview("أحمد كريم", "اليوم", "قمة في الذوق والادب وخبرة في مجالها", "assets/images/user.png"),
                _buildUserReview("محمود ممدوح", "اليوم", "لما روحت للدكتورة مرام، أول حاجة عجبتني إنها سمعت كل شكوتي بالتفصيل ومقاطعتنيش، وكانت صبورة جداً. شرحتلي المشكلة ببساطة ومن غير مصطلحات طبية مكلكعة", "assets/images/user.png"),

                SizedBox(height: 100.h),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
              ),
              child: Row(
                children: [
                  IconButton(onPressed: (){}, icon:Image(image: AssetImage("assets/images/message-text_icon.png"))),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppointmentTimeScreen.routeName);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
                        padding: EdgeInsets.symmetric(vertical: 13.5.h),
                      ),
                      child: Text("حجز موعد", style: TextStyle(fontSize: 14.sp, color: Colors.white, fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}