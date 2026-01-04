import 'package:json_annotation/json_annotation.dart';
import 'package:ilearn/domain/entities/user.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserPointsModel {
  final String id;
  final String userId;
  final int totalPoints;
  final int currentStreak;
  final int longestStreak;
  final int level;
  final int experience;
  final String? lastStudyDate;
  final int hearts;
  final int maxHearts;
  final String? heartsRefillAt;
  final bool unlimitedHearts;
  final String createdAt;
  final String updatedAt;

  const UserPointsModel({
    required this.id,
    required this.userId,
    required this.totalPoints,
    required this.currentStreak,
    required this.longestStreak,
    required this.level,
    required this.experience,
    this.lastStudyDate,
    required this.hearts,
    required this.maxHearts,
    this.heartsRefillAt,
    required this.unlimitedHearts,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserPointsModel.fromJson(Map<String, dynamic> json) =>
      _$UserPointsModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserPointsModelToJson(this);

  UserPoints toEntity() {
    return UserPoints(
      id: id,
      userId: userId,
      totalPoints: totalPoints,
      currentStreak: currentStreak,
      longestStreak: longestStreak,
      level: level,
      experience: experience,
      lastStudyDate: lastStudyDate != null
          ? DateTime.parse(lastStudyDate!)
          : null,
      hearts: hearts,
      maxHearts: maxHearts,
      heartsRefillAt: heartsRefillAt != null
          ? DateTime.parse(heartsRefillAt!)
          : null,
      unlimitedHearts: unlimitedHearts,
      createdAt: DateTime.parse(createdAt),
      updatedAt: DateTime.parse(updatedAt),
    );
  }
}

@JsonSerializable()
class UserModel {
  final String id;
  final String email;
  final String username;
  final String fullName;
  final String? avatar;
  final String? bio;
  final String role;
  final String currentLevel;
  final String provider;
  final bool isVerified;
  final bool isActive;
  final String? lastLoginAt;
  final String createdAt;
  final String updatedAt;
  final UserPointsModel? points;

  const UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.fullName,
    this.avatar,
    this.bio,
    required this.role,
    required this.currentLevel,
    required this.provider,
    required this.isVerified,
    required this.isActive,
    this.lastLoginAt,
    required this.createdAt,
    required this.updatedAt,
    this.points,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  User toEntity() {
    return User(
      id: id,
      email: email,
      username: username,
      fullName: fullName,
      avatar: avatar,
      bio: bio,
      role: role,
      currentLevel: currentLevel,
      provider: provider,
      isVerified: isVerified,
      isActive: isActive,
      lastLoginAt: lastLoginAt != null ? DateTime.parse(lastLoginAt!) : null,
      createdAt: DateTime.parse(createdAt),
      updatedAt: DateTime.parse(updatedAt),
      points: points?.toEntity(),
    );
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      email: user.email,
      username: user.username,
      fullName: user.fullName,
      avatar: user.avatar,
      bio: user.bio,
      role: user.role,
      currentLevel: user.currentLevel,
      provider: user.provider,
      isVerified: user.isVerified,
      isActive: user.isActive,
      lastLoginAt: user.lastLoginAt?.toIso8601String(),
      createdAt: user.createdAt.toIso8601String(),
      updatedAt: user.updatedAt.toIso8601String(),
    );
  }
}
