// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExerciseSessionModel _$ExerciseSessionModelFromJson(
  Map<String, dynamic> json,
) => ExerciseSessionModel(
  sessionId: json['sessionId'] as String,
  lessonId: json['lessonId'] as String,
  exercises: (json['exercises'] as List<dynamic>)
      .map((e) => LessonExerciseItemModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalTimeLimit: (json['totalTimeLimit'] as num?)?.toInt(),
  startedAt: json['startedAt'] as String,
  expiresAt: json['expiresAt'] as String,
);

Map<String, dynamic> _$ExerciseSessionModelToJson(
  ExerciseSessionModel instance,
) => <String, dynamic>{
  'sessionId': instance.sessionId,
  'lessonId': instance.lessonId,
  'exercises': instance.exercises.map((e) => e.toJson()).toList(),
  'totalTimeLimit': instance.totalTimeLimit,
  'startedAt': instance.startedAt,
  'expiresAt': instance.expiresAt,
};

ExerciseResultItemModel _$ExerciseResultItemModelFromJson(
  Map<String, dynamic> json,
) => ExerciseResultItemModel(
  exerciseId: json['exerciseId'] as String,
  isCorrect: json['isCorrect'] as bool,
  correctAnswer: json['correctAnswer'] as String,
  explanation: json['explanation'] as String?,
  points: (json['points'] as num).toInt(),
  timeSpent: (json['timeSpent'] as num).toInt(),
);

Map<String, dynamic> _$ExerciseResultItemModelToJson(
  ExerciseResultItemModel instance,
) => <String, dynamic>{
  'exerciseId': instance.exerciseId,
  'isCorrect': instance.isCorrect,
  'correctAnswer': instance.correctAnswer,
  'explanation': instance.explanation,
  'points': instance.points,
  'timeSpent': instance.timeSpent,
};

ExerciseSessionResultModel _$ExerciseSessionResultModelFromJson(
  Map<String, dynamic> json,
) => ExerciseSessionResultModel(
  sessionId: json['sessionId'] as String,
  results: (json['results'] as List<dynamic>)
      .map((e) => ExerciseResultItemModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  correctCount: (json['correctCount'] as num).toInt(),
  totalCount: (json['totalCount'] as num).toInt(),
  scorePercentage: (json['scorePercentage'] as num).toInt(),
  totalPoints: (json['totalPoints'] as num).toInt(),
  totalTimeSpent: (json['totalTimeSpent'] as num?)?.toInt() ?? 0,
  heartsLost: (json['heartsLost'] as num).toInt(),
  isPassed: json['isPassed'] as bool,
);

Map<String, dynamic> _$ExerciseSessionResultModelToJson(
  ExerciseSessionResultModel instance,
) => <String, dynamic>{
  'sessionId': instance.sessionId,
  'results': instance.results.map((e) => e.toJson()).toList(),
  'correctCount': instance.correctCount,
  'totalCount': instance.totalCount,
  'scorePercentage': instance.scorePercentage,
  'totalPoints': instance.totalPoints,
  'totalTimeSpent': instance.totalTimeSpent,
  'heartsLost': instance.heartsLost,
  'isPassed': instance.isPassed,
};
