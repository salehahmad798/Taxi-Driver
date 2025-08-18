class HomeDocumentModel {
  final String id;
  final String name;
  final String type;
  final String status; // pending, under_review, verified, rejected
  final DateTime uploadedAt;
  final String? fileUrl;
  final String? rejectionReason;

  HomeDocumentModel({
    required this.id,
    required this.name,
    required this.type,
    required this.status,
    required this.uploadedAt,
    this.fileUrl,
    this.rejectionReason,
  });

  factory HomeDocumentModel.fromJson(Map<String, dynamic> json) {
    return HomeDocumentModel(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      status: json['status'],
      uploadedAt: DateTime.parse(json['uploaded_at']),
      fileUrl: json['file_url'],
      rejectionReason: json['rejection_reason'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'status': status,
      'uploaded_at': uploadedAt.toIso8601String(),
      'file_url': fileUrl,
      'rejection_reason': rejectionReason,
    };
  }

  // Helper methods
  bool get isVerified => status == 'verified';
  bool get isPending => status == 'pending';
  bool get isUnderReview => status == 'under_review';
  bool get isRejected => status == 'rejected';
}
