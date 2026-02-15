import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_project/core/network/api_constants.dart';
import 'package:hive/hive.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../core/network/dio.dart';
import 'auth_state.dart';
import 'package:jwt_decoder/jwt_decoder.dart';


class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);
  String? syndicateCardPath;
  String? dFirstName, dLastName, dEmail, dPassword, dPhone, dGender, dBirthDate, dSpecialization, dBio, dExperience;
  double? dLat, dLng;

  String _translateError(String englishError) {
    if (englishError.contains('email or password is incorrect')) {
      return 'البريد الإلكتروني أو كلمة السر غير صحيحة.';
    }
    if (englishError.contains('Invalid credentials')) {
      return 'البريد الإلكتروني أو كلمة السر غير صالحة.';
    }
    if (englishError.contains('User with this email not found')) {
      return 'لم يتم العثور على مستخدم بهذا البريد الإلكتروني.';
    }
    if (englishError.contains('code is invalid or expired')) {
      return 'الرمز المُدخل غير صحيح أو انتهت صلاحيته.';
    }
    if (englishError.contains('Password must be')) {
      return 'كلمة السر ضعيفة. يجب أن تكون 8 أحرف على الأقل وتحتوي على رموز وحروف كبيرة وصغيرة وارقام.';
    }
    if (englishError.contains('phone')) {
      return 'رقم الهاتف غير صالح.';
    }
    return 'فشل الاتصال بالخادم. حاول مجدداً.';
  }

  String _handleDioError(error) {
    String rawErrorMessage = "حدث خطأ غير متوقع.";
    if (error is DioException && error.response != null) {
      final responseData = error.response!.data;

      if (responseData is Map) {
        if (responseData.containsKey('message')) {
          rawErrorMessage = responseData['message'];
        } else if (responseData.containsKey('error')) {
          if (responseData['error'] is List && responseData['error'].isNotEmpty) {
            rawErrorMessage = responseData['error'].first.toString();
          } else {
            rawErrorMessage = responseData['error'].toString();
          }
        }
      }
      else if (responseData is List && responseData.isNotEmpty) {
        try {
          if (responseData.first is Map && responseData.first.containsKey('message')) {
            rawErrorMessage = responseData.first['message'];
          } else {
            rawErrorMessage = responseData.first.toString();
          }
        } catch (e) {
          rawErrorMessage = responseData.first.toString();
        }
      }
      else if (responseData is String) {
        try {
          final decoded = json.decode(responseData);
          if (decoded is Map && decoded.containsKey('message')) {
            rawErrorMessage = decoded['message'];
          } else {
            rawErrorMessage = responseData;
          }
        } catch (e) {
          rawErrorMessage = responseData;
        }
      } else {
        rawErrorMessage = "خطأ من السيرفر: ${error.response!.statusCode}";
      }

    } else if (error is DioException && error.error.toString().contains('SocketException')) {
      rawErrorMessage = "خطأ في الاتصال بالشبكة. تأكد من الإنترنت.";
    } else if (error.toString().contains('SocketException')) {
      rawErrorMessage = "خطأ في الاتصال بالشبكة. تأكد من الإنترنت.";
    }

    return _translateError(rawErrorMessage);
  }

  void registerUser({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phone,
    required String gender,
    required String dateOfBirth,
   // required String profileImagePath,
  }) async {
    emit(RegisterLoadingState());

    try {
      FormData formData = FormData.fromMap({
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
        "phone": phone,
        "gender": gender.toUpperCase(),
        "dateOfBirth": dateOfBirth,
        "role": "USER",
        // "profileImage": await MultipartFile.fromFile(
        //   profileImagePath,
        //   filename: profileImagePath.split('/').last,
        // ),
      });

      final response = await DioHelper.dio.post(
        ApiConstants.register,
        data: formData,
        options: Options(
          headers: {
            "Content-Type": "multipart/form-data",
          },
        ),
      );

      emit(RegisterSuccessState());
    } catch (error) {
      emit(RegisterErrorState(_handleDioError(error)));
    }
  }




  Future<void> _saveAuthData(Map<String, dynamic> data) async {
    final authBox = Hive.box('authBox');

    final accessToken = data['data']['access_token'];
    final refreshToken = data['data']['refresh_token'];

    await authBox.put('accessToken', accessToken);
    await authBox.put('refreshToken', refreshToken);

    Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);

    await authBox.put('userId', decodedToken['sub']);
    await authBox.put('userEmail', decodedToken['email']);
    await authBox.put('userRole', decodedToken['role']);

    print("ROLE SAVED: ${decodedToken['role']}");
  }


  void userLogin({required String email, required String password}) async {
    emit(LoginLoadingState());
    try {
      final response = await DioHelper.postData(
        url: ApiConstants.login,
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var authBox = Hive.box('authBox');

        String accessToken = response.data['data']['access_token'];
        String refreshToken = response.data['data']['refresh_token'];

        await authBox.put('accessToken', accessToken);
        await authBox.put('refreshToken', refreshToken);

        var userData = response.data['data']['user'];
        await authBox.put('userId', userData['id']);
        await authBox.put('firstName', userData['firstName']);
        await authBox.put('lastName', userData['lastName']);
        await authBox.put('email', userData['email']);
        await authBox.put('phone', userData['phone']);
        await authBox.put('gender', userData['gender']);
        await authBox.put('dateOfBirth', userData['dateOfBirth']);
        await authBox.put('profileImage', userData['profileImage']);
        await authBox.put('userRole', userData['role']);

        emit(LoginSuccessState(response.data));
      }
    } catch (error) {
      emit(LoginErrorState(_handleDioError(error)));
    }
  }

  Future<void> checkLoggedInUser() async {
    final authBox = Hive.box('authBox');
    final token = authBox.get('accessToken');

    if (token != null && token.isNotEmpty) {
      emit(LoginSuccessState({}));
    } else {
      emit(AuthInitial());
    }
  }

  void requestPasswordReset({required String email}) {
    emit(RequestResetLoadingState());

    DioHelper.postData(
      url: ApiConstants.requestPasswordReset,
      data: {"email": email},
    ).then((value) {
      print(value.data);
      emit(RequestResetSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(RequestResetErrorState(_handleDioError(error)));
    });
  }

  void resetPassword({
    required String email,
    required String newPassword,
    required String code,
  }) {
    emit(ResetPasswordLoadingState());
    DioHelper.postData(
      url: ApiConstants.resetPassword,
      data: {
        "email": email,
        "otp": code,
        "newPassword": newPassword,
      },
    ).then((value) {
      print(value.data);
      emit(ResetPasswordSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ResetPasswordErrorState(_handleDioError(error)));
    });
  }

  void verifyResetCode({
    required String email,
    required String code,
  }) {
    emit(VerifyCodeLoadingState());

    DioHelper.postData(
      url: ApiConstants.verifyResetCode,
      data: {
        "email": email,
        "otp": code,
      },
    ).then((value) {
      print(value.data);
      emit(VerifyCodeSuccessState(value.data));
    }).catchError((error) {
      print(error.toString());
      emit(VerifyCodeErrorState(_handleDioError(error)));
    });
  }

  Future<void> userLogout() async {
    emit(LogoutLoadingState());

    try {
      final authBox = Hive.box('authBox');
      final String? token = authBox.get('accessToken');


      await DioHelper.dio.post(
        ApiConstants.logOut,
        data: {},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      await authBox.clear();

      emit(AuthInitial());
      emit(LogoutSuccessState());
    } catch (error) {
      await Hive.box('authBox').clear();
      emit(LogoutSuccessState());
    }
  }


  void registerDoctor({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phone,
    required String gender,
    required String dateOfBirth,
    required String specialization,
    required String bio,
    required String practicalExperience,
    required double latitude,
    required double longitude,
  }) async {
    emit(RegisterLoadingState());

    try {
      FormData formData = FormData.fromMap({
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
        "phone": phone,
        "gender": gender.toUpperCase(),
        "dateOfBirth": dateOfBirth,
        "role": "DOCTOR",
        "specialization": specialization,
        "bio": bio,
        "practicalExperience": practicalExperience,
        "latitude": latitude.toString(),
        "longitude": longitude.toString(),


        if (syndicateCardPath != null)
          "syndicateCard": await MultipartFile.fromFile(
            syndicateCardPath!,
            filename: 'syndicate_card.jpg',
          ),


      });

      await DioHelper.dio.post(
        ApiConstants.register,
        data: formData,
      );

      emit(RegisterSuccessState());
    } catch (error) {
      emit(RegisterErrorState(_handleDioError(error)));
    }
  }

  void verifyEmail({
    required String email,
    required String code,
  }) {
    emit(VerifyEmailLoadingState());

    DioHelper.postData(
      url: ApiConstants.verifyEmail,
      data: {
        "email": email,
        "code": code,
      },
    ).then((value) {
      emit(VerifyEmailSuccessState());
    }).catchError((error) {
      emit(VerifyEmailErrorState(_handleDioError(error)));
    });
  }


}
