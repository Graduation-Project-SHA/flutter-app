class DoctorMeModel {
  final String id;
  final String userId;
  final String firstName;
  final String lastName;
  final String fullName;
  final String email;
  final String? phone;
  final String specialization;
  final String? bio;
  final String? practicalExperience;
  final String? clinicName;
  final String? clinicAddress;
  final double? latitude;
  final double? longitude;
  final String? profileImage;
  final bool? isVerified;
  final bool? isAvailable;

  DoctorMeModel({
    required this.id,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.email,
    this.phone,
    required this.specialization,
    this.bio,
    this.practicalExperience,
    this.clinicName,
    this.clinicAddress,
    this.latitude,
    this.longitude,
    this.profileImage,
    this.isVerified,
    this.isAvailable,
  });

  factory DoctorMeModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'] as Map<String, dynamic>? ?? {};

    final firstName = user['firstName']?.toString() ?? "";
    final lastName = user['lastName']?.toString() ?? "";
    final imagePath = user['profileImage']?.toString();

    return DoctorMeModel(
      id: json['id'].toString(),
      userId: json['userId'].toString(),
      firstName: firstName,
      lastName: lastName,
      fullName: "$firstName $lastName".trim(),
      email: user['email']?.toString() ?? "",
      phone: user['phone']?.toString(),
      specialization: json['specialization']?.toString() ?? "",
      bio: json['bio']?.toString(),
      practicalExperience: json['practicalExperience']?.toString(),
      clinicName: json['clinicName']?.toString(),
      clinicAddress: json['clinicAddress']?.toString(),
      latitude: json['latitude'] == null
          ? null
          : double.tryParse(json['latitude'].toString()),
      longitude: json['longitude'] == null
          ? null
          : double.tryParse(json['longitude'].toString()),
      profileImage: imagePath != null && imagePath.isNotEmpty
          ? "http://wiqaya.duckdns.org:3000$imagePath"
          : null,
      isVerified: json['isVerified'],
      isAvailable: json['isAvailable'],
    );
  }
}