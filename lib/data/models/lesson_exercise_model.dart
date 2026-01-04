import 'package:json_annotation/json_annotation.dart';

part 'lesson_exercise_model.g.dart';

/// Model cho danh sách bài tập của lesson
/// API: GET /api/v1/lessons/{lessonId}/exercises
@JsonSerializable(explicitToJson: true)
class LessonExerciseListModel {
  final String lessonId;
  @JsonKey(defaultValue: [])
  final List<LessonExerciseItemModel> exercises;
  final ExerciseProgressModel? progress;
  final CategoryCountsModel? categoryCounts;

  LessonExerciseListModel({
    required this.lessonId,
    required this.exercises,
    this.progress,
    this.categoryCounts,
  });

  factory LessonExerciseListModel.fromJson(Map<String, dynamic> json) =>
      _$LessonExerciseListModelFromJson(json);

  Map<String, dynamic> toJson() => _$LessonExerciseListModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LessonExerciseItemModel {
  final String id;
  final String type; // MULTIPLE_CHOICE, FILL_IN_BLANK, SENTENCE_BUILD
  final String question;
  @JsonKey(defaultValue: [])
  final List<ExerciseOptionModel>? options;
  final String? audio;
  final String? image;
  final int difficulty;
  final int points;
  final int? timeLimit;
  @JsonKey(defaultValue: false)
  final bool isCompleted;
  @JsonKey(defaultValue: 0)
  final int attempts;
  final String? grammarId;
  @JsonKey(defaultValue: 'general')
  final String category; // vocabulary, kanji, grammar, general
  final String? hint;

  LessonExerciseItemModel({
    required this.id,
    required this.type,
    required this.question,
    this.options,
    this.audio,
    this.image,
    required this.difficulty,
    required this.points,
    this.timeLimit,
    this.isCompleted = false,
    this.attempts = 0,
    this.grammarId,
    this.category = 'general',
    this.hint,
  });

  factory LessonExerciseItemModel.fromJson(Map<String, dynamic> json) =>
      _$LessonExerciseItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$LessonExerciseItemModelToJson(this);
}

@JsonSerializable()
class ExerciseOptionModel {
  final String id;
  final String text;

  ExerciseOptionModel({required this.id, required this.text});

  factory ExerciseOptionModel.fromJson(Map<String, dynamic> json) =>
      _$ExerciseOptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseOptionModelToJson(this);
}

@JsonSerializable()
class ExerciseProgressModel {
  final int total;
  final int completed;
  final int percentage;

  ExerciseProgressModel({
    required this.total,
    required this.completed,
    required this.percentage,
  });

  factory ExerciseProgressModel.fromJson(Map<String, dynamic> json) =>
      _$ExerciseProgressModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseProgressModelToJson(this);
}

@JsonSerializable()
class CategoryCountsModel {
  final int vocabulary;
  final int kanji;
  final int grammar;
  final int general;

  CategoryCountsModel({
    required this.vocabulary,
    required this.kanji,
    required this.grammar,
    required this.general,
  });

  factory CategoryCountsModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryCountsModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryCountsModelToJson(this);
}
