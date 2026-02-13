class ApiConstants {
  static const String baseUrl = "http://wiqaya.duckdns.org:3000";

  static const String register = "$baseUrl/auth/sign-up";
  static const String login = "$baseUrl/auth/local-login";

  static const String requestPasswordReset = "$baseUrl/auth/request-password-reset";

  static const String verifyResetCode = "$baseUrl/auth/verify-password-reset-otp";

  static const String resetPassword = "$baseUrl/auth/reset-password";
  static const String refreshToken = "$baseUrl/auth/refresh-token";

  static const String verifyEmail="$baseUrl/auth/verify-email";
  static const String getProfile = "$baseUrl/users/doctor_profile";

  static const String logOut = "$baseUrl/auth/logout";



  static const String messages = "/doctor_messages";

}
