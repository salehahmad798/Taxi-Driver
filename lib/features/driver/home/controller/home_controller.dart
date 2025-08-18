import 'package:get/get.dart';
import 'package:taxi_driver/data/models/document_model.dart';
import 'package:taxi_driver/data/models/home_document_model.dart';
import 'package:taxi_driver/data/services/document_services.dart';
import 'package:taxi_driver/data/services/ride_service.dart';
import 'package:taxi_driver/features/driver/home/controller/drawer_controller.dart';
import 'package:taxi_driver/features/driver/pickup/model/ride_request_model.dart';
import 'package:taxi_driver/routes/app_routes.dart';

class HomeController extends GetxController {
  final RideService _rideService = Get.find();
  final DocumentService _documentService = Get.find();
  
  // =============== Driver status and earnings =================
  final RxBool isAvailable = true.obs;
  final RxDouble todayEarnings = 0.0.obs;
  final RxInt todayBookings = 0.obs;
  final RxString driverBalance = "₦10000".obs;
  
  // ====================== Document verification =================
  final RxBool documentsVerified = false.obs;
  final RxList<HomeDocumentModel> documents = <HomeDocumentModel>[].obs;
  final RxString documentStatus = "under_review".obs;
  
  // =================== Ride requests ===============
  final RxList<RideRequestModel> nearbyRequests = <RideRequestModel>[].obs;
  final Rx<RideRequestModel?> currentRequest = Rx<RideRequestModel?>(null);
  final RxBool hasIncomingRequest = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadDriverData();
    checkDocumentStatus();
    startListeningForRequests();
  }

  // ================= Load driver's daily stats ===============
  Future<void> loadDriverData() async {
    try {
      final stats = await _rideService.getDriverStats();
      todayEarnings(stats['earnings']);
      todayBookings(stats['bookings']);
      driverBalance(stats['balance']);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load driver data');
    }
  }

  //  ===================== Check document verification status ===========
  Future<void> checkDocumentStatus() async {
    try {
      final docs = await _documentService.getDocuments();
      documents.assignAll(docs);
      
      bool allVerified = docs.every((doc) => doc.status == 'verified');
      documentsVerified(allVerified);
      
      if (!allVerified) {
        documentStatus("Documents under review");
      } else {
        documentStatus("All documents verified");
      }
    } catch (e) {
      documentStatus("Document check failed");
    }
  }

  // Listen for incoming ride requests
  void startListeningForRequests() {
    _rideService.listenForRequests((request) {
      if (isAvailable.value && documentsVerified.value) {
        currentRequest(request);
        hasIncomingRequest(true);
      }
    });
  }

  // Toggle driver availability
  void toggleAvailability() {
    if (!documentsVerified.value) {
      Get.snackbar('Cannot Go Online', 'Documents need verification');
      return;
    }
    
    isAvailable(!isAvailable.value);
    _rideService.updateAvailability(isAvailable.value);
    
    if (!isAvailable.value) {
      hasIncomingRequest(false);
      currentRequest(null);
    }
  }

  // ==============  Accept ride request ================
  Future<void> acceptRequest(RideRequestModel request) async {
    try {
      await _rideService.acceptRequest(request.id);
      hasIncomingRequest(false);
      Get.toNamed(AppRoutes.pickup, arguments: request);
    } catch (e) {
      Get.snackbar('Error', 'Failed to accept request');
    }
  }

  // Decline ride request
  void declineRequest() {
    hasIncomingRequest(false);
    currentRequest(null);
  }

  // ================== Navigate to document upload ===============
  void viewDocuments() {
    // In real app, this might open a document upload screen
    Get.snackbar('Documents', 'Document management feature');
  }

  //  ============ Create new request manually (if allowed) ============
  void createNewRequest() {
    Get.snackbar('New Request', 'Manual request creation');
  }






  final DrawerController drawerController = Get.put(DrawerController());
  final RxString selectedRide = 'Balance ₹0'.obs;

  @override
  // void onInit() {
  //   super.onInit();
  //   // Initialize any home screen specific data
  // }

  void openDrawer() {
    // drawerController.openDrawer();
  }

    // This will be called from the UI to open drawer
  }
