import 'package:dio/dio.dart';
import 'package:ilearn/core/constants/api_endpoints.dart';
import 'package:ilearn/core/errors/exceptions.dart';
import 'package:ilearn/core/network/dio_client.dart';
import 'package:ilearn/data/models/auth_response_model.dart';
import 'package:ilearn/data/models/login_request_model.dart';
import 'package:ilearn/data/models/register_request_model.dart';

class AuthRemoteDataSource {
  final DioClient _dioClient;

  AuthRemoteDataSource(this._dioClient);

  Future<AuthResponseModel> login(LoginRequestModel request) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoints.login,
        data: request.toJson(),
      );

      return AuthResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw UnauthorizedException(message: 'Email hoặc mật khẩu không đúng');
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException();
      } else {
        throw ServerException(
          message: e.response?.data['message'] ?? 'Đã xảy ra lỗi',
          statusCode: e.response?.statusCode,
        );
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<AuthResponseModel> register(RegisterRequestModel request) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoints.register,
        data: request.toJson(),
      );

      return AuthResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 422) {
        throw ValidationException(
          message: e.response?.data['message'] ?? 'Dữ liệu không hợp lệ',
        );
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException();
      } else {
        throw ServerException(
          message: e.response?.data['message'] ?? 'Đã xảy ra lỗi',
          statusCode: e.response?.statusCode,
        );
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<void> logout() async {
    try {
      await _dioClient.post(ApiEndpoints.logout);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Đã xảy ra lỗi',
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      await _dioClient.post(
        ApiEndpoints.forgotPassword,
        data: {'email': email},
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw NotFoundException(message: 'Email không tồn tại');
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException();
      } else {
        throw ServerException(
          message: e.response?.data['message'] ?? 'Đã xảy ra lỗi',
          statusCode: e.response?.statusCode,
        );
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<void> resetPassword({
    required String token,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      await _dioClient.post(
        ApiEndpoints.resetPassword,
        data: {
          'token': token,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
        },
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 422) {
        throw ValidationException(
          message: e.response?.data['message'] ?? 'Dữ liệu không hợp lệ',
        );
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException();
      } else {
        throw ServerException(
          message: e.response?.data['message'] ?? 'Đã xảy ra lỗi',
          statusCode: e.response?.statusCode,
        );
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
