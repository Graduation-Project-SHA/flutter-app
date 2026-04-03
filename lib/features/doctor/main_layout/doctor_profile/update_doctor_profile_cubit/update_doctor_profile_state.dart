abstract class UpdateDoctorProfileState {}

class UpdateDoctorProfileInitial extends UpdateDoctorProfileState {}

class UpdateDoctorProfileLoading extends UpdateDoctorProfileState {}

class UpdateDoctorProfileSuccess extends UpdateDoctorProfileState {}

class UpdateDoctorProfileError extends UpdateDoctorProfileState {
  final String error;

  UpdateDoctorProfileError(this.error);
}