// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:taxi_driver/features/driver/data/services/location_service.dart';
// import 'package:taxi_driver/features/driver/data/services/ride_service.dart';
// import 'package:taxi_driver/features/driver/pickup/model/ride_request_model.dart';
// import 'package:taxi_driver/routes/app_routes.dart';

// class PickupController extends GetxController {
//   final RideService _rideService = Get.find();
//   final LocationService _locationService = Get.find();
  
//   // Ride information
//   late Rx<RideRequestModel> currentRide;
//   final RxString rideStatus = 'heading_to_pickup'.obs; // heading_to_pickup, arrived, in_progress, completed
  
//   // Map and location
//   final Rx<LatLng?> driverLocation = Rx<LatLng?>(null);
//   final Rx<LatLng?> pickupLocation = Rx<LatLng?>(null);
//   final Rx<LatLng?> destinationLocation = Rx<LatLng?>(null);
//   final RxSet<Marker> mapMarkers = <Marker>{}.obs;
//   final RxSet<Polyline> mapPolylines = <Polyline>{}.obs;
  
//   // Trip details
//   final RxDouble estimatedTime = 0.0.obs;
//   final RxDouble distanceToPickup = 0.0.obs;
//   final RxString tripDuration = "0 min".obs;
//   final RxString tripDistance = "0 km".obs;
//   final RxDouble fareAmount = 0.0.obs;
  
//   // Customer info
//   final RxString customerName = "".obs;
//   final RxString customerPhone = "".obs;
//   final RxString customerRating = "4.8".obs;

//   @override
//   void onInit() {
//     super.onInit();
//     currentRide = Rx<RideRequestModel>(Get.arguments as RideRequestModel);
//     initializeRide();
//     startLocationTracking();
//   }

//   void initializeRide() {
//     // Set customer details
//     customerName(currentRide.value.customerName);
//     customerPhone(currentRide.value.customerPhone);
//     fareAmount(currentRide.value.fareAmount);
    
//     // Set locations
//     pickupLocation(LatLng(
//       currentRide.value.pickupLat,
//       currentRide.value.pickupLng,
//     ));
    
//     destinationLocation(LatLng(
//       currentRide.value.destinationLat,
//       currentRide.value.destinationLng,
//     ));
    
//     updateMapMarkers();
//   }

//   void startLocationTracking() {
//     _locationService.getLocationStream().listen((location) {
//       driverLocation(LatLng(location.latitude, location.longitude));
//       updateDriverLocationOnServer();
//       calculateDistances();
//     });
//   }

//   void updateMapMarkers() {
//     mapMarkers.clear();
    
//     // Pickup marker
//     if (pickupLocation.value != null) {
//       mapMarkers.add(
//         Marker(
//           markerId: MarkerId('pickup'),
//           position: pickupLocation.value!,
//           infoWindow: InfoWindow(title: 'Pickup: ${currentRide.value.pickupAddress}'),
//           icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
//         ),
//       );
//     }

//     // Destination marker
//     if (destinationLocation.value != null) {
//       mapMarkers.add(
//         Marker(
//           markerId: MarkerId('destination'),
//           position: destinationLocation.value!,
//           infoWindow: InfoWindow(title: 'Drop-off: ${currentRide.value.destinationAddress}'),
//           icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
//         ),
//       );
//     }

//     // Driver marker
//     if (driverLocation.value != null) {
//       mapMarkers.add(
//         Marker(
//           markerId: MarkerId('driver'),
//           position: driverLocation.value!,
//           infoWindow: InfoWindow(title: 'You are here'),
//           icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
//         ),
//       );
//     }
//   }

//   Future<void> updateDriverLocationOnServer() async {
//     if (driverLocation.value != null) {
//       await _rideService.updateDriverLocation(
//         currentRide.value.id,
//         driverLocation.value!.latitude,
//         driverLocation.value!.longitude,
//       );
//     }
//   }

//   void calculateDistances() {
//     if (driverLocation.value != null && pickupLocation.value != null) {
//       // Calculate distance to pickup (you'll implement actual distance calculation)
//       distanceToPickup(2.5); // Mock data
//       estimatedTime(8); // Mock ETA in minutes
//     }
//   }

//   // START PICKUP - When driver arrives at pickup location
//   Future<void> startPickup() async {
//     try {
//       await _rideService.startPickup(currentRide.value.id);
//       rideStatus('arrived');
//       Get.snackbar('Arrived', 'You have arrived at pickup location');
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to start pickup');
//     }
//   }

//   // START TRIP - When customer gets in the car
//   Future<void> startTrip() async {
//     try {
//       await _rideService.startTrip(currentRide.value.id);
//       rideStatus('in_progress');
//       Get.snackbar('Trip Started', 'Navigate to destination');
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to start trip');
//     }
//   }

//   // END PICKUP - When trip is completed
//   Future<void> endTrip() async {
//     try {
//       await _rideService.endTrip(currentRide.value.id);
//       rideStatus('completed');
      
//       // Show trip summary and navigate back to home
//       Get.dialog(
//         AlertDialog(
//           title: Text('Trip Completed'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text('Fare: ₦${fareAmount.value}'),
//               Text('Distance: ${tripDistance.value}'),
//               Text('Duration: ${tripDuration.value}'),
//             ],
//           ),
//           actions: [
//             ElevatedButton(
//               onPressed: () {
//                 Get.back(); // Close dialog
//                 Get.offAllNamed(AppRoutes.home); // Go back to home
//               },
//               child: Text('Continue'),
//             ),
//           ],
//         ),
//       );
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to end trip');
//     }
//   }

//   // Call customer
//   void callCustomer() {
//     // Implement phone call functionality
//     Get.snackbar('Calling', 'Calling ${customerName.value}...');
//   }

//   // Open chat
//   void openChat() {
//     Get.toNamed(AppRoutes.chat, arguments: currentRide.value);
//   }

//   // Cancel trip
//   Future<void> cancelTrip() async {
//     try {
//       await _rideService.cancelTrip(currentRide.value.id);
//       Get.offAllNamed(AppRoutes.home);
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to cancel trip');
//     }
//   }
// }




import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi_driver/data/services/location_service.dart';
import 'package:taxi_driver/data/services/ride_service.dart';
import 'package:taxi_driver/features/driver/pickup/model/ride_request_model.dart';
import 'package:taxi_driver/features/driver/home/controller/home_controller.dart';
import 'package:taxi_driver/routes/app_routes.dart';

class PickupController extends GetxController {
  final RideService _rideService = Get.find();
  final LocationService _locationService = Get.find();
  
  // Ride information
  late Rx<RideRequestModel> currentRide;
  final RxString rideStatus = 'heading_to_pickup'.obs; // heading_to_pickup, arrived, in_progress, completed
  
  // Map and location
  final Rx<LatLng?> driverLocation = Rx<LatLng?>(null);
  final Rx<LatLng?> pickupLocation = Rx<LatLng?>(null);
  final Rx<LatLng?> destinationLocation = Rx<LatLng?>(null);
  final RxSet<Marker> mapMarkers = <Marker>{}.obs;
  final RxSet<Polyline> mapPolylines = <Polyline>{}.obs;
  
  // Trip details
  final RxDouble estimatedTime = 0.0.obs;
  final RxDouble distanceToPickup = 0.0.obs;
  final RxString tripDuration = "0 min".obs;
  final RxString tripDistance = "0 km".obs;
  final RxDouble fareAmount = 0.0.obs;
  
  // Customer info
  final RxString customerName = "".obs;
  final RxString customerPhone = "".obs;
  final RxString customerRating = "4.8".obs;

  @override
  void onInit() {
    super.onInit();
    
    // Safe handling of arguments to prevent type cast error
    RideRequestModel? rideRequest;
    
    try {
      // Try to get from arguments first
      final arguments = Get.arguments;
      if (arguments != null && arguments is RideRequestModel) {
        rideRequest = arguments;
      }
    } catch (e) {
      print('Error getting arguments: $e');
    }
    
    // If no arguments, try to get from HomeController
    if (rideRequest == null) {
      try {
        final homeController = Get.find<HomeController>();
        rideRequest = homeController.currentRequest.value;
      } catch (e) {
        print('Error getting from HomeController: $e');
      }
    }
    
    // If still null, create a mock request
    if (rideRequest == null) {
      rideRequest = createMockRequest();
    }
    
    currentRide = Rx<RideRequestModel>(rideRequest);
    initializeRide();
    startLocationTracking();
  }

  // Create a mock request for testing purposes
  RideRequestModel createMockRequest() {
    return RideRequestModel(
      id: 'mock_001',
      customerName: 'John Doe',
      customerPhone: '+234 123 456 7890',
      customerAvatar: '',
      pickupAddress: '123 Main Street, Lagos',
      destinationAddress: '456 Oak Avenue, Lagos',
      fareAmount: 2500.0,
      pickupLat: 6.5244,
      pickupLng: 3.3792,
      destinationLat: 6.4474,
      destinationLng: 3.3903, customerId: '', paymentMethod: '', status: '',
      // distance: '5.2 km',
      // estimatedTime: '15 mins',
      // Add other required fields based on your RideRequestModel
    );
  }

  void initializeRide() {
    // Set customer details
    customerName(currentRide.value.customerName);
    customerPhone(currentRide.value.customerPhone);
    fareAmount(currentRide.value.fareAmount);
    
    // Set locations with null safety
    try {
      pickupLocation(LatLng(
        currentRide.value.pickupLat,
        currentRide.value.pickupLng,
      ));
      
      destinationLocation(LatLng(
        currentRide.value.destinationLat,
        currentRide.value.destinationLng,
      ));
    } catch (e) {
      print('Error setting locations: $e');
      // Set default Lagos coordinates if location data is missing
      pickupLocation(LatLng(6.5244, 3.3792));
      destinationLocation(LatLng(6.4474, 3.3903));
    }
    
    updateMapMarkers();
  }

  void startLocationTracking() {
    _locationService.getLocationStream().listen((location) {
      driverLocation(LatLng(location.latitude, location.longitude));
      updateDriverLocationOnServer();
      calculateDistances();
    });
  }

  void updateMapMarkers() {
    mapMarkers.clear();
    
    // Pickup marker
    if (pickupLocation.value != null) {
      mapMarkers.add(
        Marker(
          markerId: MarkerId('pickup'),
          position: pickupLocation.value!,
          infoWindow: InfoWindow(title: 'Pickup: ${currentRide.value.pickupAddress}'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        ),
      );
    }

    // Destination marker
    if (destinationLocation.value != null) {
      mapMarkers.add(
        Marker(
          markerId: MarkerId('destination'),
          position: destinationLocation.value!,
          infoWindow: InfoWindow(title: 'Drop-off: ${currentRide.value.destinationAddress}'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
    }

    // Driver marker
    if (driverLocation.value != null) {
      mapMarkers.add(
        Marker(
          markerId: MarkerId('driver'),
          position: driverLocation.value!,
          infoWindow: InfoWindow(title: 'You are here'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );
    }
  }

  Future<void> updateDriverLocationOnServer() async {
    if (driverLocation.value != null) {
      try {
        await _rideService.updateDriverLocation(
          currentRide.value.id,
          driverLocation.value!.latitude,
          driverLocation.value!.longitude,
        );
      } catch (e) {
        print('Error updating driver location: $e');
      }
    }
  }

  void calculateDistances() {
    if (driverLocation.value != null && pickupLocation.value != null) {
      // Calculate distance to pickup (you'll implement actual distance calculation)
      distanceToPickup(2.5); // Mock data
      estimatedTime(8); // Mock ETA in minutes
    }
  }

  // START PICKUP - When driver arrives at pickup location
  Future<void> startPickup() async {
    try {
      await _rideService.startPickup(currentRide.value.id);
      rideStatus('arrived');
      Get.snackbar('Arrived', 'You have arrived at pickup location');
    } catch (e) {
      Get.snackbar('Error', 'Failed to start pickup: ${e.toString()}');
    }
  }

  // START TRIP - When customer gets in the car
  Future<void> startTrip() async {
    try {
      await _rideService.startTrip(currentRide.value.id);
      rideStatus('in_progress');
      Get.snackbar('Trip Started', 'Navigate to destination');
    } catch (e) {
      Get.snackbar('Error', 'Failed to start trip: ${e.toString()}');
    }
  }

  // END PICKUP - When trip is completed
  Future<void> endTrip() async {
    try {
      await _rideService.endTrip(currentRide.value.id);
      rideStatus('completed');
      
      // Show trip summary and navigate back to home
      Get.dialog(
        AlertDialog(
          title: Text('Trip Completed'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Fare: ₦${fareAmount.value}'),
              Text('Distance: ${tripDistance.value}'),
              Text('Duration: ${tripDuration.value}'),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Get.back(); // Close dialog
                Get.offAllNamed(AppRoutes.home); // Go back to home
              },
              child: Text('Continue'),
            ),
          ],
        ),
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to end trip: ${e.toString()}');
    }
  }

  // Call customer
  void callCustomer() {
    // Implement phone call functionality
    Get.snackbar('Calling', 'Calling ${customerName.value}...');
  }

  // Open chat
  void openChat() {
    Get.toNamed(AppRoutes.chat, arguments: currentRide.value);
  }

  // Cancel trip
  Future<void> cancelTrip() async {
    try {
      await _rideService.cancelTrip(currentRide.value.id);
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      Get.snackbar('Error', 'Failed to cancel trip: ${e.toString()}');
    }
  }
}