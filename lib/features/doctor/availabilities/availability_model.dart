class AvailabilityModel {
  final String id;
  final String day;
  final String startTime;
  final String endTime;

  AvailabilityModel({
    required this.id,
    required this.day,
    required this.startTime,
    required this.endTime,
  });

  factory AvailabilityModel.fromJson(Map<String, dynamic> json) {
    return AvailabilityModel(
      id: json['id'].toString(),
      day: json['day'].toString(),
      startTime: json['startTime'].toString(),
      endTime: json['endTime'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "day": day,
      "startTime": startTime,
      "endTime": endTime,
    };
  }
}