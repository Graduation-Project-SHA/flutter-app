class ApiConstants {
  static const String baseUrl = "https://tape-ate-unknown-rides.trycloudflare.com";

  static const String register = "$baseUrl/auth/sign-up";
  static const String login = "$baseUrl/auth/local-login";
  static const String requestPasswordReset = "$baseUrl/auth/request-password-reset";
  static const String verifyResetCode = "$baseUrl/auth/verify-reset-code";
  static const String resetPassword = "$baseUrl/auth/reset-password";
  static const String refreshToken = "$baseUrl/auth/refresh-token";
  static const String getProfile = "$baseUrl/users/profile";
}
