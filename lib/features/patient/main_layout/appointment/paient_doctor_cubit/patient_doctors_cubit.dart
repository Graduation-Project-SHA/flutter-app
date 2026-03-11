import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/network/api_constants.dart';
import '../../../../../core/network/dio.dart';
import '../patient_doctor_model/patient_doctor_model.dart';
import 'patient_doctors_state.dart';

class PatientDoctorsCubit extends Cubit<PatientDoctorsState> {
  PatientDoctorsCubit() : super(PatientDoctorsInitial());

  static PatientDoctorsCubit get(context) => BlocProvider.of(context);

  List<PatientDoctorModel> doctors = [];

  Future<void> getDoctors({
    String? specialization,
    String? name,
    int page = 1,
    int limit = 10,
  }) async {
    emit(PatientDoctorsLoading());

    try {
      final query = <String, dynamic>{
        "page": page,
        "limit": limit,
      };

      if (specialization != null && specialization.trim().isNotEmpty) {
        query["specialization"] = specialization.trim();
      }

      if (name != null && name.trim().isNotEmpty) {
        query["name"] = name.trim();
      }

      final response = await DioHelper.fetchData(
        url: ApiConstants.publicDoctors,
        query: query,
      );

      print("Doctors response: ${response.data}");

      final List data = response.data["data"] ?? [];

      doctors = data.map((e) => PatientDoctorModel.fromJson(e)).toList();

      emit(PatientDoctorsLoaded(doctors));
    } catch (e) {
      emit(PatientDoctorsError(_mapErrorMessage(e)));
    }
  }

  Future<void> getAllDoctors() async {
    await getDoctors();
  }

  String _mapErrorMessage(dynamic error) {
    if (error is DioException) {
      if (error.type == DioExceptionType.connectionError ||
          error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.sendTimeout) {
        return "تعذر الاتصال بالإنترنت، تأكدي من الشبكة وحاولي مرة أخرى";
      }

      final data = error.response?.data;
      if (data is Map && data['message'] != null) {
        final message = data['message'];
        if (message is List && message.isNotEmpty) {
          return message.join(", ");
        }
        return message.toString();
      }
    }

    return "حدث خطأ أثناء تحميل الأطباء";
  }
}