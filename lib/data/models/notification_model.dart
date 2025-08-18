class NotificationModel {
  String? id;
  String? title;
  String? message;
  String? type;
  bool? isRead;
  DateTime? createdAt;

  NotificationModel({
    this.id,
    this.title,
    this.message,
    this.type,
    this.isRead,
    this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json["id"],
        title: json["title"],
        message: json["message"],
        type: json["type"],
        isRead: json["is_read"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "message": message,
        "type": type,
        "is_read": isRead,
        "created_at": createdAt?.toIso8601String(),
      };
}
