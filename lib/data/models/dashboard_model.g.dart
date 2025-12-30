// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardResponseModel _$DashboardResponseModelFromJson(
  Map<String, dynamic> json,
) => DashboardResponseModel(
  success: json['success'] as bool,
  data: DashboardDataModel.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$DashboardResponseModelToJson(
  DashboardResponseModel instance,
) => <String, dynamic>{'success': instance.success, 'data': instance.data};

DashboardDataModel _$DashboardDataModelFromJson(Map<String, dynamic> json) =>
    DashboardDataModel(
      user: DashboardUserModel.fromJson(json['user'] as Map<String, dynamic>),
      stats: StatsModel.fromJson(json['stats'] as Map<String, dynamic>),
      currentTextbook: json['currentTextbook'] == null
          ? null
          : CurrentTextbookModel.fromJson(
              json['currentTextbook'] as Map<String, dynamic>,
            ),
      activeChallenges: (json['activeChallenges'] as List<dynamic>)
          .map((e) => ActiveChallengeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      recentAchievements: (json['recentAchievements'] as List<dynamic>)
          .map(
            (e) => RecentAchievementModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );

Map<String, dynamic> _$DashboardDataModelToJson(DashboardDataModel instance) =>
    <String, dynamic>{
      'user': instance.user,
      'stats': instance.stats,
      'currentTextbook': instance.currentTextbook,
      'activeChallenges': instance.activeChallenges,
      'recentAchievements': instance.recentAchievements,
    };

DashboardUserModel _$DashboardUserModelFromJson(Map<String, dynamic> json) =>
    DashboardUserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      avatar: json['avatar'] as String?,
      role: json['role'] as String,
    );

Map<String, dynamic> _$DashboardUserModelToJson(DashboardUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'avatar': instance.avatar,
      'role': instance.role,
    };

StatsModel _$StatsModelFromJson(Map<String, dynamic> json) => StatsModel(
  totalXP: (json['totalXP'] as num).toInt(),
  gems: (json['gems'] as num).toInt(),
  level: (json['level'] as num).toInt(),
  currentStreak: (json['currentStreak'] as num).toInt(),
  longestStreak: (json['longestStreak'] as num).toInt(),
  lastCheckInDate: json['lastCheckInDate'] as String?,
);

Map<String, dynamic> _$StatsModelToJson(StatsModel instance) =>
    <String, dynamic>{
      'totalXP': instance.totalXP,
      'gems': instance.gems,
      'level': instance.level,
      'currentStreak': instance.currentStreak,
      'longestStreak': instance.longestStreak,
      'lastCheckInDate': instance.lastCheckInDate,
    };

CurrentTextbookModel _$CurrentTextbookModelFromJson(
  Map<String, dynamic> json,
) => CurrentTextbookModel(
  id: json['id'] as String,
  title: json['title'] as String,
  level: json['level'] as String,
  thumbnail: json['thumbnail'] as String?,
  progress: (json['progress'] as num).toInt(),
);

Map<String, dynamic> _$CurrentTextbookModelToJson(
  CurrentTextbookModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'level': instance.level,
  'thumbnail': instance.thumbnail,
  'progress': instance.progress,
};

ActiveChallengeModel _$ActiveChallengeModelFromJson(
  Map<String, dynamic> json,
) => ActiveChallengeModel(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  type: json['type'] as String,
  goal: (json['goal'] as num).toInt(),
  goalType: json['goalType'] as String,
  xpReward: (json['xpReward'] as num).toInt(),
  gemReward: (json['gemReward'] as num).toInt(),
  endDate: json['endDate'] as String,
  progress: (json['progress'] as num).toInt(),
  joinedAt: json['joinedAt'] as String,
);

Map<String, dynamic> _$ActiveChallengeModelToJson(
  ActiveChallengeModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'type': instance.type,
  'goal': instance.goal,
  'goalType': instance.goalType,
  'xpReward': instance.xpReward,
  'gemReward': instance.gemReward,
  'endDate': instance.endDate,
  'progress': instance.progress,
  'joinedAt': instance.joinedAt,
};

RecentAchievementModel _$RecentAchievementModelFromJson(
  Map<String, dynamic> json,
) => RecentAchievementModel(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  icon: json['icon'] as String,
  category: json['category'] as String,
  unlockedAt: json['unlockedAt'] as String,
);

Map<String, dynamic> _$RecentAchievementModelToJson(
  RecentAchievementModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'icon': instance.icon,
  'category': instance.category,
  'unlockedAt': instance.unlockedAt,
};
