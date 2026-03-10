class PatientDoctorModel {
  final String id;
  final String firstName;
  final String lastName;
  final String fullName;
  final String specialization;
  final String? profileImage;
  final String? bio;
  final String? city;
  final double? consultationFee;
  final double? rating;

  PatientDoctorModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.specialization,
    this.profileImage,
    this.bio,
    this.city,
    this.consultationFee,
    this.rating,
  });

  factory PatientDoctorModel.fromJson(Map<String, dynamic> json) {
    final firstName = json['firstName']?.toString() ?? "";
    final lastName = json['lastName']?.toString() ?? "";

    return PatientDoctorModel(
      id: json['id'].toString(),
      firstName: firstName,
      lastName: lastName,
      fullName: "د. $firstName $lastName".trim(),
      specialization: json['specialization']?.toString() ?? "",
      profileImage: json['profileImage']?.toString(),
      bio: json['bio']?.toString(),
      city: json['city']?.toString(),
      consultationFee: json['consultationFee'] == null
          ? null
          : double.tryParse(json['consultationFee'].toString()),
      rating: json['rating'] == null
          ? null
          : double.tryParse(json['rating'].toString()),
    );
  }
}