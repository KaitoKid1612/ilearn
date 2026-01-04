// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_exercise_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LessonExerciseListModel _$LessonExerciseListModelFromJson(
  Map<String, dynamic> json,
) => LessonExerciseListModel(
  lessonId: json['lessonId'] as String,
  exercises:
      (json['exercises'] as List<dynamic>?)
          ?.map(
            (e) => LessonExerciseItemModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      [],
  progress: json['progress'] == null
      ? null
      : ExerciseProgressModel.fromJson(
          json['progress'] as Map<String, dynamic>,
        ),
  categoryCounts: json['categoryCounts'] == null
      ? null
      : CategoryCountsModel.fromJson(
          json['categoryCounts'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$LessonExerciseListModelToJson(
  LessonExerciseListModel instance,
) => <String, dynamic>{
  'lessonId': instance.lessonId,
  'exercises': instance.exercises.map((e) => e.toJson()).toList(),
  'progress': instance.progress?.toJson(),
  'categoryCounts': instance.categoryCounts?.toJson(),
};

LessonExerciseItemModel _$LessonExerciseItemModelFromJson(
  Map<String, dynamic> json,
) => LessonExerciseItemModel(
  id: json['id'] as String,
  type: json['type'] as String,
  question: json['question'] as String,
  options:
      (json['options'] as List<dynamic>?)
          ?.map((e) => ExerciseOptionModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  audio: json['audio'] as String?,
  image: json['image'] as String?,
  difficulty: (json['difficulty'] as num).toInt(),
  points: (json['points'] as num).toInt(),
  timeLimit: (json['timeLimit'] as num?)?.toInt(),
  isCompleted: json['isCompleted'] as bool? ?? false,
  attempts: (json['attempts'] as num?)?.toInt() ?? 0,
  grammarId: json['grammarId'] as String?,
  category: json['category'] as String? ?? 'general',
  hint: json['hint'] as String?,
);

Map<String, dynamic> _$LessonExerciseItemModelToJson(
  LessonExerciseItemModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'question': instance.question,
  'options': instance.options?.map((e) => e.toJson()).toList(),
  'audio': instance.audio,
  'image': instance.image,
  'difficulty': instance.difficulty,
  'points': instance.points,
  'timeLimit': instance.timeLimit,
  'isCompleted': instance.isCompleted,
  'attempts': instance.attempts,
  'grammarId': instance.grammarId,
  'category': instance.category,
  'hint': instance.hint,
};

ExerciseOptionModel _$ExerciseOptionModelFromJson(Map<String, dynamic> json) =>
    ExerciseOptionModel(id: json['id'] as String, text: json['text'] as String);

Map<String, dynamic> _$ExerciseOptionModelToJson(
  ExerciseOptionModel instance,
) => <String, dynamic>{'id': instance.id, 'text': instance.text};

ExerciseProgressModel _$ExerciseProgressModelFromJson(
  Map<String, dynamic> json,
) => ExerciseProgressModel(
  total: (json['total'] as num).toInt(),
  completed: (json['completed'] as num).toInt(),
  percentage: (json['percentage'] as num).toInt(),
);

Map<String, dynamic> _$ExerciseProgressModelToJson(
  ExerciseProgressModel instance,
) => <String, dynamic>{
  'total': instance.total,
  'completed': instance.completed,
  'percentage': instance.percentage,
};

CategoryCountsModel _$CategoryCountsModelFromJson(Map<String, dynamic> json) =>
    CategoryCountsModel(
      vocabulary: (json['vocabulary'] as num).toInt(),
      kanji: (json['kanji'] as num).toInt(),
      grammar: (json['grammar'] as num).toInt(),
      general: (json['general'] as num).toInt(),
    );

Map<String, dynamic> _$CategoryCountsModelToJson(
  CategoryCountsModel instance,
) => <String, dynamic>{
  'vocabulary': instance.vocabulary,
  'kanji': instance.kanji,
  'grammar': instance.grammar,
  'general': instance.general,
};
