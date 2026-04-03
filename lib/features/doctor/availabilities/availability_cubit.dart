import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/network/dio.dart';
import '../../../../core/network/api_constants.dart';
import 'availability_state.dart';
import 'availability_model.dart';

class AvailabilityCubit extends Cubit<AvailabilityState> {
  AvailabilityCubit() : super(AvailabilityInitial());

  static AvailabilityCubit get(context) => BlocProvider.of(context);

  List<AvailabilityModel> availabilities = [];

  Future<void> getAvailabilities() async {
    emit(AvailabilityLoading());

    try {
      final response = await DioHelper.fetchData(
        url: ApiConstants.doctorAvailabilities,
      );


      print(" FULL RESPONSE:");
      print(response.data);

      final data = response.data['data'] as List;

      availabilities =
          data.map((e) => AvailabilityModel.fromJson(e)).toList();

      emit(AvailabilityLoaded(availabilities));
    } catch (e) {
      emit(AvailabilityError(_mapErrorMessage(e)));
    }
  }

  Future<bool> createAvailability({
    required String day,
    required String startTime,
    required String endTime,
    bool refreshAfterCreate = true,
  }) async {
    try {
      final response = await DioHelper.postData(
        url: ApiConstants.doctorAvailabilities,
        data: {
          "day": day,
          "startTime": startTime,
          "endTime": endTime,
        },
      );

      print("CREATE AVAILABILITY SUCCESS: ${response.data}");

      if (refreshAfterCreate) {
        await getAvailabilities();
      }

      return true;
    } catch (e) {
      if (e is DioException) {
        print("CREATE AVAILABILITY ERROR DATA: ${e.response?.data}");
        print("CREATE AVAILABILITY STATUS CODE: ${e.response?.statusCode}");
      }
      print("CREATE AVAILABILITY ERROR: $e");
      emit(AvailabilityError(_mapErrorMessage(e)));
      return false;
    }
  }

  Future<bool> deleteAvailability(
      String id, {
        bool refreshAfterDelete = true,
      }) async {
    try {
      await DioHelper.deleteData(
        url: "${ApiConstants.doctorAvailabilities}/$id",
      );

      if (refreshAfterDelete) {
        await getAvailabilities();
      }

      return true;
    } catch (e) {
      emit(AvailabilityError(_mapErrorMessage(e)));
      return false;
    }
  }

  Future<bool> updateAvailability({
    required String id,
    required String day,
    required String startTime,
    required String endTime,
    bool refreshAfterUpdate = true,
  }) async {
    try {
      await DioHelper.patchData(
        url: "${ApiConstants.doctorAvailabilities}/$id",
        data: {
          "day": day,
          "startTime": startTime,
          "endTime": endTime,
        },
      );

      if (refreshAfterUpdate) {
        await getAvailabilities();
      }

      return true;
    } catch (e) {
      emit(AvailabilityError(_mapErrorMessage(e)));
      return false;
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

      if (error.response?.statusCode == 401) {
        return "انتهت صلاحية تسجيل الدخول، سجل دخولك مرة أخرى";
      }

      if (error.response?.statusCode == 403) {
        return "غير مصرح لك بتنفيذ هذا الإجراء";
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

    return "حدث خطأ غير متوقع، حاول مرة أخرى";
  }
}