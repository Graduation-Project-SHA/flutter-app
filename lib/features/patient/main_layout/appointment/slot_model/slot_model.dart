class SlotModel {
  final String time;
  final bool isAvailable;

  SlotModel({required this.time, required this.isAvailable});

  factory SlotModel.fromJson(Map<String, dynamic> json) {
    return SlotModel(
      time: json['time'] ?? "",
      isAvailable: json['isAvailable'] ?? true,
    );
  }
}