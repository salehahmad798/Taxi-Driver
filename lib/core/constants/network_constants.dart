class NetworkConstants {
  // Base
  static const String baseUrl = 'https://taxiportal.keyteh.site/api';

  // Auth
  static const String registerDriver = '/auth/driver/register';
  static const String loginDriver    = '/auth/driver/login';
  static const String otpVerify      = '/auth/driver/otp/verify';
  static const String otpResend      = '/auth/driver/otp/resend';
  static const String logoutDriver   = '/auth/driver/logout';

  // User
  static const String userProfile    = '/user/profile';
  static const String updateProfile  = '/user/profile/update';
  static const String uploadImage    = '/user/upload-image';

  // Wallet
  static const String wallet         = '/wallet';
  static const String addMoney       = '/wallet/add-money';

  // Notifications / History / Reviews
  static const String notifications  = '/notifications';
  static const String history        = '/history';
  static const String reviews        = '/reviews';

  // SOS
  static const String sosAlert       = '/sos/alert';
}
