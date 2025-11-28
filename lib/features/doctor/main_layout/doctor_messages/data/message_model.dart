class MessageModel {
  final int id;
  final String senderName;
  final String senderImage;
  final String lastMessage;
  final String time;
  final int unreadCount;

  MessageModel({
    required this.id,
    required this.senderName,
    required this.senderImage,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json["id"],
      senderName: json["senderName"],
      senderImage: json["senderImage"],
      lastMessage: json["lastMessage"],
      time: json["time"],
      unreadCount: json["unreadCount"],
    );
  }
}
