class DoctorDetailsModel {
  final String id;
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
  final double? latitude;
  final double? longitude;

  DoctorDetailsModel({
    required this.id,
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
    this.latitude,
    this.longitude,
  });

  factory DoctorDetailsModel.fromJson(Map<String, dynamic> json) {
    final firstName = json['firstName']?.toString() ?? "";
    final lastName = json['lastName']?.toString() ?? "";

    return DoctorDetailsModel(
      id: json['id'].toString(),
      firstName: firstName,
      lastName: lastName,
      fullName: "د. $firstName $lastName".trim(),
      specialization: json['specialization']?.toString() ?? "",
      profileImage: json['profileImage']?.toString(),
      bio: json['bio']?.toString(),
      city: json['city']?.toString(),
      clinicAddress: json['clinicAddress']?.toString(),
      consultationFee: json['consultationFee'] == null
          ? null
          : double.tryParse(json['consultationFee'].toString()),
      rating: json['rating'] == null
          ? null
          : double.tryParse(json['rating'].toString()),
      latitude: json['latitude'] == null
          ? null
          : double.tryParse(json['latitude'].toString()),
      longitude: json['longitude'] == null
          ? null
          : double.tryParse(json['longitude'].toString()),
    );
  }
}