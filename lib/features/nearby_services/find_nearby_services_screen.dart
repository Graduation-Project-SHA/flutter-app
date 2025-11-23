import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../shared/component/searchField/search_field.dart';
import 'hospital_details_screen.dart';

class FindNearbyServicesScreen extends StatefulWidget {
  static const String routeName = "FindNearbyServicesScreen";

  const FindNearbyServicesScreen({super.key});

  @override
  State<FindNearbyServicesScreen> createState() =>
      _FindNearbyServicesScreenState();
}

class _FindNearbyServicesScreenState extends State<FindNearbyServicesScreen> {
  final LatLng initialPosition = LatLng(30.0444, 31.2357);

  final List<Map<String, String>> _hospitals = [
    {
      "name": "مستشفى نور الشروق",
      "address": "طريق الشباب | المتميز",
      "distance": "1.2 كم",
      "time": "20 دقيقة",
    },
    {
      "name": "مستشفى نور الشروق",
      "address": "طريق الشباب | المتميز",
      "distance": "3.5 كم",
      "time": "15 دقيقة",
    },
    {
      "name": "مستشفى نور الشروق",
      "address": "طريق الشباب | المتميز",
      "distance": "5 كم",
      "time": "25 دقيقة",
    },
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: FlutterMap(
              options: MapOptions(
                center: initialPosition,
                zoom: 13,
                minZoom: 5,
                maxZoom: 18,
              ),
              children: [
                TileLayer(
                    urlTemplate: "https://cartodb-basemaps-a.global.ssl.fastly.net/light_all/{z}/{x}/{y}.png"
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: initialPosition,
                      width: 20,
                      height: 20,
                      builder: (context) => Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                    Marker(
                      point: LatLng(30.05, 31.25),
                      width: 100,
                      height: 100,
                      builder: (context) => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 3,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Text(
                              "Hospital 1",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Image(image: AssetImage("assets/images/shield-plus.png"),width:32.w ,height: 32.h,)

                        ],
                      ),
                    ),
                    Marker(
                      point: LatLng(55.05,21.25),
                      width: 40,
                      height: 40,
                      builder: (context) => Image(image: AssetImage("assets/images/shield-plus.png"),width:32.w ,height: 32.h,)
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Center(
                          child: Text(
                            "مسعف قريب",
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(width: 75.5.w),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14.w),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
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
                    SizedBox(height: 32.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.w),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: const SearchField(
                          hint: "البحث عن مستشفى",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.45,
            maxChildSize: 0.85,
            minChildSize: 0.1,
            builder: (context, scrollController) {
              return ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      _buildSheetHandle(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () => scrollController.animateTo(
                                0.0,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeOut,
                              ),
                              child: Icon(Icons.close, color: Colors.black, size: 24.w),
                            ),
                            SizedBox(width: 30.w),
                            Text(
                              "مستشفيات قريبة مني",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          controller: scrollController,
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          itemCount: _hospitals.length,
                          itemBuilder: (context, index) {
                            final hospital = _hospitals[index];
                            return _hospitalCard(
                              name: hospital["name"]!,
                              address: hospital["address"]!,
                              distance: hospital["distance"]!,
                              time: hospital["time"]!,
                              onCallPressed: () {
                                Navigator.pushNamed(context, HospitalDetailsScreen.routeName);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
  Widget _buildSheetHandle() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Container(
          width: 40.w,
          height: 5.h,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(5.r),
          ),
        ),
      ),
    );
  }
  Widget _hospitalCard({
    required String name,
    required String address,
    required String distance,
    required String time,
    required VoidCallback onCallPressed,
  }) {
    const Color primaryRed = Color(0xFFE7000B);
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 65.w,
                height: 65.w,
                decoration: BoxDecoration(
                  color: primaryRed,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3.w),
                  boxShadow: [
                    BoxShadow(
                      color: primaryRed.withOpacity(0.5),
                      blurRadius: 8.r,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Image(image: AssetImage("assets/images/shield_red.png"),width:27.2.w,height:34.h,)
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        address,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.right,
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildInfoChip(
                          icon: Icons.car_crash,
                          text: time,
                          color: Colors.orange,
                          ),

                          _buildInfoChip(
                            icon: Icons.access_time_filled,
                            text: time,
                            color: Colors.green,
                          ),
                          _buildInfoChip(
                            icon: Icons.location_on,
                            text: distance,
                            color: primaryRed,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onCallPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffE7000B),
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.r),
                ),
                elevation: 0,
              ),
              child: Text(
                "تفاصيل أو طلب سيارة إسعاف",
                style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
        icon,
        color: color,
        size: 16.w,
      ),
        SizedBox(width: 4.w),
        Text(
          text,
          style: TextStyle(
            fontSize: 13.sp,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}