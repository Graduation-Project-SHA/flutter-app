import '../doctor_details_model/doctor_details_model.dart';

abstract class DoctorDetailsState {}

class DoctorDetailsInitial extends DoctorDetailsState {}

class DoctorDetailsLoading extends DoctorDetailsState {}

class DoctorDetailsLoaded extends DoctorDetailsState {
  final DoctorDetailsModel doctor;

  DoctorDetailsLoaded(this.doctor);
}

class DoctorDetailsError extends DoctorDetailsState {
  final String error;

  DoctorDetailsError(this.error);
}