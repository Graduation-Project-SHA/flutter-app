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
    final doctorJson = json['doctorProfile'];
    final serviceJson = json['service'];

    return AppointmentModel(
      id: json['id'] ?? 0,
      appointmentDate: DateTime.tryParse(json['appointmentDate']?.toString() ?? '') ?? DateTime.now(),
      startTime: json['startTime']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      notes: json['notes']?.toString() ?? "",
      doctor: doctorJson is Map<String, dynamic>
          ? DoctorInAppointment.fromJson(doctorJson)
          : DoctorInAppointment(
              firstName: '',
              lastName: '',
              profileImage: null,
              specialization: '',
              id: 0,
            ),
      service: serviceJson is Map<String, dynamic>
          ? ServiceInAppointment.fromJson(serviceJson)
          : ServiceInAppointment(name: '', price: 0),
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
    final userJson = json['user'];

    return DoctorInAppointment(
      firstName: userJson is Map<String, dynamic> ? (userJson['firstName']?.toString() ?? '') : '',
      lastName: userJson is Map<String, dynamic> ? (userJson['lastName']?.toString() ?? '') : '',
      profileImage: json['profileImage']?.toString(),
      specialization: json['specialization']?.toString() ?? "",
      id: json['id'] ?? 0,
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
      name: json['name']?.toString() ?? "",
      price: double.parse(json['price'].toString()),
    );
  }
}