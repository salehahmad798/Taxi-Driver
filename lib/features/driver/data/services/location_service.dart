import 'dart:async';
import 'package:geolocator/geolocator.dart';

class LocationService {
  StreamSubscription<Position>? _locationSubscription;
  Position? _currentPosition;
  
  // Get current location
  Future<Position> getCurrentLocation() async {
    try {
      // Check if location permission is granted
      bool hasPermission = await _handleLocationPermission();
      if (!hasPermission) {
        throw Exception('Location permission denied');
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      
      _currentPosition = position;
      return position;
    } catch (e) {
      print('Error getting current location: $e');
      throw Exception('Failed to get current location');
    }
  }

  // Get location stream for real-time tracking
  Stream<Position> getLocationStream() {
    return Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10, // Update every 10 meters
      ),
    );
  }

  // Start location tracking
  void startLocationTracking(Function(Position) onLocationUpdate) {
    _locationSubscription = getLocationStream().listen(
      (Position position) {
        _currentPosition = position;
        onLocationUpdate(position);
      },
      onError: (error) {
        print('Location tracking error: $error');
      },
    );
  }

  // Stop location tracking
  void stopLocationTracking() {
    _locationSubscription?.cancel();
    _locationSubscription = null;
  }

  // Calculate distance between two points
  double calculateDistance(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) {
    return Geolocator.distanceBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );
  }

  // Calculate bearing between two points
  double calculateBearing(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) {
    return Geolocator.bearingBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );
  }

  // Check if location services are enabled
  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  // Get current location permission status
  Future<LocationPermission> getLocationPermission() async {
    return await Geolocator.checkPermission();
  }

  // Request location permission
  Future<LocationPermission> requestLocationPermission() async {
    return await Geolocator.requestPermission();
  }

  // Handle location permission with proper checks
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied');
    }

    return true;
  }

  // Get last known position
  Position? get lastKnownPosition => _currentPosition;

  // Check if user is at specific location (within radius)
  bool isAtLocation(
    double targetLat,
    double targetLng,
    {double radiusInMeters = 100}
  ) {
    if (_currentPosition == null) return false;
    
    double distance = calculateDistance(
      _currentPosition!.latitude,
      _currentPosition!.longitude,
      targetLat,
      targetLng,
    );
    
    return distance <= radiusInMeters;
  }

  // Get address from coordinates (reverse geocoding)
  Future<String> getAddressFromCoordinates(double lat, double lng) async {
    try {
      // You can integrate with Google Maps Geocoding API using HTTP requests
      return "Sample Address, Lagos, Nigeria";
    } catch (e) {
      print('Error getting address: $e');
      return "Unknown Location";
    }
  }

  // Dispose resources
  void dispose() {
    stopLocationTracking();
  }
}
