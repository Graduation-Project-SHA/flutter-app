import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/network/dio.dart';
import 'update_doctor_profile_state.dart';

class UpdateDoctorProfileCubit extends Cubit<UpdateDoctorProfileState> {
  UpdateDoctorProfileCubit() : super(UpdateDoctorProfileInitial());

  static UpdateDoctorProfileCubit get(context) => BlocProvider.of(context);

  Future<void> updateDoctorProfile({
    String? clinicAddress,
    double? latitude,
    double? longitude,
    String? bio,
  }) async {
    emit(UpdateDoctorProfileLoading());

    try {
      final body = <String, dynamic>{};

      if (clinicAddress != null && clinicAddress.trim().isNotEmpty) {
        body['clinicAddress'] = clinicAddress.trim();
      }

      if (latitude != null) {
        body['latitude'] = latitude;
      }

      if (longitude != null) {
        body['longitude'] = longitude;
      }

      if (bio != null && bio.trim().isNotEmpty) {
        body['bio'] = bio.trim();
      }

      await DioHelper.patchData(
        url: "http://wiqaya.duckdns.org:3000/doctor/me/profile",
        data: body,
      );

      emit(UpdateDoctorProfileSuccess());
    } catch (e) {
      emit(UpdateDoctorProfileError(_mapErrorMessage(e)));
    }
  }

  String _mapErrorMessage(dynamic error) {
    if (error is DioException) {
      final data = error.response?.data;
      if (data is Map && data['message'] != null) {
        final message = data['message'];
        if (message is List && message.isNotEmpty) {
          return message.join(", ");
        }
        return message.toString();
      }
    }

    return "حدث خطأ أثناء تحديث الملف الشخصي";
  }
}