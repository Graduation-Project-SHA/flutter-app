import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:health_care_project/features/doctor/main_layout/doctor_profile/doctor_services/controler/doctor_services_cubit.dart';
import 'package:health_care_project/features/doctor/main_layout/doctor_profile/doctor_services/controler/doctor_services_states.dart';
import 'package:health_care_project/features/doctor/main_layout/doctor_profile/doctor_services/widgets/edit_services.dart';

class ShowService extends StatelessWidget {
  const ShowService({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorServicesCubit, DoctorServicesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        DoctorServicesCubit cubit = DoctorServicesCubit.get(context);
        List list = cubit.doctorServices;
        return 
             Material(
                elevation: 6,
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.5, color: Color(0xffDCDCDC)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: 20.w,
                      vertical: 15.h,
                    ),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 26.r,
                                  backgroundColor: Color(0xffDBEAFE),
                                  child: Image.asset(
                                    'assets/images/teeth.png',
                                    height: 30.h,
                                    width: 30.w,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  height: 45.h,
                                  width: 148.w,
                                  decoration: BoxDecoration(
                                    color: Color(0xff2B73F3),
                                    borderRadius: BorderRadius.circular(30.r),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'السعر :${list[index].price} ج.م',
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Material(
                                  color: Colors.transparent,
                                  child: Ink(
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 241, 238, 238),
                                      shape: BoxShape.circle,
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        cubit.deleteService(list[index].id);
                                      },
                                      customBorder: const CircleBorder(),
                                      splashColor: const Color.fromARGB(
                                        255,
                                        49,
                                        66,
                                        94,
                                      ).withOpacity(0.3),
                                      child: Padding(
                                        padding: EdgeInsets.all(8.r),
                                        child: 
                                        state is DeleteServiceLoadingState && cubit.deletingId == list[index].id
                                            ? SizedBox(
                                                height: 20.h,
                                                width: 20.w,
                                                child: CircularProgressIndicator(
                                                  color: Color(0xff2B73F3),
                                                  strokeWidth: 2,
                                                  
                                                ),
                                              )
                                            :
                                         SvgPicture.asset(
                                          'assets/images/svgs/delete_icon.svg',
                                          height: 20.h,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              list[index].name,
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff1E2939),
                                fontFamily: 'Roboto',
                              ),
                            ),
                            SizedBox(height: 10.h),
                            SizedBox(
                              width: 190.w,
                              child: Text(
                                list[index].description,
                                style: TextStyle(
                                  color: Color(0xff99A1AF),
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                            ),
                          ],
                        ),

                        Positioned(
                          left: 0,
                          bottom: 0,
                          child: Material(
                            color: Colors.transparent,
                            child: Ink(
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 241, 238, 238),
                                shape: BoxShape.circle,
                              ),
                              child: InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return EditServices(index: index,);
                                    },
                                  );
                                },
                                customBorder: const CircleBorder(),
                                splashColor: const Color.fromARGB(
                                  255,
                                  49,
                                  66,
                                  94,
                                ).withOpacity(0.3),
                                child: Padding(
                                  padding: EdgeInsets.all(8.r),
                                  child: SvgPicture.asset(
                                    'assets/images/svgs/edit_icon.svg',
                                    height: 20.h,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}
