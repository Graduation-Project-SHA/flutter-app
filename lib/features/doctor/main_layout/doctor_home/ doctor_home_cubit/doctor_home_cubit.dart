import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../../../../../core/network/api_constants.dart';
import '../../../../../core/network/dio.dart';
import '../../doctor_profile/doctor_reviews_cubit/doctor_review_model.dart';
import 'doctor_home_appointment_model.dart';
import 'doctor_home_state.dart';

class DoctorHomeCubit extends Cubit<DoctorHomeState> {
  DoctorHomeCubit() : super(DoctorHomeInitial());

  static DoctorHomeCubit get(context) => BlocProvider.of(context);

  List<DoctorHomeAppointmentModel> upcomingAppointments = [];
  List<DoctorReviewModel> reviews = [];
  double averageRating = 0.0;
  String aiSummary = '';

  Future<void> getHomeData({String status = 'PENDING'}) async {
    emit(DoctorHomeLoading());

    try {
      final results = await Future.wait([
        _fetchAppointments(status: status),
        _fetchReviews(),
      ]);

      emit(DoctorHomeLoaded(
        upcomingAppointments: upcomingAppointments,
        reviews: reviews,
        averageRating: averageRating,
        aiSummary: aiSummary,
      ));
    } catch (e) {
      emit(DoctorHomeError(_mapErrorMessage(e)));
    }
  }

  Future<void> _fetchAppointments({String status = 'PENDING'}) async {
    final response = await DioHelper.fetchData(
      url: ApiConstants.patientAppointments,
      query: {'status': status},
    );

    final rawList = response.data['data'] as List? ?? [];
    upcomingAppointments = rawList
        .map((e) => DoctorHomeAppointmentModel.fromJson(e))
        .toList();
  }

  Future<void> _fetchReviews() async {
    final authBox = Hive.box('authBox');
    final doctorProfileId = authBox.get('doctorProfileId')?.toString();

    if (doctorProfileId == null) return;

    final response = await DioHelper.fetchData(
      url: "${ApiConstants.publicDoctors}/$doctorProfileId/reviews",
    );

    final data = response.data['data'];

    final rawList = data as List? ?? [];
    reviews = rawList
        .where((e) => e is Map && e.containsKey('rating'))
        .map((e) => DoctorReviewModel.fromJson(e))
        .toList();
    final fullData = response.data;
    averageRating = (fullData['averageRating'] ?? 0).toDouble();
    aiSummary = fullData['aiSummary']?.toString() ?? '';
  }

  String _mapErrorMessage(dynamic error) {
    if (error is DioException) {
      if (error.type == DioExceptionType.connectionError ||
          error.type == DioExceptionType.connectionTimeout) {
        return 'تعذر الاتصال بالإنترنت، تأكد من الشبكة وحاول مرة أخرى';
      }
      if (error.response?.statusCode == 401) {
        return 'انتهت صلاحية تسجيل الدخول، سجل دخولك مرة أخرى';
      }
      final data = error.response?.data;
      if (data is Map && data['message'] != null) {
        final message = data['message'];
        if (message is List && message.isNotEmpty) return message.join(', ');
        return message.toString();
      }
    }
    return 'حدث خطأ غير متوقع، حاول مرة أخرى';
  }
}