import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/network/dio.dart';
import 'doctor_me_model.dart';
import 'doctor_me_state.dart';

class DoctorMeCubit extends Cubit<DoctorMeState> {
  DoctorMeCubit() : super(DoctorMeInitial());

  static DoctorMeCubit get(context) => BlocProvider.of(context);

  Future<void> getDoctorMe() async {
    emit(DoctorMeLoading());

    try {
      final response = await DioHelper.fetchData(
        url: "http://wiqaya.duckdns.org:3000/doctor/me",
      );

      print("Doctor me response: ${response.data}");

      final data = response.data['data'];
      emit(DoctorMeLoaded(DoctorMeModel.fromJson(data)));
    } catch (e) {
      emit(DoctorMeError(_mapErrorMessage(e)));
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

    return "حدث خطأ أثناء تحميل بيانات الدكتور";
  }
}