import 'package:json_annotation/json_annotation.dart';

part 'auth_model.g.dart';

// Login Request
@JsonSerializable()
class LoginRequest {
  final String email;
  final String password;

  LoginRequest({required this.email, required this.password});

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}

// Register Request
@JsonSerializable()
class RegisterRequest {
  final String email;
  final String password;
  final String name;

  RegisterRequest({
    required this.email,
    required this.password,
    required this.name,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}

// User Model
@JsonSerializable()
class UserModel {
  final String id;
  final String email;
  final String name;
  final String role;
  final String? avatar;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    this.avatar,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

// Login Response
@JsonSerializable()
class LoginResponse {
  final bool success;
  final LoginData data;

  LoginResponse({required this.success, required this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class LoginData {
  final String token;
  final UserModel user;

  LoginData({required this.token, required this.user});

  factory LoginData.fromJson(Map<String, dynamic> json) =>
      _$LoginDataFromJson(json);
  Map<String, dynamic> toJson() => _$LoginDataToJson(this);
}

// Register Response (same structure as Login)
typedef RegisterResponse = LoginResponse;
