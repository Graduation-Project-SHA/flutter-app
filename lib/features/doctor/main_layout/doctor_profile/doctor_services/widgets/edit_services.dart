import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care_project/features/doctor/main_layout/doctor_profile/doctor_services/controler/doctor_services_cubit.dart';
import 'package:health_care_project/features/doctor/main_layout/doctor_profile/doctor_services/controler/doctor_services_states.dart';
import 'package:health_care_project/shared/component/defaultTextFormField/defaultTextFormField.dart';
import 'package:health_care_project/shared/component/defaultbutton/defaultbutton.dart';

class EditServices extends StatelessWidget {
  const EditServices({super.key , required this.index});
   final int index;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorServicesCubit, DoctorServicesStates>(
      listener: (context, state) {
        if (state is EditServiceSuccessState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        

        DoctorServicesCubit cubit = DoctorServicesCubit.get(context);
        cubit.editServiceNameController.text = cubit.doctorServices[index].name;
        cubit.editServiceDescriptionController.text = cubit.doctorServices[index].description;
        cubit.editServicePriceController.text = cubit.doctorServices[index].price.toString();
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'تعديل الخدمة',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 10.h),  Text( 'سعر الخدمة', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),),
              SizedBox(height: 10.h),
              Defaulttextformfield(
                controller: cubit.editServiceNameController,
                borderRadius: 16,
              ),
              SizedBox(height: 15.h),

            Text('تفاصيل الخدمة ( اختياري )', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),),
            SizedBox(height: 10.h),
              Defaulttextformfield(
                controller: cubit.editServiceDescriptionController,
                borderRadius: 16,
              ),

              SizedBox(height: 15.h),

              Text( 'سعر الخدمة', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),),
              SizedBox(height: 10.h),
              Defaulttextformfield(
                keyboardType: TextInputType.number,
                controller: cubit.editServicePriceController,
                borderRadius: 16,
              ),

              SizedBox(height: 20.h),

              /// button
              DefaultButton(
                onPressed: () {
                  cubit.updateservice(cubit.doctorServices[index].id);
                  Navigator.pop(context);
                },
                child: Text('حفظ التعديل'),
              ),

              SizedBox(height: 20.h),
            ],
          ),
        );
      },
    );
  }
}
