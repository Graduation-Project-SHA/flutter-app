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
      consultationFee: _parseDoctorPrice(json),
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

  double? get effectiveConsultationFee {
    if (consultationFee != null && consultationFee! > 0) {
      return consultationFee;
    }

    for (final service in services) {
      if (service.price > 0) {
        return service.price;
      }
    }

    return null;
  }
}

double? _parseDoctorPrice(Map<String, dynamic> json) {
  final consultationFee = _parseFlexibleDouble(json['consultationFee']);
  if (consultationFee != null && consultationFee > 0) {
    return consultationFee;
  }

  final rootPrice = _parseFlexibleDouble(json['price']);
  if (rootPrice != null && rootPrice > 0) {
    return rootPrice;
  }

  final services = json['services'] as List? ?? [];
  for (final service in services) {
    if (service is Map<String, dynamic>) {
      final servicePrice = _parseFlexibleDouble(service['price']);
      if (servicePrice != null && servicePrice > 0) {
        return servicePrice;
      }
    }
  }

  return null;
}

double? _parseFlexibleDouble(dynamic value) {
  if (value == null) {
    return null;
  }

  if (value is num) {
    return value.toDouble();
  }

  final text = value.toString().trim();
  if (text.isEmpty) {
    return null;
  }

  final normalized = text.replaceAll(',', '.');
  final directParse = double.tryParse(normalized);
  if (directParse != null) {
    return directParse;
  }

  final match = RegExp(r'\d+(?:[\.,]\d+)?').firstMatch(text);
  if (match != null) {
    return double.tryParse(match.group(0)!.replaceAll(',', '.'));
  }

  return null;
}

class ServiceInDoctor {
  final int id;
  final String name;
  final double price;

  ServiceInDoctor({required this.id, required this.name, required this.price});

  factory ServiceInDoctor.fromJson(Map<String, dynamic> json) {
    return ServiceInDoctor(
      id: int.tryParse(json['id']?.toString() ?? '') ?? 0,
      name: json['name'] ?? "",
      price: _parseFlexibleDouble(json['price']) ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {"id": id, "name": name, "price": price};
}