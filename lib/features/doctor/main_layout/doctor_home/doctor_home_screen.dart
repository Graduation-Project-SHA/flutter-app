import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:health_care_project/core/%20theme/app_colors.dart';
import 'package:health_care_project/features/doctor/main_layout/doctor_home/widgets/time_filter_widget.dart';
import 'package:hive/hive.dart';

class DoctorHomeScreen extends StatefulWidget {
  static const String routeName = "HomeScreen";

  const DoctorHomeScreen({super.key});

  @override
  State<DoctorHomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<DoctorHomeScreen> {
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

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 17.h),
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
                            "  مرحبا, $userName",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Row(
                            children: [
                              Text("كيف الحال",
                                style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 36.w,
                        height: 36.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: SvgPicture.asset("assets/images/bill_icon.svg",),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Column(
                children: [
                  SizedBox(height: 24.h),
                  const TimeFilterWidget(),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSideBySideCard(
                          title: "4,500",
                          description: "مدفوعات",
                          cardColor: const Color(0xffEBF2E9),

                          icon:  "assets/images/pay.png",
                          bgicon: const Color(0xffDBE6D5),
                        ),
                      ),
                      SizedBox(width: 19.w),
                      Expanded(
                        child: _buildSideBySideCard(
                          title: "45",
                          description: "حجز",
                          cardColor: const Color(0xffF0F0FF),
                          icon: "assets/images/appointment.png",
                          bgicon: const Color(0xffCCCCFF),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 32.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "الحجوزات الجديدة",
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  Text(
                    "الحجوزات الجديدة",
                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color:AppColors.gradientColor2),
                  ),
                ],
              ),
              SizedBox(height:24.h),
              _buildUpcomingAppointmentCard(
                doctorName: "محمد ممدوح",
                specialty: "نوع الحجز نفسي",
                date: "الأربعاء, 10 نوفمبر, 2025",
                time: "11:00",
                doctorImage: "assets/images/person_image.png",
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "تقييماتى",
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  Text(
                    "عرض الكل",
                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color:AppColors.gradientColor2),
                  ),
                ],
              ),
              SizedBox(height: 18.h),
              ListView.builder(
                itemCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return _buildDoctorCard(
                    name: "احمد عادل",
                    specialty: "دكتور محترم ومستمع جيد وتم تشخيصي من اول مرة بعد معاناة بلا فائدة",
                    image: "assets/images/memoji.png",
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
    required Color cardColor,
    required String icon,
    required Color bgicon,

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
            child: Image.asset(icon, height: 39.h,width:40.w ,),
          ),
          SizedBox(height: 12.h),
          Text(title, style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.black), textAlign: TextAlign.center),

          Text(description, style: TextStyle(fontSize: 16.sp, color: Colors.black), textAlign: TextAlign.center, maxLines: 3, overflow: TextOverflow.ellipsis),
          SizedBox(height: 15.h),

        ],
      ),
    );
  }

  Widget _buildDoctorCard({required String name, required String specialty, required String image}) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.r), border: Border.all(color: const Color(0xffEDF1F3), width: 0.75)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                    width: 48.w,
                    height: 48.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999.r),
                      image: DecorationImage(image: AssetImage(image),),
                    ),
                  ),
                    SizedBox(width: 16.w),
                    Column(
                      children: [
                        Text(name, style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold)),
                        Text("⭐⭐⭐⭐⭐", style: TextStyle(fontSize: 16.sp, )),
                      ],
                    ),
                  ],
                ),
                SizedBox(height:12.h),
                Text(specialty, style: TextStyle(fontSize: 14.sp, color: Colors.grey[700])),
              ],
            ),
          ),
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
                      SizedBox(width:12.w ,),
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
