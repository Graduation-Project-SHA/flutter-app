import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_project/core/network/dio.dart';
import 'package:health_care_project/features/doctor/main_layout/doctor_profile/doctor_services/controler/doctor_services_states.dart';
import 'package:health_care_project/features/doctor/main_layout/doctor_profile/doctor_services/model/doctor_services_model.dart';

class DoctorServicesCubit extends Cubit<DoctorServicesStates> {
  DoctorServicesCubit() : super(DoctorServicesInitialState());
  static DoctorServicesCubit get(context) => BlocProvider.of(context);
  TextEditingController serviceNameController = TextEditingController();
  TextEditingController serviceDescriptionController = TextEditingController();
  TextEditingController servicePriceController = TextEditingController();
  TextEditingController editServiceNameController = TextEditingController();
  TextEditingController editServiceDescriptionController =
      TextEditingController();
  TextEditingController editServicePriceController = TextEditingController();
  List<ServiceModel> doctorServices = [];
  int? deletingId;

  void addService() {
    emit(AddServiceLoadingState());
    if (serviceNameController.text.isEmpty) {
      emit(AddServiceErrorState("من فضلك ادخل اسم الخدمة"));
      return;
    }
    if (servicePriceController.text.isEmpty) {
      emit(AddServiceErrorState("من فضلك ادخل سعر الخدمة"));
      return;
    }
    DioHelper.postData(
          url: '/doctor/me/services',
          data: {
            'name': serviceNameController.text,
            'description': serviceDescriptionController.text,
            'price': double.parse(servicePriceController.text),
            'duration': 30,
          },
        )
        .then((response) {
          getDoctorServices();
          emit(AddServiceSuccessState());
          serviceNameController.clear();
          serviceDescriptionController.clear();
          servicePriceController.clear();
        })
        .catchError((error) {
          log(error.toString());
          emit(AddServiceErrorState('حدث خطأ أثناء إضافة الخدمة'));
        });
  }

  void getDoctorServices() {
    emit(GetDoctorServicesLoadingState());
    DioHelper.fetchData(url: '/doctor/me')
        .then((response) {
          doctorServices = (response.data['data']['services'] as List)
              .map((e) => ServiceModel.fromJson(e))
              .toList();

          emit(GetDoctorServicesSuccessState());
        })
        .catchError((error) {
          log(error.toString());
          emit(GetDoctorServicesErrorState('حدث خطأ أثناء جلب الخدمات'));
        });
  }

  void updateservice(int serviceId) {
    emit(EditServiceLoadingState());
    if (editServiceNameController.text.isEmpty) {
      emit(EditServiceErrorState("من فضلك ادخل اسم الخدمة"));
      return;
    }
    if (editServicePriceController.text.isEmpty) {
      emit(EditServiceErrorState("من فضلك ادخل سعر الخدمة"));
      return;
    }
    ServiceModel(
      id: serviceId,
      name: editServiceNameController.text,
      description: editServiceDescriptionController.text,
      price: editServicePriceController.text,
      duration: 30,
    );
    DioHelper.patchData(
          url: '/doctor/me/services/$serviceId',
          data: {
            'name': editServiceNameController.text,
            'description': editServiceDescriptionController.text,
            'price': double.parse(editServicePriceController.text),
            'duration': 30,
          },
        )
        .then((response) {
          getDoctorServices();
          emit(EditServiceSuccessState());
        })
        .catchError((error) {
          log(error.toString());
          emit(EditServiceErrorState('حدث خطأ أثناء تعديل الخدمة'));
        });
  }

  void deleteService(int serviceId) {
    deletingId = serviceId;
    emit(DeleteServiceLoadingState());
    DioHelper.deleteData(url: '/doctor/me/services/$serviceId')
        .then((response) {
          deletingId = null;
          getDoctorServices();
          emit(DeleteServiceSuccessState());
        })
        .catchError((error) {
          deletingId = null;
          log(error.toString());
          emit(DeleteServiceErrorState('حدث خطأ أثناء حذف الخدمة'));
        });
  }
}
