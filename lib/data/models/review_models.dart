enum ReviewStatus {
  pending,
  underReview,
  approved,
  rejected,
}

enum ReviewItemType {
  document,
  vehiclePhoto,
}

class ReviewItem {
  final String id;
  final String title;
  final ReviewItemType type;
  ReviewStatus status;
  final String? uploadDate;
  final String? reviewDate;
  String? reviewNotes;
  final String? filePath;
  final String? serverUrl;
  final bool isRequired;

  ReviewItem({
    required this.id,
    required this.title,
    required this.type,
    required this.status,
    this.uploadDate,
    this.reviewDate,
    this.reviewNotes,
    this.filePath,
    this.serverUrl,
    this.isRequired = false,
  });
}
