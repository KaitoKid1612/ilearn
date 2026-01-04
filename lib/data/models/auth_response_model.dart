import 'package:json_annotation/json_annotation.dart';
import 'package:ilearn/data/models/user_model.dart';

part 'auth_response_model.g.dart';

@JsonSerializable()
class AuthResponseModel {
  final bool success;
  final int statusCode;
  final String message;
  final AuthDataModel data;
  final String timestamp;

  const AuthResponseModel({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
    required this.timestamp,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseModelToJson(this);
}

@JsonSerializable()
class AuthDataModel {
  final String accessToken;
  final String refreshToken;
  final int expiresIn;
  final String tokenType;
  final UserModel user;

  const AuthDataModel({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
    required this.tokenType,
    required this.user,
  });

  factory AuthDataModel.fromJson(Map<String, dynamic> json) =>
      _$AuthDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthDataModelToJson(this);
}
