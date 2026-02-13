import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'api_constants.dart';


class DioHelper {
  static late Dio dio;
  static bool isRefreshing = false;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl ,
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    dio.interceptors.add(AuthInterceptor(dio));
  }

  static Future<Map<String, dynamic>> _getAuthHeaders() async {
    final authBox = Hive.box('authBox');
    final accessToken = authBox.get('accessToken');

    if (accessToken == null) return {};

    return {
      'Authorization': 'Bearer $accessToken',
    };
  }


  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
  }) async {
    final headers = await _getAuthHeaders();
    return await dio.post(url, data: data, queryParameters: query, options: Options(headers: headers));
  }


  static Future<Response> fetchData({required String url}) async {
    final headers = await _getAuthHeaders();
    return await dio.get(url, options: Options(headers: headers));
  }
}

class AuthInterceptor extends Interceptor {
  final Dio _dio;
  AuthInterceptor(this._dio);

  Future<void> _saveNewTokens(Map<String, dynamic> data) async {
    final authBox = Hive.box('authBox');

    final accessToken = data['data']['access_token'];
    final refreshToken = data['data']['refresh_token'];

    await authBox.put('accessToken', accessToken);
    await authBox.put('refreshToken', refreshToken);
  }


  Future<String?> _performTokenRefresh(String refreshToken) async {
    try {
      final response = await _dio.post(
        ApiConstants.refreshToken,
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode == 200) {
        await _saveNewTokens(response.data);
        return response.data['data']['access_token'];
      }

      return null;
    } catch (e) {
      final authBox = Hive.box('authBox');
      await authBox.clear();
      return null;
    }
  }



  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 && !DioHelper.isRefreshing) {
      final authBox = Hive.box('authBox');
      final refreshToken = authBox.get('refreshToken');

      if (refreshToken != null) {
        try {
          DioHelper.isRefreshing = true;
          final newAccessToken = await _performTokenRefresh(refreshToken);
          DioHelper.isRefreshing = false;

          if (newAccessToken != null) {
            final requestOptions = err.requestOptions;
            requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

            final response = await _dio.fetch(requestOptions);
            return handler.resolve(response);
          }
        } catch (e) {
          DioHelper.isRefreshing = false;
          return handler.next(err);
        }
      }
    }
    return handler.next(err);
  }
}