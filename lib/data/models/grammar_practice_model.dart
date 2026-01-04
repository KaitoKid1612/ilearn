import 'package:json_annotation/json_annotation.dart';

part 'grammar_practice_model.g.dart';

/// Grammar Practice Exercise Types
enum ExerciseType {
  @JsonValue('FILL_BLANK')
  FILL_BLANK,
  @JsonValue('MULTIPLE_CHOICE')
  MULTIPLE_CHOICE,
  @JsonValue('SENTENCE_BUILD')
  SENTENCE_BUILD,
  @JsonValue('TRANSFORM')
  TRANSFORM,
}

/// 📝 CREATE GRAMMAR PRACTICE RESPONSE
/// API: POST /api/v1/grammar-practice/grammar/:grammarId
@JsonSerializable(explicitToJson: true)
class GrammarPracticeResponseModel {
  final bool success;
  final int statusCode;
  final String message;
  final GrammarPracticeDataModel data;

  GrammarPracticeResponseModel({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory GrammarPracticeResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GrammarPracticeResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GrammarPracticeResponseModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GrammarPracticeDataModel {
  final String exerciseId;
  final String lessonId;
  final String? lessonTitle;
  final String grammarId;
  final String? grammarTitle;
  @JsonKey(name: 'questions', defaultValue: [])
  final List<GrammarExerciseModel> exercises;
  final int totalQuestions;
  final int? totalPoints;
  final int? timeLimit;
  final String? expiresAt;

  GrammarPracticeDataModel({
    required this.exerciseId,
    required this.lessonId,
    this.lessonTitle,
    required this.grammarId,
    this.grammarTitle,
    required this.exercises,
    required this.totalQuestions,
    this.totalPoints,
    this.timeLimit,
    this.expiresAt,
  });

  factory GrammarPracticeDataModel.fromJson(Map<String, dynamic> json) =>
      _$GrammarPracticeDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$GrammarPracticeDataModelToJson(this);
}

/// 📋 GRAMMAR EXERCISE MODEL
@JsonSerializable(explicitToJson: true)
class GrammarExerciseModel {
  final String? id;
  final ExerciseType type;
  final String question;
  final dynamic options; // Can be List<String> or Map<String, String>
  final String? correctAnswer;
  final String? grammarId;
  final String? grammarTitle;
  final String? hint;
  final int? points;

  GrammarExerciseModel({
    this.id,
    required this.type,
    required this.question,
    this.options,
    this.correctAnswer,
    this.grammarId,
    this.grammarTitle,
    this.hint,
    this.points,
  });

  factory GrammarExerciseModel.fromJson(Map<String, dynamic> json) =>
      _$GrammarExerciseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GrammarExerciseModelToJson(this);

  // Helper getters for different option types
  List<String>? get optionsList {
    if (options is List) return List<String>.from(options);
    return null;
  }

  Map<String, String>? get optionsMap {
    if (options is Map) {
      return Map<String, String>.from(options);
    }
    return null;
  }

  List<String>? get wordsList {
    if (type == ExerciseType.SENTENCE_BUILD && options is List) {
      return List<String>.from(options);
    }
    return null;
  }
}

/// ✅ SUBMIT GRAMMAR PRACTICE RESPONSE
/// API: POST /api/v1/grammar-practice/:exerciseId/submit
@JsonSerializable(explicitToJson: true)
class SubmitGrammarPracticeResponseModel {
  final bool success;
  final String message;
  final String exerciseId;
  final int totalQuestions;
  final int correctAnswers;
  final int incorrectAnswers;
  final num accuracy; // Can be int or double
  final int pointsEarned;
  final int totalPoints;
  @JsonKey(defaultValue: [])
  final List<ExerciseResultModel> results;
  final UserStatsModel? userStats;

  SubmitGrammarPracticeResponseModel({
    required this.success,
    required this.message,
    required this.exerciseId,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.incorrectAnswers,
    required this.accuracy,
    required this.pointsEarned,
    required this.totalPoints,
    required this.results,
    this.userStats,
  });

  factory SubmitGrammarPracticeResponseModel.fromJson(
    Map<String, dynamic> json,
  ) => _$SubmitGrammarPracticeResponseModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SubmitGrammarPracticeResponseModelToJson(this);
}

@JsonSerializable()
class ExerciseResultModel {
  final String questionId;
  final String question;
  final String userAnswer;
  final String correctAnswer;
  final bool isCorrect;
  final int points;
  final String explanation;

  ExerciseResultModel({
    required this.questionId,
    required this.question,
    required this.userAnswer,
    required this.correctAnswer,
    required this.isCorrect,
    required this.points,
    required this.explanation,
  });

  factory ExerciseResultModel.fromJson(Map<String, dynamic> json) =>
      _$ExerciseResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseResultModelToJson(this);
}

@JsonSerializable()
class UserStatsModel {
  final int currentStreak;
  final int longestStreak;
  final int totalPoints;
  final int level;

  UserStatsModel({
    required this.currentStreak,
    required this.longestStreak,
    required this.totalPoints,
    required this.level,
  });

  factory UserStatsModel.fromJson(Map<String, dynamic> json) =>
      _$UserStatsModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserStatsModelToJson(this);
}

/// 📊 GRAMMAR PRACTICE PROGRESS
/// API: GET /api/v1/grammar-practice/lessons/:lessonId/progress
@JsonSerializable(explicitToJson: true)
class GrammarPracticeProgressResponseModel {
  final bool success;
  final int statusCode;
  final String message;
  final GrammarPracticeProgressModel? data;

  GrammarPracticeProgressResponseModel({
    required this.success,
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory GrammarPracticeProgressResponseModel.fromJson(
    Map<String, dynamic> json,
  ) => _$GrammarPracticeProgressResponseModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$GrammarPracticeProgressResponseModelToJson(this);
}

@JsonSerializable()
class GrammarPracticeProgressModel {
  final String lessonId;
  final int totalExercisesCompleted;
  final int totalScore;
  final double averageAccuracy;

  GrammarPracticeProgressModel({
    required this.lessonId,
    required this.totalExercisesCompleted,
    required this.totalScore,
    required this.averageAccuracy,
  });

  factory GrammarPracticeProgressModel.fromJson(Map<String, dynamic> json) =>
      _$GrammarPracticeProgressModelFromJson(json);

  Map<String, dynamic> toJson() => _$GrammarPracticeProgressModelToJson(this);
}
