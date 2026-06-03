import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/network/dio.dart';
import '../../../../../core/network/api_constants.dart';
import 'doctor_review_model.dart';
import 'doctor_reviews_state.dart';

class DoctorReviewsCubit extends Cubit<DoctorReviewsState> {
  DoctorReviewsCubit() : super(DoctorReviewsInitial());

  static DoctorReviewsCubit get(context) => BlocProvider.of(context);

  Future<void> getDoctorReviews() async {
    emit(DoctorReviewsLoading());

    try {
      final response = await DioHelper.fetchData(
        url: ApiConstants.doctorReviews,
      );

      final reviewsData = DoctorReviewModel.fromJson(response.data);
      emit(DoctorReviewsLoaded(reviewsData));
    } catch (e) {
      emit(DoctorReviewsError(_mapErrorMessage(e)));
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

    return "حدث خطأ أثناء تحميل التقييمات";
  }
}
