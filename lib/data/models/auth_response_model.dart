import 'package:json_annotation/json_annotation.dart';
import 'package:ilearn/data/models/user_model.dart';

part 'auth_response_model.g.dart';

@JsonSerializable()
class AuthResponseModel {
  final String token;
  @JsonKey(name: 'refresh_token')
  final String? refreshToken;
  final UserModel user;
  @JsonKey(name: 'expires_at')
  final String? expiresAt;

  const AuthResponseModel({
    required this.token,
    this.refreshToken,
    required this.user,
    this.expiresAt,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseModelToJson(this);
}
