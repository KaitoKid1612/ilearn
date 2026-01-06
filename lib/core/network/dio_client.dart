import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ilearn/core/constants/app_constants.dart';

class DioClient {
  late final Dio _dio;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: dotenv.env['BASE_URL'] ?? AppConstants.baseUrl,
        connectTimeout: AppConstants.connectTimeout,
        receiveTimeout: AppConstants.receiveTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(AuthInterceptor());
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
      ),
    );
  }

  Dio get dio => _dio;

  // GET
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      rethrow;
    }
  }

  // POST
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      rethrow;
    }
  }

  // PUT
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      rethrow;
    }
  }

  // DELETE
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      rethrow;
    }
  }

  // PATCH
  Future<Response> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      rethrow;
    }
  }
}

class AuthInterceptor extends Interceptor {
  final Dio _dio = Dio();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(AppConstants.tokenKey);

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      print('🔐 Access token expired, attempting silent refresh...');

      // Try to refresh token silently
      final refreshed = await _refreshToken();

      if (refreshed) {
        // Refresh thành công → Retry request với token mới
        try {
          final prefs = await SharedPreferences.getInstance();
          final newToken = prefs.getString(AppConstants.tokenKey);

          final opts = Options(
            method: err.requestOptions.method,
            headers: {
              ...err.requestOptions.headers,
              'Authorization': 'Bearer $newToken',
            },
          );

          final clonedRequest = await _dio.request(
            err.requestOptions.path,
            options: opts,
            data: err.requestOptions.data,
            queryParameters: err.requestOptions.queryParameters,
          );

          print('✅ Request retried successfully with new token');
          return handler.resolve(clonedRequest);
        } catch (e) {
          print('❌ Retry request failed: $e');
          return handler.reject(err);
        }
      } else {
        // Refresh token CŨNG hết hạn → Clear data và logout
        print('❌ Refresh token expired, forcing logout...');
        await _clearAuthData();
        return handler.reject(
          DioException(
            requestOptions: err.requestOptions,
            error: 'Session expired. Please login again.',
            type: DioExceptionType.badResponse,
            response: err.response,
          ),
        );
      }
    }

    // Các lỗi khác → Báo bình thường
    super.onError(err, handler);
  }

  Future<bool> _refreshToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final refreshToken = prefs.getString(AppConstants.refreshTokenKey);

      if (refreshToken == null) return false;

      // Call refresh token API
      final baseUrl = dotenv.env['BASE_URL'] ?? AppConstants.baseUrl;
      final response = await _dio.post(
        '$baseUrl/api/v1/auth/refresh',
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final data = response.data['data'];
        final newAccessToken = data['accessToken'] ?? data['token'];
        final newRefreshToken = data['refreshToken'];

        // Save new tokens
        if (newAccessToken != null) {
          await prefs.setString(AppConstants.tokenKey, newAccessToken);
        }
        if (newRefreshToken != null) {
          await prefs.setString(AppConstants.refreshTokenKey, newRefreshToken);
        }

        print('✅ Token refreshed successfully');
        return true;
      }

      return false;
    } catch (e) {
      print('❌ Refresh token failed: $e');
      return false;
    }
  }

  Future<void> _clearAuthData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(AppConstants.tokenKey);
      await prefs.remove(AppConstants.refreshTokenKey);
      await prefs.remove(AppConstants.userKey);
      print('🔒 Auth data cleared - user logged out');
    } catch (e) {
      print('❌ Failed to clear auth data: $e');
    }
  }
}
