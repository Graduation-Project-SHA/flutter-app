abstract class DonationState {}
class DonationInitialState extends DonationState {}
class GetDonationDataLoadingState extends DonationState {}
class GetDonationDataSuccessState extends DonationState {}
class GetDonationDataErrorState extends DonationState {
  
}
class RequestBloodLoadingState extends DonationState {}
class RequestBloodSuccessState extends DonationState {}
class RequestBloodErrorState extends DonationState {
  final String message;

  RequestBloodErrorState(this.message);
}

class RequestMachineLoadingState extends DonationState {}
class RequestMachineSuccessState extends DonationState {}
class RequestMachineErrorState extends DonationState {
  final String message;

  RequestMachineErrorState(this.message);
}