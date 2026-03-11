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
  });

  factory PatientDoctorModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'] as Map<String, dynamic>? ?? {};

    final firstName = user['firstName']?.toString() ?? "";
    final lastName = user['lastName']?.toString() ?? "";
    final imagePath = user['profileImage']?.toString();

    return PatientDoctorModel(
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
      clinicAddress: json['clinicAddress']?.toString(),
      consultationFee: json['consultationFee'] == null
          ? null
          : double.tryParse(json['consultationFee'].toString()),
      rating: json['averageRating'] == null
          ? null
          : double.tryParse(json['averageRating'].toString()),
    );
  }
}