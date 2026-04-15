class DonationModel {
  final String firstName;
  final String lastName;
  final String? bloodType;
  final String donationType;
  final String? deviceType;

  DonationModel({
    required this.firstName,
    required this.lastName,
    required this.bloodType,
    required this.donationType,
    required this.deviceType,
  });

  factory DonationModel.fromJson(Map<String, dynamic> json) {
    return DonationModel(
      firstName: json['requester']['firstName'],
      lastName: json['requester']['lastName'],
      bloodType: json['bloodType'],
      donationType: json['donationType'],
      deviceType: json['deviceType'],
    );
  }
}