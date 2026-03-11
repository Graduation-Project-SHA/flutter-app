import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/network/api_constants.dart';
import '../../../../../core/network/dio.dart';
import '../doctor_details_model/doctor_details_model.dart';
import 'doctor_details_state.dart';

class DoctorDetailsCubit extends Cubit<DoctorDetailsState> {
  DoctorDetailsCubit() : super(DoctorDetailsInitial());

  static DoctorDetailsCubit get(context) => BlocProvider.of(context);

  Future<void> getDoctorDetails(String doctorId) async {
    emit(DoctorDetailsLoading());

    try {
      final response = await DioHelper.fetchData(
        url: ApiConstants.publicDoctorDetails(doctorId),
      );

      print("Doctor details response: ${response.data}");

      final data = response.data['data'];

      if (data == null) {
        emit(DoctorDetailsError("لا توجد بيانات"));
        return;
      }

      emit(DoctorDetailsLoaded(DoctorDetailsModel.fromJson(data)));
    } catch (e) {
      emit(DoctorDetailsError(_mapErrorMessage(e)));
    }
  }

  String _mapErrorMessage(dynamic error) {
    if (error is DioException) {
      if (error.type == DioExceptionType.connectionError ||
          error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.sendTimeout) {
        return "تعذر الاتصال بالإنترنت، تأكد من الشبكة وحاول مرة أخرى";
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

    return "حدث خطأ أثناء تحميل تفاصيل الدكتور";
  }
}