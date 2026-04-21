import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care_project/features/doctor/main_layout/doctor_profile/doctor_services/controler/doctor_services_cubit.dart';
import 'package:health_care_project/features/doctor/main_layout/doctor_profile/doctor_services/controler/doctor_services_states.dart';
import 'package:health_care_project/features/doctor/main_layout/doctor_profile/doctor_services/widgets/add_service.dart';
import 'package:health_care_project/features/doctor/main_layout/doctor_profile/doctor_services/widgets/show_service.dart';
import 'package:health_care_project/features/patient/donation/views/widgets/custom_appbar.dart';

class DoctorServices extends StatelessWidget {
  const DoctorServices({super.key});
  static const String routeName = '/doctor_services';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorServicesCubit, DoctorServicesStates>(
      listener: (context, state) {
        if (state is DeleteServiceSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('تم حذف الخدمة بنجاح', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),),
              backgroundColor: Colors.green,
            ),
          );
        }
        else if (state is DeleteServiceErrorState) {
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
      return Scaffold(
        appBar: CustomAppbar(title: 'خدماتي',horizontalPadding: 8.w,),
        body:state is GetDoctorServicesLoadingState
            ? Center(child: CircularProgressIndicator(color: Color(0xff2B73F3)))
            : SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 22.w),
            child: Column(
              children: [
                SizedBox(height: 25.h),
                AddService(),
                SizedBox(height: 25.h),
                cubit.doctorServices.isEmpty
                    ? Text('لا توجد خدمات مضافة حتى الآن', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),)
                    :
                ListView.separated(
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ShowService(index: index,);
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 20.h);
                  },
                  itemCount: cubit.doctorServices.length,
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
