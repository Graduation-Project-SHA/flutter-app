class AppointmentModel {
  final int id;
  final DateTime appointmentDate;
  final String startTime;
  final String status;
  final String notes;
  final DoctorInAppointment doctor;
  final ServiceInAppointment service;

  AppointmentModel({
    required this.id,
    required this.appointmentDate,
    required this.startTime,
    required this.status,
    required this.notes,
    required this.doctor,
    required this.service,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'],
      appointmentDate: DateTime.parse(json['appointmentDate']),
      startTime: json['startTime'],
      status: json['status'],
      notes: json['notes'] ?? "",
      doctor: DoctorInAppointment.fromJson(json['doctorProfile']),
      service: ServiceInAppointment.fromJson(json['service']),
    );
  }
}
class DoctorInAppointment {
  final String firstName;
  final String lastName;
  final String? profileImage;
  final String specialization;
  final int id;

  DoctorInAppointment( {
    required this.firstName,
    required this.lastName,
    this.profileImage,
    required this.specialization,
    required this.id,

  });


  factory DoctorInAppointment.fromJson(Map<String, dynamic> json) {
    return DoctorInAppointment(
      firstName: json['user']['firstName'] ?? "",
      lastName: json['user']['lastName'] ?? "",
      profileImage: json['profileImage'],
      specialization: json['specialization'] ?? "",
      id: json['id'],
    );
  }


  String get fullName => "د. $firstName $lastName";
}

class ServiceInAppointment {
  final String name;
  final double price;

  ServiceInAppointment({required this.name, required this.price});

  factory ServiceInAppointment.fromJson(Map<String, dynamic> json) {
    return ServiceInAppointment(
      name: json['name'] ?? "",
      price: double.parse(json['price'].toString()),
    );
  }
}