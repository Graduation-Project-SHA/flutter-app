
import 'doctor_me_model.dart';

abstract class DoctorMeState {}

class DoctorMeInitial extends DoctorMeState {}

class DoctorMeLoading extends DoctorMeState {}

class DoctorMeLoaded extends DoctorMeState {
  final DoctorMeModel doctor;

  DoctorMeLoaded(this.doctor);
}

class DoctorMeError extends DoctorMeState {
  final String error;

  DoctorMeError(this.error);
}