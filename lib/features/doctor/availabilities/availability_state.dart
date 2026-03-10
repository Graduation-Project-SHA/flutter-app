import 'availability_model.dart';

abstract class AvailabilityState {}

class AvailabilityInitial extends AvailabilityState {}

class AvailabilityLoading extends AvailabilityState {}

class AvailabilityError extends AvailabilityState {
  final String error;

  AvailabilityError(this.error);
}

class AvailabilityLoaded extends AvailabilityState {
  final List<AvailabilityModel> availabilities;

  AvailabilityLoaded(this.availabilities);
}