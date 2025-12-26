import 'package:json_annotation/json_annotation.dart';

part 'learning_stats_model.g.dart';

@JsonSerializable()
class LearningStatsModel {
  final int streakDays;
  final int todayMinutes;
  final int completedLessons;
  final int totalLessons;
  final double completionRate;
  final int totalPoints;
  final int currentLevel;

  LearningStatsModel({
    required this.streakDays,
    required this.todayMinutes,
    required this.completedLessons,
    required this.totalLessons,
    required this.completionRate,
    required this.totalPoints,
    required this.currentLevel,
  });

  factory LearningStatsModel.fromJson(Map<String, dynamic> json) =>
      _$LearningStatsModelFromJson(json);

  Map<String, dynamic> toJson() => _$LearningStatsModelToJson(this);
}

@JsonSerializable()
class CourseProgressModel {
  final String courseId;
  final String courseName;
  final String? thumbnail;
  final int completedLessons;
  final int totalLessons;
  final int progress; // 0-100
  final String? currentLessonId;
  final String? currentLessonTitle;
  final DateTime lastAccessedAt;

  CourseProgressModel({
    required this.courseId,
    required this.courseName,
    this.thumbnail,
    required this.completedLessons,
    required this.totalLessons,
    required this.progress,
    this.currentLessonId,
    this.currentLessonTitle,
    required this.lastAccessedAt,
  });

  factory CourseProgressModel.fromJson(Map<String, dynamic> json) =>
      _$CourseProgressModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseProgressModelToJson(this);
}

@JsonSerializable()
class ActivityModel {
  final String id;
  final String type; // completed_lesson, achievement, high_score
  final String title;
  final String description;
  final String? iconType; // check_circle, star, trophy
  final DateTime createdAt;

  ActivityModel({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    this.iconType,
    required this.createdAt,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityModelFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityModelToJson(this);
}
