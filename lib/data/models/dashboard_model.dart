import 'package:json_annotation/json_annotation.dart';

part 'dashboard_model.g.dart';

// Main Dashboard Response - matches backend structure
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class DashboardResponseModel {
  final DashboardUserModel user;
  final CurrentPathModel currentPath;
  final List<UnitModel> units;
  final int overallProgress;

  const DashboardResponseModel({
    required this.user,
    required this.currentPath,
    required this.units,
    required this.overallProgress,
  });

  factory DashboardResponseModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardResponseModelToJson(this);
}

// User info in Dashboard
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class DashboardUserModel {
  final String id;
  final String fullName;
  final String currentLevel;
  final int totalPoints;
  final int currentStreak;
  final int longestStreak;
  final int level;
  final int experience;
  final String? avatar;

  const DashboardUserModel({
    required this.id,
    required this.fullName,
    required this.currentLevel,
    required this.totalPoints,
    required this.currentStreak,
    required this.longestStreak,
    required this.level,
    required this.experience,
    this.avatar,
  });

  factory DashboardUserModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardUserModelToJson(this);
}

// Current Path (Learning Path/Roadmap)
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class CurrentPathModel {
  final String id;
  final String level;
  final String title;
  final String description;

  const CurrentPathModel({
    required this.id,
    required this.level,
    required this.title,
    required this.description,
  });

  factory CurrentPathModel.fromJson(Map<String, dynamic> json) =>
      _$CurrentPathModelFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentPathModelToJson(this);
}

// Unit in the learning path
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class UnitModel {
  final String id;
  final String title;
  final String description;
  final int order;
  final bool isLocked;
  final bool isCompleted;
  final int progress;
  final List<LessonModel> lessons;

  const UnitModel({
    required this.id,
    required this.title,
    required this.description,
    required this.order,
    required this.isLocked,
    required this.isCompleted,
    required this.progress,
    required this.lessons,
  });

  factory UnitModel.fromJson(Map<String, dynamic> json) =>
      _$UnitModelFromJson(json);

  Map<String, dynamic> toJson() => _$UnitModelToJson(this);
}

// Lesson with detailed progress
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LessonModel {
  final String id;
  final String title;
  final String description;
  final int order;
  final bool isLocked;
  final bool isCompleted;
  final bool isCurrent;
  final int overallProgress;
  final LessonProgressModel progress;

  const LessonModel({
    required this.id,
    required this.title,
    required this.description,
    required this.order,
    required this.isLocked,
    required this.isCompleted,
    required this.isCurrent,
    required this.overallProgress,
    required this.progress,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) =>
      _$LessonModelFromJson(json);

  Map<String, dynamic> toJson() => _$LessonModelToJson(this);
}

// Detailed progress for each lesson component
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LessonProgressModel {
  final ProgressDetailModel vocabulary;
  final ProgressDetailModel grammar;
  final ProgressDetailModel kanji;
  final ProgressDetailModel exercises;

  const LessonProgressModel({
    required this.vocabulary,
    required this.grammar,
    required this.kanji,
    required this.exercises,
  });

  factory LessonProgressModel.fromJson(Map<String, dynamic> json) =>
      _$LessonProgressModelFromJson(json);

  Map<String, dynamic> toJson() => _$LessonProgressModelToJson(this);
}

// Progress detail for each component (vocabulary, grammar, kanji, exercises)
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ProgressDetailModel {
  final int total;
  final int completed;
  final int percentage;

  const ProgressDetailModel({
    required this.total,
    required this.completed,
    required this.percentage,
  });

  factory ProgressDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ProgressDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProgressDetailModelToJson(this);
}

// Recent Achievement Model
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RecentAchievementModel {
  final String id;
  final String title;
  final String description;
  final String icon;
  final String earnedAt;

  const RecentAchievementModel({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.earnedAt,
  });

  factory RecentAchievementModel.fromJson(Map<String, dynamic> json) =>
      _$RecentAchievementModelFromJson(json);

  Map<String, dynamic> toJson() => _$RecentAchievementModelToJson(this);
}

// Active Challenge Model
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ActiveChallengeModel {
  final String id;
  final String title;
  final String description;
  final int goal;
  final int progress;
  final String deadline;
  final int xpReward;
  final int gemReward;

  const ActiveChallengeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.goal,
    required this.progress,
    required this.deadline,
    required this.xpReward,
    required this.gemReward,
  });

  factory ActiveChallengeModel.fromJson(Map<String, dynamic> json) =>
      _$ActiveChallengeModelFromJson(json);

  Map<String, dynamic> toJson() => _$ActiveChallengeModelToJson(this);
}

// Current Textbook Model
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class CurrentTextbookModel {
  final String id;
  final String title;
  final String level;
  final int progress;
  final int totalLessons;
  final int completedLessons;

  const CurrentTextbookModel({
    required this.id,
    required this.title,
    required this.level,
    required this.progress,
    required this.totalLessons,
    required this.completedLessons,
  });

  factory CurrentTextbookModel.fromJson(Map<String, dynamic> json) =>
      _$CurrentTextbookModelFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentTextbookModelToJson(this);
}

// Stats Model
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class StatsModel {
  final int totalXP;
  final int gems;
  final int level;
  final int currentStreak;

  const StatsModel({
    required this.totalXP,
    required this.gems,
    required this.level,
    required this.currentStreak,
  });

  factory StatsModel.fromJson(Map<String, dynamic> json) =>
      _$StatsModelFromJson(json);

  Map<String, dynamic> toJson() => _$StatsModelToJson(this);
}
