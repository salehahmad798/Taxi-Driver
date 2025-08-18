import 'package:taxi_driver/data/models/auth_models.dart';

class ApiResponse<T> {
  final bool success;
  final String message;
  final T? data;
  final Meta? meta;
  final Map<String, dynamic>? errors;

  ApiResponse({
    required this.success,
    required this.message,
    this.data,
    this.meta,
    this.errors,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>)? fromJsonT,
  ) {
    return ApiResponse<T>(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null && fromJsonT != null 
          ? fromJsonT(json['data']) 
          : null,
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
      errors: json['errors'],
    );
  }
}