import '../../../../../core/network/api_constants.dart';

class DoctorHomeAppointmentModel {
  final String id;
  final String patientName;
  final String? patientImage;
  final String type;
  final String date;
  final String time;
  final String status;

  DoctorHomeAppointmentModel({
    required this.id,
    required this.patientName,
    this.patientImage,
    required this.type,
    required this.date,
    required this.time,
    required this.status,
  });

  factory DoctorHomeAppointmentModel.fromJson(Map<String, dynamic> json) {
    final patient = json['patient'] as Map<String, dynamic>? ?? {};
    final user = patient['user'] as Map<String, dynamic>? ?? {};
    final firstName = user['firstName']?.toString() ?? '';
    final lastName = user['lastName']?.toString() ?? '';
    final patientName =
    "$firstName $lastName".trim().isEmpty ? 'مريض' : "$firstName $lastName".trim();

    final rawImage = user['profileImage']?.toString();
    final patientImage =
    (rawImage != null && rawImage.isNotEmpty)
        ? '${ApiConstants.baseUrl}$rawImage'
        : null;

    final scheduledAt = json['scheduledAt']?.toString() ?? '';
    String date = '';
    String time = '';
    if (scheduledAt.isNotEmpty) {
      try {
        final dt = DateTime.parse(scheduledAt).toLocal();
        final days = ['الإثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة', 'السبت', 'الأحد'];
        final months = [
          'يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو',
          'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر'
        ];
        date = '${days[dt.weekday - 1]}, ${dt.day} ${months[dt.month - 1]}, ${dt.year}';
        final hour = dt.hour.toString().padLeft(2, '0');
        final minute = dt.minute.toString().padLeft(2, '0');
        time = '$hour:$minute';
      } catch (_) {
        date = scheduledAt;
      }
    }

    return DoctorHomeAppointmentModel(
      id: json['id']?.toString() ?? '',
      patientName: patientName,
      patientImage: patientImage,
      type: json['type']?.toString() ?? 'حجز',
      date: date,
      time: time,
      status: json['status']?.toString() ?? '',
    );
  }
}
