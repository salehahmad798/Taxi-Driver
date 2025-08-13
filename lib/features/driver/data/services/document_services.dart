import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:taxi_driver/features/driver/data/models/home_document_model.dart';

class DocumentService {
  final String baseUrl = 'YOUR_API_BASE_URL';

  // ==============  Get all driver documents ================
  Future<List<HomeDocumentModel>> getDocuments() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/drivers/documents'),
        headers: {
          'Authorization': 'Bearer ${_getAuthToken()}',
          'Content-Type': 'application/json',
        },
      );
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> documentsJson = data['documents'];
        return documentsJson
            .map((json) => HomeDocumentModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to fetch documents: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching documents: $e');
      // ================ Return mock data for development ==============
      return [
        HomeDocumentModel(
          id: '1',
          name: 'Driver\'s License',
          type: 'license',
          status: 'verified',
          uploadedAt: DateTime.now().subtract(Duration(days: 5)),
        ),
        HomeDocumentModel(
          id: '2',
          name: 'Vehicle Registration',
          type: 'vehicle_registration',
          status: 'under_review',
          uploadedAt: DateTime.now().subtract(Duration(days: 2)),
        ),
        HomeDocumentModel(
          id: '3',
          name: 'Insurance Certificate',
          type: 'insurance',
          status: 'pending',
          uploadedAt: DateTime.now().subtract(Duration(days: 1)),
        ),
      ];
    }
  }

  // =============== Upload a new document using multipart ============
  Future<void> uploadDocument(String filePath, String type) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/drivers/documents/upload'),
      );
      
      // ============== Add headers =============
      request.headers.addAll({
        'Authorization': 'Bearer ${_getAuthToken()}',
      });
      
      // Add file
      final file = await http.MultipartFile.fromPath('file', filePath);
      request.files.add(file);
      
      // Add other fields
      request.fields['type'] = type;
      request.fields['uploaded_at'] = DateTime.now().toIso8601String();
      
      // Send request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to upload document: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading document: $e');
      throw Exception('Failed to upload document');
    }
  }

  // Delete a document
  Future<void> deleteDocument(String documentId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/drivers/documents/$documentId'),
        headers: {
          'Authorization': 'Bearer ${_getAuthToken()}',
          'Content-Type': 'application/json',
        },
      );
      
      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('Failed to delete document: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting document: $e');
      throw Exception('Failed to delete document');
    }
  }

  // =============== Update document information ==============
  Future<void> updateDocument(String documentId, Map<String, dynamic> updates) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/drivers/documents/$documentId'),
        headers: {
          'Authorization': 'Bearer ${_getAuthToken()}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(updates),
      );
      
      if (response.statusCode != 200) {
        throw Exception('Failed to update document: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating document: $e');
      throw Exception('Failed to update document');
    }
  }

  // =============== Get document verification status ====================
  Future<Map<String, dynamic>> getVerificationStatus() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/drivers/verification-status'),
        headers: {
          'Authorization': 'Bearer ${_getAuthToken()}',
          'Content-Type': 'application/json',
        },
      );
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return {
          'is_verified': data['is_verified'] ?? false,
          'pending_documents': data['pending_documents'] ?? [],
          'rejected_documents': data['rejected_documents'] ?? [],
          'verification_message': data['message'] ?? '',
        };
      } else {
        throw Exception('Failed to fetch verification status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching verification status: $e');
      return {
        'is_verified': false,
        'pending_documents': ['vehicle_registration'],
        'rejected_documents': [],
        'verification_message': 'Some documents are still under review',
      };
    }
  }

  // ============== Get auth token by backend in furture sajid ==============
  String _getAuthToken() {
    return 'your_auth_token_here';
  }
}
