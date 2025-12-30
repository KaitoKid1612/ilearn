import 'package:json_annotation/json_annotation.dart';

part 'dashboard_model.g.dart';

@JsonSerializable()
class DashboardResponseModel {
  final bool success;
  final DashboardDataModel data;

  const DashboardResponseModel({required this.success, required this.data});

  factory DashboardResponseModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardResponseModelToJson(this);
}

@JsonSerializable()
class DashboardDataModel {
  final DashboardUserModel user;
  final StatsModel stats;
  final CurrentTextbookModel? currentTextbook;
  final List<ActiveChallengeModel> activeChallenges;
  final List<RecentAchievementModel> recentAchievements;

  const DashboardDataModel({
    required this.user,
    required this.stats,
    this.currentTextbook,
    required this.activeChallenges,
    required this.recentAchievements,
  });

  factory DashboardDataModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardDataModelToJson(this);
}

@JsonSerializable()
class DashboardUserModel {
  final String id;
  final String name;
  final String email;
  final String? avatar;
  final String role;

  const DashboardUserModel({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
    required this.role,
  });

  factory DashboardUserModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardUserModelToJson(this);
}

@JsonSerializable()
class StatsModel {
  final int totalXP;
  final int gems;
  final int level;
  final int currentStreak;
  final int longestStreak;
  final String? lastCheckInDate;

  const StatsModel({
    required this.totalXP,
    required this.gems,
    required this.level,
    required this.currentStreak,
    required this.longestStreak,
    this.lastCheckInDate,
  });

  factory StatsModel.fromJson(Map<String, dynamic> json) =>
      _$StatsModelFromJson(json);

  Map<String, dynamic> toJson() => _$StatsModelToJson(this);
}

@JsonSerializable()
class CurrentTextbookModel {
  final String id;
  final String title;
  final String level;
  final String? thumbnail;
  final int progress;

  const CurrentTextbookModel({
    required this.id,
    required this.title,
    required this.level,
    this.thumbnail,
    required this.progress,
  });

  factory CurrentTextbookModel.fromJson(Map<String, dynamic> json) =>
      _$CurrentTextbookModelFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentTextbookModelToJson(this);
}

@JsonSerializable()
class ActiveChallengeModel {
  final String id;
  final String title;
  final String description;
  final String type;
  final int goal;
  final String goalType;
  final int xpReward;
  final int gemReward;
  final String endDate;
  final int progress;
  final String joinedAt;

  const ActiveChallengeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.goal,
    required this.goalType,
    required this.xpReward,
    required this.gemReward,
    required this.endDate,
    required this.progress,
    required this.joinedAt,
  });

  factory ActiveChallengeModel.fromJson(Map<String, dynamic> json) =>
      _$ActiveChallengeModelFromJson(json);

  Map<String, dynamic> toJson() => _$ActiveChallengeModelToJson(this);
}

@JsonSerializable()
class RecentAchievementModel {
  final String id;
  final String title;
  final String description;
  final String icon;
  final String category;
  final String unlockedAt;

  const RecentAchievementModel({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.category,
    required this.unlockedAt,
  });

  factory RecentAchievementModel.fromJson(Map<String, dynamic> json) =>
      _$RecentAchievementModelFromJson(json);

  Map<String, dynamic> toJson() => _$RecentAchievementModelToJson(this);
}
