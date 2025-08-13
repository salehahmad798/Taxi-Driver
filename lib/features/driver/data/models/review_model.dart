class ReviewModel {
  String? id;
  String? customerName;
  String? customerImage;
  int? rating;
  String? comment;
  DateTime? createdAt;

  ReviewModel({
    this.id,
    this.customerName,
    this.customerImage,
    this.rating,
    this.comment,
    this.createdAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
        id: json["id"],
        customerName: json["customer_name"],
        customerImage: json["customer_image"],
        rating: json["rating"],
        comment: json["comment"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_name": customerName,
        "customer_image": customerImage,
        "rating": rating,
        "comment": comment,
        "created_at": createdAt?.toIso8601String(),
      };
}