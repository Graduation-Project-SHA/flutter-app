import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_project/core/network/dio.dart';
import 'package:health_care_project/features/patient/donation/donation_cubit/donation_states.dart';
import 'package:health_care_project/features/patient/donation/model/donation_model.dart';

class DonationCubit extends Cubit<DonationState> {
  DonationCubit() : super(DonationInitialState());
  List<DonationModel> donations = [];
  static DonationCubit get(context) => BlocProvider.of(context);

  TextEditingController locationControllerOfBlood = TextEditingController();
  TextEditingController locationControllerOfMachine = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  String? selectedValueOfBlood;
  String? selectedValueOfMachine;

  void getDonationData({String? search,String? type}) {
    emit(GetDonationDataLoadingState());

    DioHelper.fetchData(url: '/donations',
    query: {
      if (search != null && search.isNotEmpty)
        "search": search,
        "type" : type,
    },)
        .then((response) {
          final List data = response.data['data'];

          donations = data.map((e) => DonationModel.fromJson(e)).toList();

          emit(GetDonationDataSuccessState());
        })
        .catchError((error) {
          emit(GetDonationDataErrorState());
          log(error.toString());
        });
  }

  void requestBlood() {
  final location = locationControllerOfBlood.text.trim();
  final bloodType = selectedValueOfBlood;

  if (bloodType == null || bloodType.isEmpty) {
  emit(RequestBloodErrorState("من فضلك اختار فصيلة الدم"));
  return;
}

if (location.isEmpty) {
  emit(RequestBloodErrorState("من فضلك اكتب الموقع"));
  return;
}

  emit(RequestBloodLoadingState());

  DioHelper.postData(
    url: '/donations',
    data: {
      "donationType": "BLOOD",
      "bloodType": bloodType,
      "location": location,
    },
  ).then((response) {
    emit(RequestBloodSuccessState());
    log(response.data.toString());
    getDonationData();
  }).catchError((error) {
    emit(RequestBloodErrorState("حدث خطأ أثناء إرسال الطلب"));
    log(error.toString());
  });
}

  void requestMachine() {
  final location = locationControllerOfMachine.text.trim();
  final device = selectedValueOfMachine;
  final reason = reasonController.text.trim();

  if (device == null || device.isEmpty) {
  emit(RequestMachineErrorState("من فضلك اختار نوع الجهاز"));
  return;
}

if (location.isEmpty || reason.isEmpty) {
  emit(RequestMachineErrorState("من فضلك اكمل البيانات"));
  return;
}

  emit(RequestMachineLoadingState());

  DioHelper.postData(
    url: '/donations',
    data: {
      "donationType": "MEDICAL_DEVICE",
      "deviceType": device,
      "reason": reason,
      "location": location,
    },
  ).then((response) {
    emit(RequestMachineSuccessState());
    getDonationData();
    log(response.data.toString());
  }).catchError((error) {
    emit(RequestMachineErrorState("حدث خطأ أثناء إرسال الطلب"));
    log(error.toString());
  });
}
}
