class HistoryModel {
  String? id;
  String? type;
  String? status;
  double? amount;
  String? description;
  DateTime? createdAt;

  HistoryModel({
    this.id,
    this.type,
    this.status,
    this.amount,
    this.description,
    this.createdAt,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        id: json["id"],
        type: json["type"],
        status: json["status"],
        amount: json["amount"]?.toDouble(),
        description: json["description"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "status": status,
        "amount": amount,
        "description": description,
        "created_at": createdAt?.toIso8601String(),
      };
}