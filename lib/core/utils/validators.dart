class ValidationService {
  /// Validate if a string is not empty ////////
  static String? validateRequiredField(String? value, {String fieldName = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  /// Validate email format //////////
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  /// Validate phone number format /////////////
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }
    final phoneRegex = RegExp(r'^\+?[0-9]{9,15}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  /// Validate password strength /////////////
  static String? validatePassword(String? value, {int minLength = 8}) {
    if (value == null || value.trim().isEmpty) {
      return 'Password is required';
    }
    if (value.length < minLength) {
      return 'Password must be at least $minLength characters long';
    }
    final hasUppercase = RegExp(r'[A-Z]').hasMatch(value);
    final hasLowercase = RegExp(r'[a-z]').hasMatch(value);
    final hasDigits = RegExp(r'\d').hasMatch(value);
    final hasSpecialCharacters = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value);

    if (!hasUppercase || !hasLowercase || !hasDigits || !hasSpecialCharacters) {
      return 'Password must include uppercase, lowercase, number, and special character';
    }
    return null;
  }

  /// Validate if two fields match (e.g., password and confirm password) ////////
  static String? validateMatchingFields(String? value1, String? value2, {String fieldName = 'Fields'}) {
    if (value1 != value2) {
      return '$fieldName do not match';
    }
    return null;
  }

  /// Validate a string's minimum length ////////////
  static String? validateMinLength(String? value, int minLength, {String fieldName = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    if (value.length < minLength) {
      return '$fieldName must be at least $minLength characters long';
    }
    return null;
  }

  /// Validate a string's maximum length /////////////
  static String? validateMaxLength(String? value, int maxLength, {String fieldName = 'This field'}) {
    if (value != null && value.length > maxLength) {
      return '$fieldName must not exceed $maxLength characters';
    }
    return null;
  }

  /// Validate numeric input ///////////
  static String? validateNumeric(String? value, {String fieldName = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    final numericRegex = RegExp(r'^[0-9]+$');
    if (!numericRegex.hasMatch(value)) {
      return '$fieldName must be a valid number';
    }
    return null;
  }

  /// Validate a URL ///////////////
  static String? validateUrl(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'URL is required';
    }
    final urlRegex = RegExp(
        r'^(https?|ftp):\/\/[^\s/$.?#].[^\s]*$');
    if (!urlRegex.hasMatch(value)) {
      return 'Enter a valid URL';
    }
    return null;
  }

  /// Validate if a string is a valid date ////////////
  static String? validateDate(String? value, {String format = 'yyyy-MM-dd'}) {
    if (value == null || value.trim().isEmpty) {
      return 'Date is required';
    }
    try {
      DateTime.parse(value);
      return null;
    } catch (_) {
      return 'Enter a valid date in the format $format';
    }
  }








// Email validation
  static bool isValidEmail(String email) {
    if (email.isEmpty) return false;
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  // Phone validation
  static bool isValidPhone(String phone) {
    if (phone.isEmpty) return false;
    // Remove all non-digit characters
    String digitsOnly = phone.replaceAll(RegExp(r'\D'), '');
    // Check if it has 10-15 digits
    return digitsOnly.length >= 10 && digitsOnly.length <= 15;
  }

  // Password validation
  static bool isValidPassword(String password) {
    if (password.isEmpty) return false;
    // At least 8 characters, one uppercase, one lowercase, one digit
    return password.length >= 8 &&
           RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$').hasMatch(password);
  }

  // Name validation
  static bool isValidName(String name) {
    if (name.isEmpty) return false;
    return name.trim().length >= 2 && 
           RegExp(r'^[a-zA-Z\s]+$').hasMatch(name.trim());
  }

  // OTP validation
  static bool isValidOtp(String otp) {
    if (otp.isEmpty) return false;
    return otp.length == 4 && RegExp(r'^\d{4}$').hasMatch(otp);
  }

  // Get email error message
  static String? getEmailError(String email) {
    if (email.isEmpty) return 'Email is required';
    if (!isValidEmail(email)) return 'Please enter a valid email address';
    return null;
  }

  // Get phone error message
  static String? getPhoneError(String phone) {
    if (phone.isEmpty) return 'Phone number is required';
    if (!isValidPhone(phone)) return 'Please enter a valid phone number';
    return null;
  }

  // Get password error message
  static String? getPasswordError(String password) {
    if (password.isEmpty) return 'Password is required';
    if (password.length < 8) return 'Password must be at least 8 characters';
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!RegExp(r'\d').hasMatch(password)) {
      return 'Password must contain at least one number';
    }
    return null;
  }

  // Get name error message
  static String? getNameError(String name, String fieldName) {
    if (name.isEmpty) return '$fieldName is required';
    if (name.trim().length < 2) return '$fieldName must be at least 2 characters';
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(name.trim())) {
      return '$fieldName can only contain letters and spaces';
    }
    return null;
  }

  // Get OTP error message
  static String? getOtpError(String otp) {
    if (otp.isEmpty) return 'OTP is required';
    if (otp.length != 4) return 'OTP must be 4 digits';
    if (!RegExp(r'^\d{4}$').hasMatch(otp)) return 'OTP must contain only numbers';
    return null;
  }

  // Format phone number
  static String formatPhoneNumber(String phone) {
    // Remove all non-digit characters
    String digitsOnly = phone.replaceAll(RegExp(r'\D'), '');
    
    // Add country code if not present
    if (digitsOnly.length == 10) {
      digitsOnly = '92$digitsOnly'; // Pakistan country code
    }
    
    // Add + prefix
    if (!digitsOnly.startsWith('92')) {
      digitsOnly = '92$digitsOnly';
    }
    
    return '+$digitsOnly';
  }

  // Clean phone number (remove formatting)
  static String cleanPhoneNumber(String phone) {
    return phone.replaceAll(RegExp(r'\D'), '');
  }

  
}