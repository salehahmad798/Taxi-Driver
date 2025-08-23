
class RegistrationResponse {
  final bool success;
  final String message;
  final RegistrationData data;
  final Meta? meta;

  RegistrationResponse({
    required this.success,
    required this.message,
    required this.data,
    this.meta,
  });

  factory RegistrationResponse.fromJson(Map<String, dynamic> json) {
    return RegistrationResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: RegistrationData.fromJson(json['data'] ?? {}),
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
    );
  }
}

class RegistrationData {
  final int otpCode;
  final int userId;

  RegistrationData({
    required this.otpCode,
    required this.userId,
  });

  factory RegistrationData.fromJson(Map<String, dynamic> json) {
    return RegistrationData(
      otpCode: json['otp_code'] ?? 0,
      userId: json['user_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'otp_code': otpCode,
      'user_id': userId,
    };
  }
}

class AuthResponse {
  final String accessToken;
  final String tokenType;
  final User user;
  final bool? isDocumentUploaded;
  final bool? isVehicleInformationUploaded;

  AuthResponse({
    required this.accessToken,
    required this.tokenType,
    required this.user,
    this.isDocumentUploaded,
    this.isVehicleInformationUploaded,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      accessToken: json['access_token'],
      tokenType: json['token_type'],
      user: User.fromJson(json['user']),
      isDocumentUploaded: json['is_document_uploaded'] ?? false,
      isVehicleInformationUploaded: json['is_vehicle_information_uploaded'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'token_type': tokenType,
      'user': user.toJson(),
      'is_document_uploaded': isDocumentUploaded,
      'is_vehicle_information_uploaded': isVehicleInformationUploaded,
    };
  }
}


class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final int status;
  final String? type;
  final String avatar;
  final String latitude;
  final String longitude;
  final String createdAt;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.status,
    this.type,
    required this.avatar,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      status: json['status'] ?? 0,
      type: json['type'],
      avatar: json['avatar'] ?? '',
      latitude: json['latitude'] ?? '0.0',
      longitude: json['longitude'] ?? '0.0',
      createdAt: json['created_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'status': status,
      'type': type,
      'avatar': avatar,
      'latitude': latitude,
      'longitude': longitude,
      'created_at': createdAt,
    };
  }

  String get fullName => '$firstName $lastName';
}

class Meta {
  final String requestId;
  final String timestamp;

  Meta({
    required this.requestId,
    required this.timestamp,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      requestId: json['request_id'] ?? '',
      timestamp: json['timestamp'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'request_id': requestId,
      'timestamp': timestamp,
    };
  }
}
