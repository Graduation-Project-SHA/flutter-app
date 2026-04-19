import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import '../../../../../core/network/api_constants.dart';
import '../../../../../core/network/dio.dart';
import 'medical_profile_model.dart';
import 'medical_profile_state.dart';

class MedicalProfileCubit extends Cubit<MedicalProfileState> {
  MedicalProfileCubit() : super(MedicalProfileInitial());

  Future<void> getFullProfile() async {
    emit(MedicalProfileLoading());
    try {
      final results = await Future.wait([
        DioHelper.fetchData(url: ApiConstants.getMyProfile),
        DioHelper.fetchData(url: ApiConstants.medicalProfile),
      ]);

      final profileData = results[0].data['data'];
      final medicalData = results[1].data['data'];

      emit(MedicalProfileLoaded(profile: profileData, medical: medicalData));
    } catch (e) {
      emit(MedicalProfileError(e.toString()));
    }
  }

  Future<void> updateMedicalProfile(MedicalProfileModel model) async {
    emit(MedicalProfileLoading());

    try {
      final response = await DioHelper.patchData(
        url: ApiConstants.medicalProfile,
        data: model.toJson(),
      );

      if (response.statusCode == 200) {
        emit(MedicalProfileSuccess());
      }
    } catch (e) {
      emit(MedicalProfileError(e.toString()));
    }
  }

  Future<void> updateFullProfile({
    required String firstName,
    required String lastName,
    required String phone,
    required MedicalProfileModel medicalModel,
    required String gender,
    required String dateOfBirth,
  }) async {
    emit(MedicalProfileLoading());
    try {
      await DioHelper.patchData(
        url: ApiConstants.updateProfile,
        data: {
          "firstName": firstName,
          "lastName": lastName,
          "phone": phone,
        },
      );


      await DioHelper.patchData(
        url: ApiConstants.medicalProfile,
        data: medicalModel.toJson(),
      );

      emit(MedicalProfileSuccess());
    } catch (e) {
      if (e is DioException && e.response != null) {
        print("❌ SERVER ERROR DETAILS: ${e.response?.data}");
      }
      emit(MedicalProfileError(e.toString()));
    }
  }

  String _formatDate(String date) {
    List<String> parts = date.split('-');
    if (parts.length != 3) return date;
    String year = parts[0];
    String month = parts[1].padLeft(2, '0');
    String day = parts[2].padLeft(2, '0');
    return "$year-$month-$day";
  }
}