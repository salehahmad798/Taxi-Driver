class VehicleModel {
  String? drivingLicense;
  String? vehicleType;
  String? make;
  String? model;
  String? year;
  String? color;
  String? fuelType;
  String? engineNumber;
  String? chassisNumber;
  String? ownerAddress;
  String? registrationDate;
  String? expiryDate;

  VehicleModel({
    this.drivingLicense,
    this.vehicleType,
    this.make,
    this.model,
    this.year,
    this.color,
    this.fuelType,
    this.engineNumber,
    this.chassisNumber,
    this.ownerAddress,
    this.registrationDate,
    this.expiryDate,
  });

  Map<String, dynamic> toJson() => {
    'driving_license': drivingLicense,
    'vehicle_type': vehicleType,
    'make': make,
    'model': model,
    'year': year,
    'color': color,
    'fuel_type': fuelType,
    'engine_number': engineNumber,
    'chassis_number': chassisNumber,
    'owner_address': ownerAddress,
    'registration_date': registrationDate,
    'expiry_date': expiryDate,
  };

  factory VehicleModel.fromJson(Map<String, dynamic> json) => VehicleModel(
    drivingLicense: json['driving_license'],
    vehicleType: json['vehicle_type'],
    make: json['make'],
    model: json['model'],
    year: json['year'],
    color: json['color'],
    fuelType: json['fuel_type'],
    engineNumber: json['engine_number'],
    chassisNumber: json['chassis_number'],
    ownerAddress: json['owner_address'],
    registrationDate: json['registration_date'],
    expiryDate: json['expiry_date'],
  );
}
