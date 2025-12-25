import 'package:shared_preferences/shared_preferences.dart';
import 'package:ilearn/core/constants/app_constants.dart';
import 'package:ilearn/core/errors/exceptions.dart';
import 'package:ilearn/data/models/user_model.dart';
import 'dart:convert';

class AuthLocalDataSource {
  final SharedPreferences _prefs;

  AuthLocalDataSource(this._prefs);

  Future<void> saveToken(String token) async {
    try {
      await _prefs.setString(AppConstants.tokenKey, token);
    } catch (e) {
      throw CacheException(message: 'Không thể lưu token');
    }
  }

  Future<void> saveRefreshToken(String refreshToken) async {
    try {
      await _prefs.setString(AppConstants.refreshTokenKey, refreshToken);
    } catch (e) {
      throw CacheException(message: 'Không thể lưu refresh token');
    }
  }

  Future<void> saveUser(UserModel user) async {
    try {
      final jsonString = jsonEncode(user.toJson());
      await _prefs.setString(AppConstants.userKey, jsonString);
    } catch (e) {
      throw CacheException(message: 'Không thể lưu thông tin người dùng');
    }
  }

  String? getToken() {
    try {
      return _prefs.getString(AppConstants.tokenKey);
    } catch (e) {
      throw CacheException(message: 'Không thể lấy token');
    }
  }

  String? getRefreshToken() {
    try {
      return _prefs.getString(AppConstants.refreshTokenKey);
    } catch (e) {
      throw CacheException(message: 'Không thể lấy refresh token');
    }
  }

  UserModel? getUser() {
    try {
      final jsonString = _prefs.getString(AppConstants.userKey);
      if (jsonString != null) {
        return UserModel.fromJson(jsonDecode(jsonString));
      }
      return null;
    } catch (e) {
      throw CacheException(message: 'Không thể lấy thông tin người dùng');
    }
  }

  Future<void> clearAuthData() async {
    try {
      await _prefs.remove(AppConstants.tokenKey);
      await _prefs.remove(AppConstants.refreshTokenKey);
      await _prefs.remove(AppConstants.userKey);
    } catch (e) {
      throw CacheException(message: 'Không thể xóa dữ liệu xác thực');
    }
  }

  bool isLoggedIn() {
    final token = getToken();
    return token != null && token.isNotEmpty;
  }
}
