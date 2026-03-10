
import '../patient_doctor_model/patient_doctor_model.dart';

abstract class PatientDoctorsState {}

class PatientDoctorsInitial extends PatientDoctorsState {}

class PatientDoctorsLoading extends PatientDoctorsState {}

class PatientDoctorsLoaded extends PatientDoctorsState {
  final List<PatientDoctorModel> doctors;

  PatientDoctorsLoaded(this.doctors);
}

class PatientDoctorsError extends PatientDoctorsState {
  final String error;

  PatientDoctorsError(this.error);
}