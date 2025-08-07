import 'package:flutter/material.dart';

class VehiclePhoto {
  String? id;
  String type;
  String description;
  IconData icon;
  String status;
  String? filePath;
  String? serverUrl;
  String? uploadDate;
  bool isRequired;

  VehiclePhoto({
    this.id,
    required this.type,
    required this.description,
    required this.icon,
    this.status = 'pending',
    this.filePath,
    this.serverUrl,
    this.uploadDate,
    this.isRequired = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'description': description,
        'status': status,
        'file_path': filePath,
        'server_url': serverUrl,
        'upload_date': uploadDate,
        'is_required': isRequired,
      };

  factory VehiclePhoto.fromJson(Map<String, dynamic> json) => VehiclePhoto(
        id: json['id'],
        type: json['type'],
        description: json['description'] ?? '',
        icon: Icons.directions_car, // Default icon
        status: json['status'] ?? 'pending',
        filePath: json['file_path'],
        serverUrl: json['server_url'],
        uploadDate: json['upload_date'],
        isRequired: json['is_required'] ?? false,
      );
}

class PhotoType {
  final String name;
  final String description;
  final IconData icon;
  final bool isRequired;

  PhotoType(this.name, this.description, this.icon, this.isRequired);
}
