// import 'package:taxi_driver/core/utils/shared_pref_services.dart';

// class ApiService {
//   // ================  general user =================
//   static String baseURl = 'https://pharmacy-pro.hspfarms.com/api';
//   static String loginGeneral = '$baseURl/general/login';
//   static String signupGeneral = '$baseURl/general/register';

//   static String updateUser = '$baseURl/general/update/user';

//   static String bookAppointment = '$baseURl/general/bookings';

//   static String getAllClinicDoctors = '$baseURl/general/get-all-clinic-doctors';
//   static String getAllVaterinaryDoctors =
//       '$baseURl/general/get-all-veternary-doctors';
//   static String getAllAssistedTransport =
//       '$baseURl/general/get/all/assisted/transport';
//   static String getAllPharmacy = '$baseURl/general/get-all-pharmacy';
//   static String getAllBookingHistory = '$baseURl/general/booking-history';
//   static String ratings = '$baseURl/general/ratings';

//   static String updateBookingUserStatus({required id, required status}) {
//     return '$baseURl/general/bookings/$id/status?status=$status';
//   }

// // ===================== services provider =====================
//   static String loginServiceProvider = '$baseURl/service-provider/login';
//   static String signupServiceProvider = '$baseURl/service-provider/register';
//   static String getSPBooking({required professionType}) {
//     return '$baseURl/service-provider/bookings?profession_type=$professionType';
//   }

//   static String updateBookingStatus({required bookingId, status}) {
//     return '$baseURl/service-provider/bookings/$bookingId/status?status=$status';
//   }

//   static String gelClinicDetail(String id) {
//     return '$baseURl/service-provider/get-clinic-detail/$id';
//   }

//   static String updateClinicDoctor(String id) {
//     return '$baseURl/service-provider/update-clinic-doctors/$id';
//   }

//   static String deleteClinicDoctor(String id) {
//     return '$baseURl/service-provider/delete-clinic-doctors/$id';
//   }

//   static String addClinicDoctors =
//       '$baseURl/service-provider/add-clinic-doctors';

//   static String getVeternityDetail(String id) {
//     return '$baseURl/service-provider/veterinary/get-clinic-detail/$id';
//   }

//   static String getSPAllProducts({required userId}) {
//     return '$baseURl/service-provider/pharmacy/$userId/products';
//   }

//   static String getSPProfile({required userId, required professionType}) {
//     return '$baseURl/service-provider/user/profile/?user_id=$userId&profession_type=$professionType';
//   }

//   static String pharmacyDeleteProdouct({required id}) {
//     return '$baseURl/service-provider/pharmacy/product/$id';
//   }

//   static String pharmacyUpdateProduct({required id}) {
//     return '$baseURl/service-provider/pharmacy/product/$id';
//   }

//   static String updateUserSP = '$baseURl/service-provider/update/user';
//   static String pharmacyAddProduct =
//       '$baseURl/service-provider/pharmacy/product';

//   static String getAllSPBookingHistory =
//       '$baseURl/service-provider/booking-history';
// }

// /// headers

// dynamic headers = {
//   'Content-Type': 'application/json',
// };

// Future<Map<String, String>> getHeadersWithToken() async {
//   var token = await SharePrefServices.getAuthToken();
//   return {
//     'Content-Type': 'application/json',
//     'Authorization': 'Bearer $token',
//   };
// }