class ApiConstants {
  static const String baseUrl = "http://api.wiqaya.duckdns.org";

  static const String register = "$baseUrl/auth/sign-up";
  static const String login = "$baseUrl/auth/local-login";

  static const String requestPasswordReset = "$baseUrl/auth/request-password-reset";

  static const String verifyResetCode = "$baseUrl/auth/verify-password-reset-otp";

  static const String resetPassword = "$baseUrl/auth/reset-password";
  static const String refreshToken = "$baseUrl/auth/refresh-token";

  static const String verifyEmail="$baseUrl/auth/verify-email";
  static const String getProfile = "$baseUrl/users/doctor_profile";

  static const String logOut = "$baseUrl/auth/logout";


  static const String doctorAvailabilities = "$baseUrl/doctor/me/availabilities";


  static const String publicDoctors = "$baseUrl/doctors";
  static String publicDoctorDetails(String id) => "$baseUrl/doctors/$id";

  static const String messages = "$baseUrl/doctor_messages";

  static const String getConversations = "$baseUrl/api/conversations";

  static String getChatMessages(String conversationId) =>
      "$baseUrl/api/conversations/$conversationId/messages";


 // static const String patientAppointments = "$baseUrl/patient/me/appointments";
  //static const String slots = "$baseUrl/doctors/$doctorUserId/slots";
//  static const String details = "$baseUrl/doctors/$id";
}
