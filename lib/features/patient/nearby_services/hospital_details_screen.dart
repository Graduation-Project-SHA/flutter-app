import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:health_care_project/core/%20theme/app_colors.dart';
import 'package:latlong2/latlong.dart';
import 'emergency_request_screen.dart';

class HospitalDetailsScreen extends StatelessWidget {
  static const String routeName = "HospitalDetailsScreen";

  HospitalDetailsScreen({super.key});

  final LatLng hospitalLocation =  LatLng(30.0444, 31.2357);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
          title: Text("تفاصيل المستشفى",
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.black),
          ),
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
          onPressed: (){Navigator.pop(context);},
          icon: Icon(Icons.arrow_forward_ios, size: 18.sp),
        ),
      ),),
    ],
        backgroundColor: Colors.white,
        elevation: 0,

      ),

      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 27.04.w, vertical:24.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _hospitalCard(),
              SizedBox(height: 24.h),
              SizedBox(
                width: 321.w,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, EmergencyRequestScreen.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffE7000B),
                    padding: EdgeInsets.symmetric(vertical: 17.5.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "طلب سيارة إسعاف",
                        style: TextStyle(fontSize: 16.sp, color: Colors.white),
                      ),
                    ],
                  ),

                ),
              ),
              SizedBox(height: 24.h),
              _contactInfoCard(),
              SizedBox(height: 24.h),
              _workingHoursCard(),
              SizedBox(height: 24.h),
              _mapCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _hospitalCard() {
    return Container(
      width:320.92.w,
      height: 181.88.h,
      padding: EdgeInsets.all(16.w),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "مستشفى نور الشروق",
            style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold,color:AppColors.gradientColor2),
          ),
          SizedBox(height: 15.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on_outlined, color: Colors.blue, size: 20.sp),
              SizedBox(width:17.w),
              Expanded(
                child: Text(
                  "طريق الشباب، مدينة الشروق، القاهرة - مصر",
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 16.sp, color: Colors.grey[700]),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }

  Widget _contactInfoCard() {
    return Container(
      width:320.92.w,
      height: 181.88.h,
      padding: EdgeInsets.all(24.w),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.phone, color: Colors.blue),
              Text(
                "  معلومات الاتصال والحجز",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Divider(color: Colors.grey[600],),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Color(0xffEAF1FF),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image(image: AssetImage("assets/images/j.png"),height:30.h,width: 30.w,),
                Text("رقم الحجز", style: TextStyle(fontSize: 16.sp,color: Color(0xff364153))),
                Text(
                  "02-87654321",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600),
                ),
               ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _workingHoursCard() {
    return Container(
      width:320.92.w,
      height: 181.88.h,
      padding: EdgeInsets.all(16.w),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.access_time, color: Colors.blue),
              Text(
                "  ساعات العمل",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Divider(color: Colors.grey[600],),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.circle, color: Colors.green, size: 12),
                Text(
                  "مفتوح الآن",
                  style: TextStyle(color: Colors.green, fontSize: 15.sp),
                ),
                Icon(Icons.access_time, color: Colors.green),
                Text(
                  "24 ساعة طوال الأسبوع",
                  style: TextStyle(fontSize: 14.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _mapCard() {
    return Container(
      width:320.92.w,
      height: 422.66.h,
      padding: EdgeInsets.all(24.w),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image(image: AssetImage("assets/images/direction.png")),
              SizedBox(width: 6.w),
              Text(
                "كيفية الوصول",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Divider(color: Colors.grey[600],),
          SizedBox(height: 12.h),
          SizedBox(
            height: 200.h,
            child: FlutterMap(
              options: MapOptions(
                center: hospitalLocation,
                zoom: 15,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                  "https://cartodb-basemaps-a.global.ssl.fastly.net/light_all/{z}/{x}/{y}.png",
                  userAgentPackageName: 'com.example.health_care_project',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: hospitalLocation,
                      width: 40,
                      height: 40,
                      builder: (context) =>   Image(image: AssetImage("assets/images/shield-plus.png"),width:32.w ,height: 32.h,)
                    )
                  ],
                )
              ],
            ),
          ),

          SizedBox(height: 12.h),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gradientColor2,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: AssetImage("assets/images/direction.png"),height:12.h,width:12.w,),
                  SizedBox(width: 8.w),
                  Text(
                    "احصل على التوجيهات",
                    style: TextStyle(fontSize: 14.sp, color: Colors.white),
                  ),
                ],
              ),

            ),
          )
        ],
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.r),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 6.r,
          offset: const Offset(0, 3),
        )
      ],
    );
  }
}
