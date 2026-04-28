class ApiConstants {
  static const String baseUrl = "http://api.wiqaya-app.me";

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


  static const String getMyProfile = "$baseUrl/patient/me";
  static const String medicalProfile = "$baseUrl/patient/me/medical-profile";
  static const String updateProfile = "$baseUrl/patient/me/profile";

  static String getDoctorSlots(String id) => "$baseUrl/doctors/$id/slots";
  static const String patientAppointments = "$baseUrl/patient/me/appointments";
  static String cancelAppointment(int id) => "$baseUrl/patient/me/appointments/$id/cancel";
}
