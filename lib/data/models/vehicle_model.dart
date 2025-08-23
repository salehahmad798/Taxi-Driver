class VehicleModel {
  final String vehicleType;
  final String registrationNumber;
  final String make;
  final String model;
  final String year;
  final String color;
  final String fuelType;
  final String ownerName;
  final String ownerAddress;
  final String engineNumber;
  final String chassisNumber;
  final String? registrationDate;
  final String? expiryDate;

  VehicleModel({
    required this.vehicleType,
    required this.registrationNumber,
    required this.make,
    required this.model,
    required this.year,
    required this.color,
    required this.fuelType,
    required this.ownerName,
    required this.ownerAddress,
    required this.engineNumber,
    required this.chassisNumber,
    this.registrationDate,
    this.expiryDate,
  });

  Map<String, dynamic> toJson() {
    return {
      "vehicle_type": vehicleType,
      "registration_number": registrationNumber,
      "vehicle_make": make,
      "vehicle_model": model,
      "vehicle_year": year,
      "vehicle_color": color,
      "fuel_type": fuelType,
      "owner_name": ownerName,
      "owner_address": ownerAddress,
      "engine_number": engineNumber,
      "chassis_number": chassisNumber,
      "registration_date": registrationDate,
      "expiry_date": expiryDate,
    };
  }
}
