import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:health_care_project/core/%20theme/app_colors.dart';
import 'package:hive/hive.dart';
import 'doctor_home_cubit/doctor_home_appointment_model.dart';
import 'doctor_home_cubit/doctor_home_cubit.dart';
import 'doctor_home_cubit/doctor_home_state.dart';
import 'doctor_reviews_cubit/doctor_review_model.dart';
import 'widgets/time_filter_widget.dart';

class DoctorHomeScreen extends StatefulWidget {
  static const String routeName = 'HomeScreen';

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
    context.read<DoctorHomeCubit>().getHomeData();
  }

  @override
  Widget build(BuildContext context) {
    final firstName = authBox.get('firstName') ?? '';
    final lastName = authBox.get('lastName') ?? '';
    final userName = '$firstName $lastName'.trim();
    final userImage = authBox.get('profileImage');

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
                        backgroundImage: (userImage != null &&
                            userImage.toString().isNotEmpty)
                            ? NetworkImage(
                            'http://wiqaya.duckdns.org:3000$userImage')
                            : const AssetImage('assets/images/doctor.png')
                        as ImageProvider,
                        onBackgroundImageError: (_, __) {},
                      ),
                      SizedBox(width: 24.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'مرحبا, $userName',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'كيف الحال',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: 36.w,
                    height: 36.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: SvgPicture.asset('assets/images/bill_icon.svg'),
                  ),
                ],
              ),

              SizedBox(height: 24.h),

              TimeFilterWidget(
                onFilterChanged: (period) {
                  context.read<DoctorHomeCubit>().getHomeData();
                },
              ),

              SizedBox(height: 24.h),

              Row(
                children: [
                  Expanded(
                    child: _buildSideBySideCard(
                      title: '4,500',
                      description: 'مدفوعات',
                      cardColor: const Color(0xffEBF2E9),
                      icon: 'assets/images/pay.png',
                      bgicon: const Color(0xffDBE6D5),
                    ),
                  ),
                  SizedBox(width: 19.w),
                  Expanded(
                    child: _buildSideBySideCard(
                      title: '45',
                      description: 'حجز',
                      cardColor: const Color(0xffF0F0FF),
                      icon: 'assets/images/appointment.png',
                      bgicon: const Color(0xffCCCCFF),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 32.h),

              BlocBuilder<DoctorHomeCubit, DoctorHomeState>(
                builder: (context, state) {
                  if (state is DoctorHomeLoading) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (state is DoctorHomeError) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: Text(
                          state.message,
                          style: TextStyle(color: Colors.red, fontSize: 14.sp),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }

                  if (state is DoctorHomeLoaded) {
                    return Column(
                      children: [
                        // --- الحجوزات ---
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'الحجوزات الجديدة',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              'عرض الكل',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.gradientColor2,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),

                        state.upcomingAppointments.isEmpty
                            ? Center(
                          child: Padding(
                            padding:
                            EdgeInsets.symmetric(vertical: 12.h),
                            child: Text(
                              'لا توجد حجوزات قادمة',
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.grey),
                            ),
                          ),
                        )
                            : _buildUpcomingAppointmentCard(
                          appointment: state.upcomingAppointments.first,
                        ),

                        SizedBox(height: 32.h),

                        // --- التقييمات ---
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'تقييماتى',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            Row(
                              children: [
                                // متوسط التقييم
                                if (state.averageRating > 0) ...[
                                  Icon(Icons.star,
                                      color: Colors.amber, size: 16.sp),
                                  SizedBox(width: 4.w),
                                  Text(
                                    state.averageRating.toStringAsFixed(1),
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                ],
                                Text(
                                  'عرض الكل',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.gradientColor2,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        // AI Summary
                        if (state.aiSummary.isNotEmpty) ...[
                          SizedBox(height: 10.h),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: const Color(0xffEBF2FF),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.auto_awesome,
                                    color: const Color(0xff2B73F3),
                                    size: 16.sp),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: Text(
                                    state.aiSummary,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: const Color(0xff2B73F3),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],

                        SizedBox(height: 16.h),

                        state.reviews.isEmpty
                            ? Center(
                          child: Padding(
                            padding:
                            EdgeInsets.symmetric(vertical: 12.h),
                            child: Text(
                              'لا توجد تقييمات بعد',
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.grey),
                            ),
                          ),
                        )
                            : ListView.builder(
                          itemCount: state.reviews.length > 3
                              ? 3
                              : state.reviews.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return _buildReviewCard(
                                state.reviews[index]);
                          },
                        ),
                      ],
                    );
                  }

                  return const SizedBox.shrink();
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
            child: Image.asset(icon, height: 39.h, width: 40.w),
          ),
          SizedBox(height: 12.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            description,
            style: TextStyle(fontSize: 16.sp, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 15.h),
        ],
      ),
    );
  }

  Widget _buildUpcomingAppointmentCard({
    required DoctorHomeAppointmentModel appointment,
  }) {
    return Container(
      width: double.infinity,
      height: 160.h,
      decoration: BoxDecoration(
        color: const Color(0xff4786F5),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -2.46.h,
            left: -42.w,
            child: Opacity(
              opacity: 0.1,
              child: Image.asset('assets/images/Blob1.png',
                  width: 175.17.w, height: 107.93.h),
            ),
          ),
          Positioned(
            top: -17.h,
            left: -33.38.w,
            child: Opacity(
              opacity: 0.1,
              child: Image.asset('assets/images/Blob2.png',
                  width: 158.84.w, height: 137.h),
            ),
          ),
          Positioned(
            top: 47.54.h,
            left: 205.w,
            child: Opacity(
              opacity: 0.1,
              child: Image.asset('assets/images/Blob3.png',
                  width: 175.17.w, height: 107.93.h),
            ),
          ),
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
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          image: DecorationImage(
                            image: (appointment.patientImage != null)
                                ? NetworkImage(appointment.patientImage!)
                            as ImageProvider
                                : const AssetImage(
                                'assets/images/person_image.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            appointment.patientName,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'نوع الحجز: ${appointment.type}',
                            style: TextStyle(
                                fontSize: 13.sp, color: Colors.white70),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 12.5.h),
                  Container(
                    width: double.infinity,
                    height: 44.h,
                    padding: EdgeInsets.symmetric(
                        horizontal: 8.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.access_time,
                            size: 18.sp, color: Colors.grey.shade600),
                        Text('الموعد:'),
                        Text(
                          appointment.time,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        Icon(Icons.calendar_month,
                            size: 18.sp, color: Colors.grey.shade600),
                        Text(
                          appointment.date,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
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

  Widget _buildReviewCard(DoctorReviewModel review) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xffEDF1F3), width: 0.75),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 24.r,
                      backgroundImage: (review.patientImage != null)
                          ? NetworkImage(review.patientImage!) as ImageProvider
                          : const AssetImage('assets/images/memoji.png'),
                      onBackgroundImageError: (_, __) {},
                    ),
                    SizedBox(width: 12.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          review.patientName,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: List.generate(
                            5,
                                (i) => Icon(
                              i < review.rating
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.amber,
                              size: 16.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Text(
                  review.comment,
                  style: TextStyle(fontSize: 13.sp, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}