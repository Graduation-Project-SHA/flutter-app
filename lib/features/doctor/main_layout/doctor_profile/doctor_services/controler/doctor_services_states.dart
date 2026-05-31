abstract class DoctorServicesStates {}

class DoctorServicesInitialState extends DoctorServicesStates {}

class AddServiceLoadingState extends DoctorServicesStates {}

class AddServiceSuccessState extends DoctorServicesStates {}

class AddServiceErrorState extends DoctorServicesStates {
  final String error;
  AddServiceErrorState(this.error);
}

class EditServiceLoadingState extends DoctorServicesStates {}

class EditServiceSuccessState extends DoctorServicesStates {}

class EditServiceErrorState extends DoctorServicesStates {
  final String error;
  EditServiceErrorState(this.error);
}

class DeleteServiceLoadingState extends DoctorServicesStates {}

class DeleteServiceSuccessState extends DoctorServicesStates {}

class DeleteServiceErrorState extends DoctorServicesStates {
  final String error;
  DeleteServiceErrorState(this.error);
}

class GetDoctorServicesLoadingState extends DoctorServicesStates {}

class GetDoctorServicesSuccessState extends DoctorServicesStates {}
class GetDoctorServicesErrorState extends DoctorServicesStates {
  final String error;
  GetDoctorServicesErrorState(this.error);
}
