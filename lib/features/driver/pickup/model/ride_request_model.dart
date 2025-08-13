class RideRequestModel {
  final String id;
  final String customerId;
  final String customerName;
  final String customerPhone;
  final String customerAvatar;
  final double pickupLat;
  final double pickupLng;
  final String pickupAddress;
  final double destinationLat;
  final double destinationLng;
  final String destinationAddress;
  final double fareAmount;
  final String paymentMethod;
  // final DateTime requestTime;
  final String status;

  RideRequestModel({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.customerPhone,
    required this.customerAvatar,
    required this.pickupLat,
    required this.pickupLng,
    required this.pickupAddress,
    required this.destinationLat,
    required this.destinationLng,
    required this.destinationAddress,
    required this.fareAmount,
    required this.paymentMethod,
    // required this.requestTime,
    required this.status,
  });

  factory RideRequestModel.fromJson(Map<String, dynamic> json) {
    return RideRequestModel(
      id: json['id'],
      customerId: json['customer_id'],
      customerName: json['customer_name'],
      customerPhone: json['customer_phone'],
      customerAvatar: json['customer_avatar'] ?? '',
      pickupLat: json['pickup_lat'].toDouble(),
      pickupLng: json['pickup_lng'].toDouble(),
      pickupAddress: json['pickup_address'],
      destinationLat: json['destination_lat'].toDouble(),
      destinationLng: json['destination_lng'].toDouble(),
      destinationAddress: json['destination_address'],
      fareAmount: json['fare_amount'].toDouble(),
      paymentMethod: json['payment_method'],
      // requestTime: DateTime.parse(json['request_time'].toString()),
      status: json['status'],
    );
  }
}
