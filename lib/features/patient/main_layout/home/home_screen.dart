import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:health_care_project/core/%20theme/app_colors.dart';
import 'package:hive/hive.dart';
import '../../../../shared/component/filterButton/filter_button.dart';
import '../../../../shared/component/searchField/search_field.dart';
import '../../nearby_services/find_nearby_services_screen.dart';
import '../main_layout.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "HomeScreen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Box authBox;

  @override
  void initState() {
    super.initState();
    authBox = Hive.box('authBox');
  }

  @override
  Widget build(BuildContext context) {
    final userName = authBox.get('userName');
    final userImage = authBox.get('userImage');
    final location = 'القاهرة, دار السلام';

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24.r,
                        backgroundImage: userImage != null
                            ? NetworkImage(userImage)
                            : const AssetImage("assets/images/doctor.png") as ImageProvider,
                      ),
                      SizedBox(width: 24.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            " $userName ",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.location_on, size: 16.sp, color: Colors.black),
                              SizedBox(width: 4.w),
                              Text(
                                location,
                                style: TextStyle(fontSize: 14.sp, color: Colors.black),
                              ),
                              SizedBox(width: 4.w),
                              Icon(Icons.keyboard_arrow_down_sharp, size: 16.sp, color: Colors.black),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 30.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: SvgPicture.asset("assets/images/bill_icon.svg",),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Text(
                "المواعيد القادمة",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              SizedBox(height: 8.h),
              _buildUpcomingAppointmentCard(
                doctorName: "د.محمد مرعي",
                specialty: "استشاري مخ واعصاب",
                date: "الأربعاء, 10 نوفمبر, 2025",
                time: "11:00",
                doctorImage: "assets/images/doctor.png",
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: SearchField(
                      hint: "البحث عن طبيب...",
                      onChanged: (value) {
                        print("بحث عن: $value");
                      },
                    ),
                  ),
                  SizedBox(width: 8.w),
                  FilterButton(
                    onPressed: () {
                      print("فتح الفلتر");
                    },
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: _buildSideBySideCard(
                      title: "حجز موعد",
                      description: "اختر الدكتور المناسب في التخصص الذي تحتاجه",
                      buttonText: "حجز موعد",
                      cardColor: const Color(0xffF0F0FF),
                      buttonColor: const Color(0xff6161FF),
                      icon: "assets/images/appointment.png",
                      bgicon: const Color(0xffCCCCFF),
                      onButtonPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const MainLayout(selectedIndex: 2)),
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: _buildSideBySideCard(
                      title: "مسعف قريب",
                      description: "استكشف المستشفيات والاطباء والممرضين الاقرب",
                      buttonText: "ابحث عن مسعف",
                      cardColor: const Color(0xffFDF1F2),
                      buttonColor: const Color(0xffE6474F),
                      icon: "assets/images/hospital.png",
                      bgicon: const Color(0xffF9D2D4),
                      onButtonPressed: () {
                        Navigator.pushNamed(context, FindNearbyServicesScreen.routeName);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "خدماتنا",
                    style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.black87),
                  ), Text(
                    "عرض الكل",
                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color:AppColors.gradientColor2),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              SizedBox(
                height: 100.h,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildServiceCard("assets/images/Home_care.png","رعاية منزلية"),
                    _buildServiceCard("assets/images/Medicine.png","أدوية"),
                    _buildServiceCard("assets/images/Nurse.png", "ممرضة"),
                    _buildServiceCard("assets/images/donors.png", "متبرعون"),
                    _buildServiceCard("assets/images/doctor_logo.png", "طبيب"),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "أشهر الأطباء",
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  Text(
                    "عرض الكل",
                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color:AppColors.gradientColor2),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              ListView.builder(
                itemCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return _buildDoctorCard(
                    rating: 4.8,
                    name: "د.محمد مرعي",
                    specialty: "استشاري مخ واعصاب",
                    image: "assets/images/doctor.png",
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSideBySideCard({
    required String title,
    required String description,
    required String buttonText,
    required Color cardColor,
    required Color buttonColor,
    required String icon,
    required Color bgicon,
    VoidCallback? onButtonPressed,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(color: bgicon, shape: BoxShape.circle),
            child: Image.asset(icon, height: 45.w),
          ),
          SizedBox(height: 12.h),
          Text(title, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.black87), textAlign: TextAlign.center),
          SizedBox(height: 8.h),
          Text(description, style: TextStyle(fontSize: 12.sp, color: Colors.black54), textAlign: TextAlign.center, maxLines: 3, overflow: TextOverflow.ellipsis),
          SizedBox(height: 15.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onButtonPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
                padding: EdgeInsets.symmetric(vertical: 8.h),
              ),
              child: Text(buttonText, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(String imagePath, String title) {
    return Container(
      width: 74.25.w,
      height: 78.75.h,
      margin: EdgeInsets.only(right: 16.w),
      padding: EdgeInsets.symmetric(vertical: 7.5.h, horizontal: 5.w),
      decoration: BoxDecoration(
        color: const Color(0xffFFFFFF),
        borderRadius: BorderRadius.circular(7.5.r),
        border: Border.all(color: const Color(0xffEDF1F3), width: 0.75),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, height: 45.h, width: 45.w),
          SizedBox(height: 5.h),
          Text(title, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500), textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }

  Widget _buildDoctorCard({required double rating, required String name, required String specialty, required String image}) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.r), border: Border.all(color: const Color(0xffEDF1F3), width: 0.75)),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 89.w,
                height: 112.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        SizedBox(width: 4.w),
                        Text(rating.toString(), style: TextStyle(fontSize: 13.sp, color: Colors.black54)),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text(name, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8.h),
                    Text(specialty, style: TextStyle(fontSize: 13.sp, color: Colors.grey[700])),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ElevatedButton(onPressed: () {}, child: Text("ارسال رسالة")),
        ],
      ),
    );
  }

  Widget _buildUpcomingAppointmentCard({required String doctorName, required String specialty, required String date, required String time, required String doctorImage}) {
    return Container(
      width: double.infinity,
      height: 160.h,
      decoration: BoxDecoration(color: const Color(0xff4786F5), borderRadius: BorderRadius.circular(16.r)),
      child: Stack(
        children: [
          Positioned(top: -2.46.h, left: -42.w, child: Opacity(opacity: 0.1, child: Image.asset('assets/images/Blob1.png', width: 175.17.w, height: 107.93.h))),
          Positioned(top: -17.h, left: -33.38.w, child: Opacity(opacity: 0.1, child: Image.asset('assets/images/Blob2.png', width: 158.84.w, height: 137.h))),
          Positioned(top: 47.54.h, left: 205.w, child: Opacity(opacity: 0.1, child: Image.asset('assets/images/Blob3.png', width: 175.17.w, height: 107.93.h))),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 48.w,
                        height: 48.h,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r), image: DecorationImage(image: AssetImage(doctorImage), fit: BoxFit.cover)),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(doctorName, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.white)),
                          SizedBox(height: 4.h),
                          Text(specialty, style: TextStyle(fontSize: 13.sp, color: Colors.white70)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 12.5.h),
                  Container(
                    width: double.infinity,
                    height: 44.h,
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.access_time, size: 18.sp, color: Colors.grey.shade600),
                        Text("الموعد:"),
                        Text(time, style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600, color: Colors.black)),
                        Icon(Icons.calendar_month, size: 18.sp, color: Colors.grey.shade600),
                        Text(date, style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600, color: Colors.black87)),
                      ],
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
