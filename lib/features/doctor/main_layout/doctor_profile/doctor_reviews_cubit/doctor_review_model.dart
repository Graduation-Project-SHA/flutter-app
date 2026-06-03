import '../../../../../core/network/api_constants.dart';

class DoctorReviewModel {
  final int id;
  final int rating;
  final String comment;
  final String patientName;
  final String? patientImage;

  DoctorReviewModel({
    required this.id,
    required this.rating,
    required this.comment,
    required this.patientName,
    this.patientImage,
  });

  factory DoctorReviewModel.fromJson(Map<String, dynamic> json) {
    final patient = json['patient'] as Map<String, dynamic>? ?? {};
    final firstName = patient['firstName']?.toString() ?? '';
    final lastName = patient['lastName']?.toString() ?? '';
    final name = '$firstName $lastName'.trim().isEmpty
        ? 'مريض'
        : '$firstName $lastName'.trim();

    final rawImage = patient['profileImage']?.toString();
    final image = (rawImage != null && rawImage.isNotEmpty)
        ? '${ApiConstants.baseUrl}$rawImage'
        : null;

    return DoctorReviewModel(
      id: json['id'] ?? 0,
      rating: json['rating'] ?? 0,
      comment: json['comment']?.toString() ?? '',
      patientName: name,
      patientImage: image,
    );
  }
}