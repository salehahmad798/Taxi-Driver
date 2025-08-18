class DocumentModel {
  String? id;
  String? type;
  String? status;
  String? filePath;
  String? uploadDate;
  String? reviewDate;
  String? reviewNotes;
  bool isRequired;

  DocumentModel({
    this.id,
    this.type,
    this.status = 'pending',
    this.filePath,
    this.uploadDate,
    this.reviewDate,
    this.reviewNotes,
    this.isRequired = false,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'status': status,
    'file_path': filePath,
    'upload_date': uploadDate,
    'review_date': reviewDate,
    'review_notes': reviewNotes,
    'is_required': isRequired,
  };

  factory DocumentModel.fromJson(Map<String, dynamic> json) => DocumentModel(
    id: json['id'],
    type: json['type'],
    status: json['status'],
    filePath: json['file_path'],
    uploadDate: json['upload_date'],
    reviewDate: json['review_date'],
    reviewNotes: json['review_notes'],
    isRequired: json['is_required'] ?? false,
  );
}
