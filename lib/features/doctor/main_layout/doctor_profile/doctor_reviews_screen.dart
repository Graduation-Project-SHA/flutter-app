import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'doctor_reviews_cubit/doctor_reviews_cubit.dart';
import 'doctor_reviews_cubit/doctor_reviews_state.dart';
import 'doctor_reviews_cubit/doctor_review_model.dart';

class DoctorReviewsScreen extends StatefulWidget {
  static const String routeName = "DoctorReviewsScreen";

  const DoctorReviewsScreen({super.key});

  @override
  State<DoctorReviewsScreen> createState() => _DoctorReviewsScreenState();
}

class _DoctorReviewsScreenState extends State<DoctorReviewsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      DoctorReviewsCubit.get(context).getDoctorReviews();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xff247CFF),
        title: Text(
          "تقييماتي",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: BlocBuilder<DoctorReviewsCubit, DoctorReviewsState>(
        builder: (context, state) {
          if (state is DoctorReviewsLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xff247CFF)),
            );
          }

          if (state is DoctorReviewsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 60.sp, color: Colors.grey),
                  SizedBox(height: 12.h),
                  Text(
                    state.error,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                  ),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: () =>
                        DoctorReviewsCubit.get(context).getDoctorReviews(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff247CFF),
                    ),
                    child: const Text("إعادة المحاولة",
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            );
          }

          if (state is DoctorReviewsLoaded) {
            final review = state.reviewsData;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "تقييم المريض الحالي",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff242424),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  _buildReviewCard(review),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildReviewCard(DoctorReviewModel review) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: const Color(0xffEDEDED)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundColor: const Color(0xffEEF5FF),
                backgroundImage: review.patientImage != null
                    ? NetworkImage(review.patientImage!)
                    : null,
                child: review.patientImage == null
                    ? Text(
                  review.patientName.isNotEmpty
                      ? review.patientName[0].toUpperCase()
                      : "م",
                  style: TextStyle(
                    color: const Color(0xff247CFF),
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                )
                    : null,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  review.patientName,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff242424),
                  ),
                ),
              ),
              _buildStarRow(
                review.rating.toDouble(),
                size: 14,
              ),
            ],
          ),
          if (review.comment.isNotEmpty) ...[
            SizedBox(height: 10.h),
            Text(
              review.comment,
              style: TextStyle(
                fontSize: 13.sp,
                color: const Color(0xff555555),
                height: 1.5,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStarRow(double rating, {double size = 20}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < rating.floor()) {
          return Icon(Icons.star, color: const Color(0xffFFC107), size: size.sp);
        } else if (index < rating) {
          return Icon(Icons.star_half,
              color: const Color(0xffFFC107), size: size.sp);
        } else {
          return Icon(Icons.star_border,
              color: const Color(0xffFFC107), size: size.sp);
        }
      }),
    );
  }
}