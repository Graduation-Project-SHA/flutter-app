class DoctorDetailsModel {
  final String id;
  final String userId;
  final String firstName;
  final String lastName;
  final String fullName;
  final String specialization;
  final String? profileImage;
  final String? bio;
  final String? city;
  final double? consultationFee;
  final List<ServiceInDoctor> services;

  DoctorDetailsModel({
    required this.id,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.specialization,
    required this.services,
    this.consultationFee,
    this.profileImage,
    this.bio,
    this.city,
  });

  factory DoctorDetailsModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'] as Map<String, dynamic>? ?? {};
    final firstName = user['firstName']?.toString() ?? "";
    final lastName = user['lastName']?.toString() ?? "";

    var servicesList = json['services'] as List? ?? [];
    List<ServiceInDoctor> parsedServices =
    servicesList.map((s) => ServiceInDoctor.fromJson(s)).toList();

    return DoctorDetailsModel(
      id: json['id'].toString(),
      userId: json['userId'].toString(),
      firstName: firstName,
      lastName: lastName,
      fullName: "د. $firstName $lastName".trim(),
      specialization: json['specialization']?.toString() ?? "",
      services: parsedServices,
      consultationFee: json['consultationFee'] == null
          ? null
          : double.tryParse(json['consultationFee'].toString()),
      profileImage: user['profileImage'],
      bio: json['bio']?.toString(),
      city: json['city']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userId": userId,
      "fullName": fullName,
      "specialization": specialization,
      "consultationFee": consultationFee,
      "services": services.map((s) => s.toJson()).toList(),
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

  Map<String, dynamic> toJson() => {"id": id, "name": name, "price": price};
}