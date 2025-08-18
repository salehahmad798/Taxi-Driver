import 'package:get/get.dart';

class ApiProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'https://your-api-base-url.com/api/';
    httpClient.addRequestModifier<dynamic>((request) {
      request.headers['Authorization'] = 'Bearer ${getToken()}';
      request.headers['Accept'] = 'application/json';
      return request;
    });
    super.onInit();
  }

  String getToken() {
    // TODO: inject StorageService or read from Get.find<StorageService>()
    return '';
  }

  // Vehicles
  Future<Response> registerVehicle(Map<String, dynamic> json) => post('vehicles/register', json);
  Future<Response> getVehicleDetails(String id) => get('vehicles/$id');

  // Vehicle Photos
  Future<Response> uploadVehiclePhoto(String filePath, String photoType, String vehicleId) async {
    final form = FormData({
      'file': MultipartFile(filePath, filename: 'vehicle_photo.jpg'),
      'photo_type': photoType,
      'vehicle_id': vehicleId,
    });
    return post('vehicles/photos/upload', form);
  }

  Future<Response> getVehiclePhotos(String vehicleId) => get('vehicles/$vehicleId/photos');
  Future<Response> deleteVehiclePhoto(String photoId) => delete('vehicles/photos/$photoId');
  Future<Response> updateVehiclePhoto(String photoId, String filePath) {
    final form = FormData({'file': MultipartFile(filePath, filename: 'updated_photo.jpg')});
    return put('vehicles/photos/$photoId', form);
  }

  // Documents
  Future<Response> uploadDocument(String filePath, String documentType) {
    final form = FormData({
      'file': MultipartFile(filePath, filename: 'document.jpg'),
      'type': documentType,
    });
    return post('documents/upload', form);
  }

  Future<Response> getDocuments() => get('documents');
  Future<Response> getDocumentStatus(String id) => get('documents/$id/status');

  // Availability
  Future<Response> updateAvailability(Map<String, dynamic> json) => post('driver/availability', json);
  Future<Response> getDriverStatus() => get('driver/status');
  Future<Response> setBreakMode(Map<String, dynamic> json) => post('driver/break', json);
}

// Extensions for document review flow
extension DocumentReviewApi on ApiProvider {
  Future<Response> resubmitDocument(String documentId) =>
      post('documents/$documentId/resubmit', {'timestamp': DateTime.now().toIso8601String()});

  Future<Response> getReviewSummary() => get('review/summary');

  Future<Response> updateReviewStatus(String documentId, String status, {String? notes}) =>
      put('documents/$documentId/review', {
        'status': status,
        'notes': notes,
        'review_date': DateTime.now().toIso8601String(),
      });

  Future<Response> getReviewHistory(String documentId) => get('documents/$documentId/history');

  Future<Response> submitForApproval() =>
      post('review/submit-approval', {'submission_date': DateTime.now().toIso8601String()});
}
