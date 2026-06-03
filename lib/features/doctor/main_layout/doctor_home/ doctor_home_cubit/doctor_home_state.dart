import '../../doctor_profile/doctor_reviews_cubit/doctor_review_model.dart';
import 'doctor_home_appointment_model.dart';

abstract class DoctorHomeState {}

class DoctorHomeInitial extends DoctorHomeState {}

class DoctorHomeLoading extends DoctorHomeState {}

class DoctorHomeLoaded extends DoctorHomeState {
  final List<DoctorHomeAppointmentModel> upcomingAppointments;
  final List<DoctorReviewModel> reviews;
  final double averageRating;
  final String aiSummary;

  DoctorHomeLoaded({
    required this.upcomingAppointments,
    required this.reviews,
    required this.averageRating,
    required this.aiSummary,
  });
}

class DoctorHomeError extends DoctorHomeState {
  final String message;
  DoctorHomeError(this.message);
}