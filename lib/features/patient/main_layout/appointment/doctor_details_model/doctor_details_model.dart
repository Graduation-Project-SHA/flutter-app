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
  final String? clinicName;
  final String? clinicAddress;
  final double? consultationFee;
  final double? rating;
  final double? latitude;
  final double? longitude;

  DoctorDetailsModel({
    required this.id,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.specialization,
    this.profileImage,
    this.bio,
    this.city,
    this.clinicName,
    this.clinicAddress,
    this.consultationFee,
    this.rating,
    this.latitude,
    this.longitude,
  });

  factory DoctorDetailsModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'] as Map<String, dynamic>? ?? {};

    final firstName = user['firstName']?.toString() ?? "";
    final lastName = user['lastName']?.toString() ?? "";
    final imagePath = user['profileImage']?.toString();

    return DoctorDetailsModel(
      id: json['id'].toString(),
      userId: json['userId'].toString(),
      firstName: firstName,
      lastName: lastName,
      fullName: "د. $firstName $lastName".trim(),
      specialization: json['specialization']?.toString() ?? "",
      profileImage: imagePath != null && imagePath.isNotEmpty
          ? "http://wiqaya.duckdns.org:3000$imagePath"
          : null,
      bio: json['bio']?.toString(),
      city: json['city']?.toString(),
      clinicName: json['clinicName']?.toString(),
      clinicAddress: json['clinicAddress']?.toString(),
      consultationFee: json['consultationFee'] == null
          ? null
          : double.tryParse(json['consultationFee'].toString()),
      rating: json['averageRating'] == null
          ? null
          : double.tryParse(json['averageRating'].toString()),
      latitude: json['latitude'] == null
          ? null
          : double.tryParse(json['latitude'].toString()),
      longitude: json['longitude'] == null
          ? null
          : double.tryParse(json['longitude'].toString()),
    );
  }
}