class Conversation {
  final String id;
  final String name;
  final String lastMessage;
  final String targetUserId;
  final DateTime? lastMessageAt;
  final String? image;

  Conversation({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.targetUserId,
    required this.lastMessageAt,
    this.image,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    final baseUrl = "http://api.wiqaya.duckdns.org";
    String? rawImage = json['otherUser']?['profileImage'];

    return Conversation(
      id: json['id'] ?? '',
      name: json['otherUser']?['firstName'] ?? "User",
      lastMessage: json['lastMessage'] ?? "",
      targetUserId: (json['otherUser']?['id'] ?? 0).toString(),
      lastMessageAt: json['lastMessageAt'] != null
          ? DateTime.parse(json['lastMessageAt'])
          : null,
      image: (rawImage != null && !rawImage.startsWith('http'))
          ? "$baseUrl$rawImage"
          : rawImage,
    );
  }
}