import 'doctor_review_model.dart';

abstract class DoctorReviewsState {}

class DoctorReviewsInitial extends DoctorReviewsState {}

class DoctorReviewsLoading extends DoctorReviewsState {}

class DoctorReviewsLoaded extends DoctorReviewsState {
  final DoctorReviewModel reviewsData;

  DoctorReviewsLoaded(this.reviewsData);
}

class DoctorReviewsError extends DoctorReviewsState {
  final String error;

  DoctorReviewsError(this.error);
}
