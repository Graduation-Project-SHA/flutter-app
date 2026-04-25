import '../patient_appointment_model/patient_appointment_model.dart';

abstract class AppointmentState {}
class AppointmentInitial extends AppointmentState {}
class AppointmentLoading extends AppointmentState {}
class AppointmentLoaded extends AppointmentState {
  final List<AppointmentModel> upcoming;
  final List<AppointmentModel> past;
  AppointmentLoaded(this.upcoming, this.past);
}
class AppointmentError extends AppointmentState {
  final String message;
  AppointmentError(this.message);
}

class BookAppointmentSuccess extends AppointmentState {}
class CancelAppointmentSuccess extends AppointmentState {}
class AppointmentSlotsLoaded extends AppointmentState { final List<String> slots; AppointmentSlotsLoaded(this.slots); }
