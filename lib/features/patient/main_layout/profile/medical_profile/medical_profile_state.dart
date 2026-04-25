abstract class MedicalProfileState {}

class MedicalProfileInitial extends MedicalProfileState {}
class MedicalProfileLoading extends MedicalProfileState {}
class MedicalProfileSuccess extends MedicalProfileState {}
class MedicalProfileError extends MedicalProfileState {
  final String error;
  MedicalProfileError(this.error);
}

class MedicalProfileLoaded extends MedicalProfileState {
  final Map<String, dynamic> profile;
  final Map<String, dynamic> medical;
  MedicalProfileLoaded({required this.profile, required this.medical});
}