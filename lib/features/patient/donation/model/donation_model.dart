class DonationModel {
  final int id;
  final int requesterId;
  final String firstName;
  final String lastName;
  final String? profileImage;
  final String? bloodType;
  final String donationType;
  final String? deviceType;
  final String location;
  final String status;
  final DateTime createdAt;

  DonationModel({
    required this.id,
    required this.requesterId,
    required this.firstName,
    required this.lastName,
    this.profileImage,
    this.bloodType,
    required this.donationType,
    this.deviceType,
    required this.location,
    required this.status,
    required this.createdAt,
  });

  factory DonationModel.fromJson(Map<String, dynamic> json) {
    return DonationModel(
      id: json['id'],
      requesterId: json['requesterId'] ?? json['requester']?['id'] ?? 0,
      firstName: json['requester']['firstName'],
      lastName: json['requester']['lastName'],
      profileImage: json['requester']['profileImage'],
      bloodType: json['bloodType'],
      donationType: json['donationType'],
      deviceType: json['deviceType'],
      location: json['location'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}