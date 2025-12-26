// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learning_stats_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LearningStatsModel _$LearningStatsModelFromJson(Map<String, dynamic> json) =>
    LearningStatsModel(
      streakDays: (json['streakDays'] as num).toInt(),
      todayMinutes: (json['todayMinutes'] as num).toInt(),
      completedLessons: (json['completedLessons'] as num).toInt(),
      totalLessons: (json['totalLessons'] as num).toInt(),
      completionRate: (json['completionRate'] as num).toDouble(),
      totalPoints: (json['totalPoints'] as num).toInt(),
      currentLevel: (json['currentLevel'] as num).toInt(),
    );

Map<String, dynamic> _$LearningStatsModelToJson(LearningStatsModel instance) =>
    <String, dynamic>{
      'streakDays': instance.streakDays,
      'todayMinutes': instance.todayMinutes,
      'completedLessons': instance.completedLessons,
      'totalLessons': instance.totalLessons,
      'completionRate': instance.completionRate,
      'totalPoints': instance.totalPoints,
      'currentLevel': instance.currentLevel,
    };

CourseProgressModel _$CourseProgressModelFromJson(Map<String, dynamic> json) =>
    CourseProgressModel(
      courseId: json['courseId'] as String,
      courseName: json['courseName'] as String,
      thumbnail: json['thumbnail'] as String?,
      completedLessons: (json['completedLessons'] as num).toInt(),
      totalLessons: (json['totalLessons'] as num).toInt(),
      progress: (json['progress'] as num).toInt(),
      currentLessonId: json['currentLessonId'] as String?,
      currentLessonTitle: json['currentLessonTitle'] as String?,
      lastAccessedAt: DateTime.parse(json['lastAccessedAt'] as String),
    );

Map<String, dynamic> _$CourseProgressModelToJson(
  CourseProgressModel instance,
) => <String, dynamic>{
  'courseId': instance.courseId,
  'courseName': instance.courseName,
  'thumbnail': instance.thumbnail,
  'completedLessons': instance.completedLessons,
  'totalLessons': instance.totalLessons,
  'progress': instance.progress,
  'currentLessonId': instance.currentLessonId,
  'currentLessonTitle': instance.currentLessonTitle,
  'lastAccessedAt': instance.lastAccessedAt.toIso8601String(),
};

ActivityModel _$ActivityModelFromJson(Map<String, dynamic> json) =>
    ActivityModel(
      id: json['id'] as String,
      type: json['type'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      iconType: json['iconType'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$ActivityModelToJson(ActivityModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'title': instance.title,
      'description': instance.description,
      'iconType': instance.iconType,
      'createdAt': instance.createdAt.toIso8601String(),
    };
