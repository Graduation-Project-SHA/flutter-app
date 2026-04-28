import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_project/features/patient/main_layout/appointment/patient_appointment_cubit/patient_appointment_states.dart';
import '../../../../../core/network/api_constants.dart';
import '../../../../../core/network/dio.dart';
import '../patient_appointment_model/patient_appointment_model.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  AppointmentCubit() : super(AppointmentInitial());

  static AppointmentCubit get(context) => BlocProvider.of(context);

  List<AppointmentModel> upcoming = [];
  List<AppointmentModel> past = [];

  Future<void> getMyAppointments() async {
    emit(AppointmentLoading());
    try {
      final response = await DioHelper.fetchData(
        url: ApiConstants.patientAppointments,
      );

      final List data = response.data['data'] ?? [];
      List<AppointmentModel> allAppointments = data.map((e) => AppointmentModel.fromJson(e)).toList();

      upcoming = allAppointments.where((a) => a.status == "PENDING").toList();
      past = allAppointments.where((a) => a.status == "COMPLETED" || a.status == "CANCELLED").toList();

      emit(AppointmentLoaded(upcoming, past));
    } catch (e) {
      print("Error fetching appointments: ${e.toString()}");
      emit(AppointmentError("فشل في تحميل المواعيد"));
    }
  }

  Future<void> bookAppointment({
    required int doctorProfileId,
    required int serviceId,
    required String appointmentDate,
    required String startTime,
    String? notes,
  }) async {
    emit(AppointmentLoading());
    try {
      await DioHelper.postData(
        url: ApiConstants.patientAppointments,
        data: {
          "doctorProfileId": doctorProfileId,
          "serviceId": serviceId,
          "appointmentDate": appointmentDate,
          "startTime": startTime,
          "notes": notes ?? "",
        },
      );
      emit(BookAppointmentSuccess());
      getMyAppointments();
    } catch (e) {
      emit(AppointmentError("فشل في إتمام الحجز"));
    }
  }

  Future<void> cancelAppointment({
    required int appointmentId,
    required String reason,
  }) async {
    emit(AppointmentLoading());
    try {
      await DioHelper.patchData(
        url: ApiConstants.cancelAppointment(appointmentId),
        data: {"cancellationReason": reason},
      );
      emit(CancelAppointmentSuccess());
      getMyAppointments();
    } catch (e) {
      print("Error cancelling appointment: ${e.toString()}");
      emit(AppointmentError("فشل في إلغاء الموعد"));
    }
  }

  Future<void> getAvailableSlots({
    required String userId,
    required String date,
    required int serviceId,
  }) async {
    emit(AppointmentLoading());
    try {
      final response = await DioHelper.fetchData(
        url: ApiConstants.getDoctorSlots(userId),
        query: {
          "date": date,
          "serviceId": serviceId,
        },
      );

      final List slotsFromApi = response.data['data']['availableSlots'] ?? [];
      List<String> availableSlots = slotsFromApi.map((e) => e['startTime'].toString()).toList();

      emit(AppointmentSlotsLoaded(availableSlots));
    } catch (e) {
      emit(AppointmentError("لا توجد مواعيد متاحة لهذه الخدمة"));
    }
  }
}