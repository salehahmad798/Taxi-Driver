
// ignore_for_file: avoid_print

// 2. RIDE SERVICE (app/data/services/ride_service.dart)
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:taxi_driver/features/driver/pickup/model/ride_request_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class RideService {
  final String baseUrl = 'YOUR_API_BASE_URL';
  final String wsUrl = 'wss://YOUR_WEBSOCKET_URL';
  
  WebSocketChannel? _rideChannel;
  Function(RideRequestModel)? _onNewRequest;
  Timer? _locationTimer;

  // Get driver's daily statistics
  Future<Map<String, dynamic>> getDriverStats() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/drivers/stats'),
        headers: {
          'Authorization': 'Bearer ${_getAuthToken()}',
          'Content-Type': 'application/json',
        },
      );
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return {
          'earnings': data['today_earnings']?.toDouble() ?? 0.0,
          'bookings': data['today_bookings'] ?? 0,
          'balance': data['balance'] ?? '₦10000',
          'total_trips': data['total_trips'] ?? 0,
          'rating': data['rating']?.toDouble() ?? 4.8,
        };
      } else {
        throw Exception('Failed to fetch driver stats: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching driver stats: $e');
      // Return mock data for development
      return {
        'earnings': 2500.0,
        'bookings': 8,
        'balance': '₦10000',
        'total_trips': 156,
        'rating': 4.8,
      };
    }
  }

  // Get nearby ride requests
  Future<List<RideRequestModel>> getNearbyRequests() async {
    try {
      final uri = Uri.parse('$baseUrl/rides/nearby').replace(queryParameters: {
        'lat': '6.5244',
        'lng': '3.3792',
        'radius': '5000',
      });
      
      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer ${_getAuthToken()}',
          'Content-Type': 'application/json',
        },
      );
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> requestsJson = data['requests'];
        return requestsJson
            .map((json) => RideRequestModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to fetch nearby requests: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching nearby requests: $e');
      return [];
    }
  }

  // Listen for new ride requests via WebSocket
  void listenForRequests(Function(RideRequestModel) onNewRequest) {
    _onNewRequest = onNewRequest;
    
    try {
      _rideChannel = WebSocketChannel.connect(
        Uri.parse('$wsUrl/rides/listen'),
      );
      
      _rideChannel!.stream.listen((data) {
        try {
          final Map<String, dynamic> json = jsonDecode(data);
          if (json['type'] == 'new_request') {
            final request = RideRequestModel.fromJson(json['data']);
            _onNewRequest?.call(request);
          }
        } catch (e) {
          print('Error parsing ride request: $e');
        }
      });
    } catch (e) {
      print('Failed to connect to ride WebSocket: $e');
    }
  }

  // Update driver availability status
  Future<void> updateAvailability(bool isAvailable) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/drivers/availability'),
        headers: {
          'Authorization': 'Bearer ${_getAuthToken()}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'is_available': isAvailable,
          'last_location': {
            'lat': 6.5244,
            'lng': 3.3792,
          },
        }),
      );
      
      if (response.statusCode != 200) {
        throw Exception('Failed to update availability: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating availability: $e');
      throw Exception('Failed to update availability');
    }
  }

  // Accept a ride request
  Future<void> acceptRequest(String requestId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/rides/$requestId/accept'),
        headers: {
          'Authorization': 'Bearer ${_getAuthToken()}',
          'Content-Type': 'application/json',
        },
      );
      
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to accept request: ${response.statusCode}');
      }
    } catch (e) {
      print('Error accepting request: $e');
      throw Exception('Failed to accept ride request');
    }
  }

  // Start pickup (driver arrives at pickup location)
  Future<void> startPickup(String rideId) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/rides/$rideId/start-pickup'),
        headers: {
          'Authorization': 'Bearer ${_getAuthToken()}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'status': 'arrived_at_pickup',
          'timestamp': DateTime.now().toIso8601String(),
        }),
      );
      
      if (response.statusCode != 200) {
        throw Exception('Failed to start pickup: ${response.statusCode}');
      }
    } catch (e) {
      print('Error starting pickup: $e');
      throw Exception('Failed to start pickup');
    }
  }

  // Start trip (customer gets in the car)
  Future<void> startTrip(String rideId) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/rides/$rideId/start-trip'),
        headers: {
          'Authorization': 'Bearer ${_getAuthToken()}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'status': 'in_progress',
          'start_time': DateTime.now().toIso8601String(),
        }),
      );
      
      if (response.statusCode != 200) {
        throw Exception('Failed to start trip: ${response.statusCode}');
      }
    } catch (e) {
      print('Error starting trip: $e');
      throw Exception('Failed to start trip');
    }
  }

  // End trip (trip completed)
  Future<void> endTrip(String rideId) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/rides/$rideId/end-trip'),
        headers: {
          'Authorization': 'Bearer ${_getAuthToken()}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'status': 'completed',
          'end_time': DateTime.now().toIso8601String(),
        }),
      );
      
      if (response.statusCode != 200) {
        throw Exception('Failed to end trip: ${response.statusCode}');
      }
    } catch (e) {
      print('Error ending trip: $e');
      throw Exception('Failed to end trip');
    }
  }

  // Cancel trip
  Future<void> cancelTrip(String rideId) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/rides/$rideId/cancel'),
        headers: {
          'Authorization': 'Bearer ${_getAuthToken()}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'status': 'cancelled',
          'cancelled_by': 'driver',
          'cancelled_at': DateTime.now().toIso8601String(),
        }),
      );
      
      if (response.statusCode != 200) {
        throw Exception('Failed to cancel trip: ${response.statusCode}');
      }
    } catch (e) {
      print('Error cancelling trip: $e');
      throw Exception('Failed to cancel trip');
    }
  }

  // Update driver location during trip
  Future<void> updateDriverLocation(String rideId, double lat, double lng) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/rides/$rideId/location'),
        headers: {
          'Authorization': 'Bearer ${_getAuthToken()}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'lat': lat,
          'lng': lng,
          'timestamp': DateTime.now().toIso8601String(),
        }),
      );
      
      // Don't throw error for location updates to avoid disrupting the trip
      if (response.statusCode != 200) {
        print('Warning: Location update failed with status ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating location: $e');
      // Don't throw error for location updates
    }
  }

  // Start periodic location updates
  void startLocationUpdates(
  String rideId,
  void Function(Function(double, double)) getCurrentLocation,
) {
  _locationTimer = Timer.periodic(Duration(seconds: 10), (timer) {
    try {
      getCurrentLocation((lat, lng) {
        updateDriverLocation(rideId, lat, lng);
      });
    } catch (e) {
      print('Error in location update timer: $e');
    }
  });
}


  // Stop location updates
  void stopLocationUpdates() {
    _locationTimer?.cancel();
    _locationTimer = null;
  }

  // Disconnect from ride WebSocket
  void disconnectFromRideUpdates() {
    _rideChannel?.sink.close();
    _rideChannel = null;
  }

  // Get auth token
  String _getAuthToken() {
    return 'your_auth_token_here';
  }
}
