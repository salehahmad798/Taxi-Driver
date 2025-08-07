import 'package:get/get.dart';
import 'package:taxi_driver/features/driver/data/models/vehicle_model.dart';

class ApiProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'https://your-api-base-url.com/api/';
    httpClient.addRequestModifier<void>((request) {
      request.headers['Authorization'] = 'Bearer ${getToken()}';
      return request;
    });
  }

  String getToken() {
    // Get token from storage
    return '';
  }

  // Vehicle Registration APIs
  Future<Response> registerVehicle(VehicleModel vehicle) async {
    return await post('vehicles/register', vehicle.toJson());
  }

  Future<Response> getVehicleDetails(String vehicleId) async {
    return await get('vehicles/$vehicleId');
  }

  // Document APIs
  Future<Response> uploadDocument(String filePath, String documentType) async {
    final form = FormData({
      'file': MultipartFile(filePath, filename: 'document.jpg'),
      'type': documentType,
    });
    return await post('documents/upload', form);
  }

  Future<Response> getDocuments() async {
    return await get('documents');
  }

  Future<Response> getDocumentStatus(String documentId) async {
    return await get('documents/$documentId/status');
  }

  // Driver Availability APIs
  Future<Response> updateAvailability(Map<String, dynamic> availability) async {
    return await post('driver/availability', availability);
  }

  Future<Response> getDriverStatus() async {
    return await get('driver/status');
  }

  Future<Response> setBreakMode(Map<String, dynamic> breakData) async {
    return await post('driver/break', breakData);
  }








  Future<Response> uploadVehiclePhoto(String filePath, String photoType) async {
    final form = FormData({
      'file': MultipartFile(filePath, filename: 'vehicle_photo.jpg'),
      'photo_type': photoType,
      'vehicle_id': getVehicleId(), // Get current vehicle ID
    });
    return await post('vehicles/photos/upload', form);
  }

  // Get vehicle photos
  Future<Response> getVehiclePhotos([String? vehicleId]) async {
    final id = vehicleId ?? getVehicleId();
    return await get('vehicles/$id/photos');
  }

  // Delete vehicle photo
  Future<Response> deleteVehiclePhoto(String photoId) async {
    return await delete('vehicles/photos/$photoId');
  }

  // Update vehicle photo
  Future<Response> updateVehiclePhoto(String photoId, String filePath) async {
    final form = FormData({
      'file': MultipartFile(filePath, filename: 'updated_photo.jpg'),
    });
    return await put('vehicles/photos/$photoId', form);
  }

  // Get vehicle ID from storage or current session
  String getVehicleId() {
    // Implement logic to get current vehicle ID
    // This could be from GetStorage or current user session
    return 'current_vehicle_id';
  }
}


extension DocumentReviewApiExtension on ApiProvider {
  // Resubmit document for review
  Future<Response> resubmitDocument(String documentId) async {
    return await post('documents/$documentId/resubmit', {
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  // Get review status summary
  Future<Response> getReviewSummary() async {
    return await get('review/summary');
  }

  // Update document status (for admin use)
  Future<Response> updateReviewStatus(String documentId, String status, {String? notes}) async {
    return await put('documents/$documentId/review', {
      'status': status,
      'notes': notes,
      'review_date': DateTime.now().toIso8601String(),
    });
  }

  // Get review history
  Future<Response> getReviewHistory(String documentId) async {
    return await get('documents/$documentId/history');
  }

  // Submit for final approval
  Future<Response> submitForApproval() async {
    return await post('review/submit-approval', {
      'submission_date': DateTime.now().toIso8601String(),
    });
  }
}
