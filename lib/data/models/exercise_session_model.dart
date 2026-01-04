import 'package:json_annotation/json_annotation.dart';
import 'lesson_exercise_model.dart';

part 'exercise_session_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ExerciseSessionModel {
  final String sessionId;
  final String lessonId;
  final List<LessonExerciseItemModel> exercises;
  final int? totalTimeLimit;
  final String startedAt;
  final String expiresAt;

  ExerciseSessionModel({
    required this.sessionId,
    required this.lessonId,
    required this.exercises,
    this.totalTimeLimit,
    required this.startedAt,
    required this.expiresAt,
  });

  factory ExerciseSessionModel.fromJson(Map<String, dynamic> json) =>
      _$ExerciseSessionModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseSessionModelToJson(this);
}

@JsonSerializable()
class ExerciseResultItemModel {
  final String exerciseId;
  final bool isCorrect;
  final String correctAnswer;
  final String? explanation;
  final int points;
  final int timeSpent;

  ExerciseResultItemModel({
    required this.exerciseId,
    required this.isCorrect,
    required this.correctAnswer,
    this.explanation,
    required this.points,
    required this.timeSpent,
  });

  factory ExerciseResultItemModel.fromJson(Map<String, dynamic> json) =>
      _$ExerciseResultItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseResultItemModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ExerciseSessionResultModel {
  final String sessionId;
  final List<ExerciseResultItemModel> results;
  final int correctCount;
  final int totalCount;
  final int scorePercentage;
  final int totalPoints;
  @JsonKey(defaultValue: 0)
  final int totalTimeSpent;
  final int heartsLost;
  final bool isPassed;

  ExerciseSessionResultModel({
    required this.sessionId,
    required this.results,
    required this.correctCount,
    required this.totalCount,
    required this.scorePercentage,
    required this.totalPoints,
    this.totalTimeSpent = 0,
    required this.heartsLost,
    required this.isPassed,
  });

  factory ExerciseSessionResultModel.fromJson(Map<String, dynamic> json) =>
      _$ExerciseSessionResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseSessionResultModelToJson(this);
}
