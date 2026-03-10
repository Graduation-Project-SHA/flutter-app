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
    String? city,
    String? minPrice,
    String? maxPrice,
    String? sort,
    int page = 1,
    int limit = 10,
  }) async {
    emit(PatientDoctorsLoading());

    try {
      final query = <String, dynamic>{
        "page": page,
        "limit": limit,
      };

      if (specialization != null && specialization.isNotEmpty) {
        query["specialization"] = specialization;
      }
      if (name != null && name.isNotEmpty) {
        query["name"] = name;
      }
      if (city != null && city.isNotEmpty) {
        query["city"] = city;
      }
      if (minPrice != null && minPrice.isNotEmpty) {
        query["minPrice"] = minPrice;
      }
      if (maxPrice != null && maxPrice.isNotEmpty) {
        query["maxPrice"] = maxPrice;
      }
      if (sort != null && sort.isNotEmpty) {
        query["sort"] = sort;
      }

      final response = await DioHelper.fetchData(
        url: ApiConstants.publicDoctors,
        query: query,
      );

      final data = response.data['data'] as List;

      doctors = data.map((e) => PatientDoctorModel.fromJson(e)).toList();

      emit(PatientDoctorsLoaded(doctors));
    } catch (e) {
      emit(PatientDoctorsError(_mapErrorMessage(e)));
    }
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

    return "حدث خطأ أثناء تحميل الدكاترة";
  }
}