// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPointsModel _$UserPointsModelFromJson(Map<String, dynamic> json) =>
    UserPointsModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      totalPoints: (json['totalPoints'] as num).toInt(),
      currentStreak: (json['currentStreak'] as num).toInt(),
      longestStreak: (json['longestStreak'] as num).toInt(),
      level: (json['level'] as num).toInt(),
      experience: (json['experience'] as num).toInt(),
      lastStudyDate: json['lastStudyDate'] as String?,
      hearts: (json['hearts'] as num).toInt(),
      maxHearts: (json['maxHearts'] as num).toInt(),
      heartsRefillAt: json['heartsRefillAt'] as String?,
      unlimitedHearts: json['unlimitedHearts'] as bool,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$UserPointsModelToJson(UserPointsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'totalPoints': instance.totalPoints,
      'currentStreak': instance.currentStreak,
      'longestStreak': instance.longestStreak,
      'level': instance.level,
      'experience': instance.experience,
      'lastStudyDate': instance.lastStudyDate,
      'hearts': instance.hearts,
      'maxHearts': instance.maxHearts,
      'heartsRefillAt': instance.heartsRefillAt,
      'unlimitedHearts': instance.unlimitedHearts,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: json['id'] as String,
  email: json['email'] as String,
  username: json['username'] as String,
  fullName: json['fullName'] as String,
  avatar: json['avatar'] as String?,
  bio: json['bio'] as String?,
  role: json['role'] as String,
  currentLevel: json['currentLevel'] as String,
  provider: json['provider'] as String,
  isVerified: json['isVerified'] as bool,
  isActive: json['isActive'] as bool,
  lastLoginAt: json['lastLoginAt'] as String?,
  createdAt: json['createdAt'] as String,
  updatedAt: json['updatedAt'] as String,
  points: json['points'] == null
      ? null
      : UserPointsModel.fromJson(json['points'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'username': instance.username,
  'fullName': instance.fullName,
  'avatar': instance.avatar,
  'bio': instance.bio,
  'role': instance.role,
  'currentLevel': instance.currentLevel,
  'provider': instance.provider,
  'isVerified': instance.isVerified,
  'isActive': instance.isActive,
  'lastLoginAt': instance.lastLoginAt,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
  'points': instance.points,
};
