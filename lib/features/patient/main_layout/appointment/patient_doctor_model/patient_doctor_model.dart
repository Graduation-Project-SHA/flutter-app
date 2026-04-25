import '../../../../../core/network/api_constants.dart';

class PatientDoctorModel {
  final String id;
  final String userId;
  final String firstName;
  final String lastName;
  final String fullName;
  final String specialization;
  final String? profileImage;
  final String? bio;
  final String? city;
  final String? clinicAddress;
  final double? consultationFee;
  final double? rating;
  final List<ServiceInDoctor>? services;

  PatientDoctorModel({
    required this.id,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.specialization,
    this.profileImage,
    this.bio,
    this.city,
    this.clinicAddress,
    this.consultationFee,
    this.rating,
    this.services,
  });

  factory PatientDoctorModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'] as Map<String, dynamic>? ?? {};

    final firstName = user['firstName']?.toString() ?? "";
    final lastName = user['lastName']?.toString() ?? "";
    final imagePath = user['profileImage']?.toString();

    var servicesList = json['services'] as List? ?? [];
    List<ServiceInDoctor> parsedServices =
    servicesList.map((s) => ServiceInDoctor.fromJson(s)).toList();

    return PatientDoctorModel(
      id: json['id'].toString(),
      userId: json['userId'].toString(),
      firstName: firstName,
      lastName: lastName,
      fullName: "د. $firstName $lastName".trim(),
      specialization: json['specialization']?.toString() ?? "",
      profileImage: imagePath != null && imagePath.isNotEmpty
          ? "${ApiConstants.baseUrl}$imagePath"
          : null,
      bio: json['bio']?.toString(),
      city: json['city']?.toString(),
      clinicAddress: json['clinicAddress']?.toString(),
      consultationFee: json['consultationFee'] == null
          ? null
          : double.tryParse(json['consultationFee'].toString()),
      rating: json['averageRating'] == null
          ? null
          : double.tryParse(json['averageRating'].toString()),
      services: parsedServices,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userId": userId,
      "firstName": firstName,
      "lastName": lastName,
      "fullName": fullName,
      "specialization": specialization,
      "profileImage": profileImage,
      "bio": bio,
      "city": city,
      "clinicAddress": clinicAddress,
      "consultationFee": consultationFee,
      "averageRating": rating,
      "services": services?.map((s) => s.toJson()).toList(),
    };
  }
}

class ServiceInDoctor {
  final int id;
  final String name;
  final double price;

  ServiceInDoctor({required this.id, required this.name, required this.price});

  factory ServiceInDoctor.fromJson(Map<String, dynamic> json) {
    return ServiceInDoctor(
      id: json['id'],
      name: json['name'] ?? "",
      price: double.parse(json['price'].toString()),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
  };
}