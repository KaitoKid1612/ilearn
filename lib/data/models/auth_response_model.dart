import 'package:json_annotation/json_annotation.dart';
import 'package:ilearn/data/models/user_model.dart';

part 'auth_response_model.g.dart';

@JsonSerializable()
class AuthResponseModel {
  final bool success;
  final String message;
  final AuthDataModel data;

  const AuthResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseModelToJson(this);
}

@JsonSerializable()
class AuthDataModel {
  final UserModel user;
  final String accessToken;
  final String refreshToken;

  const AuthDataModel({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
  });

  factory AuthDataModel.fromJson(Map<String, dynamic> json) =>
      _$AuthDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthDataModelToJson(this);
}
