import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care_project/features/doctor/main_layout/doctor_profile/doctor_services/controler/doctor_services_cubit.dart';
import 'package:health_care_project/features/doctor/main_layout/doctor_profile/doctor_services/controler/doctor_services_states.dart';
import 'package:health_care_project/shared/component/defaultTextFormField/defaultTextFormField.dart';
import 'package:health_care_project/shared/component/defaultbutton/defaultbutton.dart';

class AddService extends StatelessWidget {
  const AddService({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorServicesCubit, DoctorServicesStates>(
       listener: (context, state) {
        if (state is AddServiceSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('تمت اضافة الخدمة بنجاح', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),),
              backgroundColor: Colors.green,
            ),
          );
        }
        else if (state is AddServiceErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),),
              backgroundColor: Colors.red,
            ),
          );
        }
       },

      builder: (context, state) {
        DoctorServicesCubit cubit = DoctorServicesCubit.get(context);
        return Container(
          height: 460.h,
        
          decoration: BoxDecoration(
            border: Border.all(width: 1.5.w, color: Color(0xffDCDCDC)),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 60.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xffC6DCFF),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14.r),
                    topRight: Radius.circular(14.r),
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(14.r),
                          topRight: Radius.circular(14.r),
                        ),
                        child: Image.asset(
                          'assets/images/add_services_design.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
        
                    Positioned(
                      right: 20.w,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: Text(
                          'اضافة خدمة',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.h),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                  'اسم الخدمة',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff6C7278),
                  ),
                ),
                SizedBox(height: 6.h),
                Defaulttextformfield(borderRadius: 16.r, controller: cubit.serviceNameController,
                ),
                SizedBox(height: 15.h),
                Text(
                  'تفاصيل الخدمة ( اختياري )',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff6C7278),
                  ),
                ),
                SizedBox(height: 6.h),
                Defaulttextformfield(borderRadius: 16.r,controller: cubit.serviceDescriptionController),
                SizedBox(height: 15.h),
                Text(
                  'سعر الخدمة',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff6C7278),
                  ),
                ),
                SizedBox(height: 6.h),
                Defaulttextformfield(borderRadius: 16.r, controller: cubit.servicePriceController,
                keyboardType: TextInputType.number,
                ),
                SizedBox(height: 15.h),
                DefaultButton(onPressed: (){
                  cubit.addService();
                }
                
                ,elevation: 0, borderRadius: 16.r,
                
                child:
                state is AddServiceLoadingState ? SizedBox(
                  height: 20.h,
                  width: 20.w,
                  child: const CircularProgressIndicator(color: Colors.white,)) :
                
                 Text('اضافة الخدمة', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.white),),)
                ],),
              )
        
            
            ],
          ),
        );
      },
    );
  }
}
