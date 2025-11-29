import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'AppointmentTimeScreen.dart';

class DoctorDetailsScreen extends StatelessWidget {
  static const String routeName = "DoctorDetailsScreen";
  const DoctorDetailsScreen({super.key});

  Widget _wrapInContainer(Widget child) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: child,
    );
  }

  Widget _doctorHeader() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(radius: 35.r, backgroundImage: AssetImage("assets/images/doctor.png")),
            SizedBox(width: 24.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("د. مرام علي", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                  Text("أنف وأذن وحنجرة", style: TextStyle(fontSize: 14.sp, color: Colors.grey)),
                  SizedBox(height: 4.h),
                  Text(
                    "سعر الكشف: 300 جنيه",
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.black87),
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Image(image: AssetImage("assets/images/time-fill.png")),
                    SizedBox(width: 4.w),
                    Text("ساعات العمل", style: TextStyle(fontSize: 13.sp, color: Colors.black87)),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  "07:00 صباحاً - 07:00 مساءً",
                  style: TextStyle(fontSize: 15.sp, color: Colors.black, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Container(height: 40.h, width: 1.w, color: Colors.grey.shade300),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image(image: AssetImage("assets/images/redhospital.png")),
                    SizedBox(width: 4.w),
                    Text("المستشفى", style: TextStyle(fontSize: 13.sp, color: Colors.black87)),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  "القصر العيني",
                  style: TextStyle(fontSize: 15.sp, color: Colors.black, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _bioSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("سيرة ذاتية", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
        SizedBox(height: 8.h),
        Text(
          "دكتورة مرام علي، أخصائية أنف وأذن وحنجرة، وتعمل في القصر العيني...",
          style: TextStyle(fontSize: 13.sp, color: Colors.black87),
          textAlign: TextAlign.right,
        ),
      ],
    );
  }

  Widget _clinicLocation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("موقع العيادة", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
        SizedBox(height: 8.h),
        Text(
          "المنيل: قسم مصر القديمة، محافظة القاهرة 11956",
          style: TextStyle(fontSize: 13.sp, color: Colors.black87),
          textAlign: TextAlign.right,
        ),
        Container(
          height: 150.h,
          margin: EdgeInsets.symmetric(vertical: 8.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            color: Colors.white,
          ),
          child: Center(child: Image(image: AssetImage("assets/images/Maps.png"),fit: BoxFit.cover,)),
        ),
      ],
    );
  }

  Widget _buildUserReview(String name, String date, String review, String image) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(radius: 20.r, backgroundImage: AssetImage(image)),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4.h),
                    Row(
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
              ],
            ),
            SizedBox(
              width: 50.w,
              child: Text(date, style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(review, style: TextStyle(fontSize: 13.sp, color: Colors.black87), textAlign: TextAlign.right),
        ),
      ],
    );
  }

  Widget _reviewsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("التقييمات (74)", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
        SizedBox(height: 12.h),
        _buildUserReview(
          "أحمد كريم",
          "اليوم",
          "قمة في الذوق والادب وخبرة في مجالها",
          "assets/images/user.png",
        ),
        SizedBox(height: 12.h),
        Divider(color: Color(0xffF3F4F6),),
        SizedBox(height: 12.h),
        _buildUserReview(
          "محمود ممدوح",
          "اليوم",
          "لما روحت للدكتورة مرام، أول حاجة عجبتني إنها سمعت كل شكوتي بالتفصيل ومقاطعتنيش، وكانت صبورة جداً. شرحتلي المشكلة ببساطة ومن غير مصطلحات طبية مكلكعة",
          "assets/images/user.png",
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xff4786F5);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("أطباء أنف وأذن وحنجرة", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.black)),
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
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_forward_ios, size: 18.sp),
              ),
            ),
          ),
        ],
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
                _wrapInContainer(_doctorHeader()),
                _wrapInContainer(_bioSection()),
                _wrapInContainer(_clinicLocation()),
                _wrapInContainer(_reviewsSection()),
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
              decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)]),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Image(image: AssetImage("assets/images/message-icon.png")),
                  ),
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
