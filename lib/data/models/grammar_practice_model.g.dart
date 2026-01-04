// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grammar_practice_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GrammarPracticeResponseModel _$GrammarPracticeResponseModelFromJson(
  Map<String, dynamic> json,
) => GrammarPracticeResponseModel(
  success: json['success'] as bool,
  statusCode: (json['statusCode'] as num).toInt(),
  message: json['message'] as String,
  data: GrammarPracticeDataModel.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$GrammarPracticeResponseModelToJson(
  GrammarPracticeResponseModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'statusCode': instance.statusCode,
  'message': instance.message,
  'data': instance.data.toJson(),
};

GrammarPracticeDataModel _$GrammarPracticeDataModelFromJson(
  Map<String, dynamic> json,
) => GrammarPracticeDataModel(
  exerciseId: json['exerciseId'] as String,
  lessonId: json['lessonId'] as String,
  lessonTitle: json['lessonTitle'] as String?,
  grammarId: json['grammarId'] as String,
  grammarTitle: json['grammarTitle'] as String?,
  exercises:
      (json['questions'] as List<dynamic>?)
          ?.map((e) => GrammarExerciseModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  totalQuestions: (json['totalQuestions'] as num).toInt(),
  totalPoints: (json['totalPoints'] as num?)?.toInt(),
  timeLimit: (json['timeLimit'] as num?)?.toInt(),
  expiresAt: json['expiresAt'] as String?,
);

Map<String, dynamic> _$GrammarPracticeDataModelToJson(
  GrammarPracticeDataModel instance,
) => <String, dynamic>{
  'exerciseId': instance.exerciseId,
  'lessonId': instance.lessonId,
  'lessonTitle': instance.lessonTitle,
  'grammarId': instance.grammarId,
  'grammarTitle': instance.grammarTitle,
  'questions': instance.exercises.map((e) => e.toJson()).toList(),
  'totalQuestions': instance.totalQuestions,
  'totalPoints': instance.totalPoints,
  'timeLimit': instance.timeLimit,
  'expiresAt': instance.expiresAt,
};

GrammarExerciseModel _$GrammarExerciseModelFromJson(
  Map<String, dynamic> json,
) => GrammarExerciseModel(
  id: json['id'] as String?,
  type: $enumDecode(_$ExerciseTypeEnumMap, json['type']),
  question: json['question'] as String,
  options: json['options'],
  correctAnswer: json['correctAnswer'] as String?,
  grammarId: json['grammarId'] as String?,
  grammarTitle: json['grammarTitle'] as String?,
  hint: json['hint'] as String?,
  points: (json['points'] as num?)?.toInt(),
);

Map<String, dynamic> _$GrammarExerciseModelToJson(
  GrammarExerciseModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': _$ExerciseTypeEnumMap[instance.type]!,
  'question': instance.question,
  'options': instance.options,
  'correctAnswer': instance.correctAnswer,
  'grammarId': instance.grammarId,
  'grammarTitle': instance.grammarTitle,
  'hint': instance.hint,
  'points': instance.points,
};

const _$ExerciseTypeEnumMap = {
  ExerciseType.FILL_BLANK: 'FILL_BLANK',
  ExerciseType.MULTIPLE_CHOICE: 'MULTIPLE_CHOICE',
  ExerciseType.SENTENCE_BUILD: 'SENTENCE_BUILD',
  ExerciseType.TRANSFORM: 'TRANSFORM',
};

SubmitGrammarPracticeResponseModel _$SubmitGrammarPracticeResponseModelFromJson(
  Map<String, dynamic> json,
) => SubmitGrammarPracticeResponseModel(
  success: json['success'] as bool,
  message: json['message'] as String,
  exerciseId: json['exerciseId'] as String,
  totalQuestions: (json['totalQuestions'] as num).toInt(),
  correctAnswers: (json['correctAnswers'] as num).toInt(),
  incorrectAnswers: (json['incorrectAnswers'] as num).toInt(),
  accuracy: json['accuracy'] as num,
  pointsEarned: (json['pointsEarned'] as num).toInt(),
  totalPoints: (json['totalPoints'] as num).toInt(),
  results:
      (json['results'] as List<dynamic>?)
          ?.map((e) => ExerciseResultModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  userStats: json['userStats'] == null
      ? null
      : UserStatsModel.fromJson(json['userStats'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SubmitGrammarPracticeResponseModelToJson(
  SubmitGrammarPracticeResponseModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'exerciseId': instance.exerciseId,
  'totalQuestions': instance.totalQuestions,
  'correctAnswers': instance.correctAnswers,
  'incorrectAnswers': instance.incorrectAnswers,
  'accuracy': instance.accuracy,
  'pointsEarned': instance.pointsEarned,
  'totalPoints': instance.totalPoints,
  'results': instance.results.map((e) => e.toJson()).toList(),
  'userStats': instance.userStats?.toJson(),
};

ExerciseResultModel _$ExerciseResultModelFromJson(Map<String, dynamic> json) =>
    ExerciseResultModel(
      questionId: json['questionId'] as String,
      question: json['question'] as String,
      userAnswer: json['userAnswer'] as String,
      correctAnswer: json['correctAnswer'] as String,
      isCorrect: json['isCorrect'] as bool,
      points: (json['points'] as num).toInt(),
      explanation: json['explanation'] as String,
    );

Map<String, dynamic> _$ExerciseResultModelToJson(
  ExerciseResultModel instance,
) => <String, dynamic>{
  'questionId': instance.questionId,
  'question': instance.question,
  'userAnswer': instance.userAnswer,
  'correctAnswer': instance.correctAnswer,
  'isCorrect': instance.isCorrect,
  'points': instance.points,
  'explanation': instance.explanation,
};

UserStatsModel _$UserStatsModelFromJson(Map<String, dynamic> json) =>
    UserStatsModel(
      currentStreak: (json['currentStreak'] as num).toInt(),
      longestStreak: (json['longestStreak'] as num).toInt(),
      totalPoints: (json['totalPoints'] as num).toInt(),
      level: (json['level'] as num).toInt(),
    );

Map<String, dynamic> _$UserStatsModelToJson(UserStatsModel instance) =>
    <String, dynamic>{
      'currentStreak': instance.currentStreak,
      'longestStreak': instance.longestStreak,
      'totalPoints': instance.totalPoints,
      'level': instance.level,
    };

GrammarPracticeProgressResponseModel
_$GrammarPracticeProgressResponseModelFromJson(Map<String, dynamic> json) =>
    GrammarPracticeProgressResponseModel(
      success: json['success'] as bool,
      statusCode: (json['statusCode'] as num).toInt(),
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : GrammarPracticeProgressModel.fromJson(
              json['data'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$GrammarPracticeProgressResponseModelToJson(
  GrammarPracticeProgressResponseModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'statusCode': instance.statusCode,
  'message': instance.message,
  'data': instance.data?.toJson(),
};

GrammarPracticeProgressModel _$GrammarPracticeProgressModelFromJson(
  Map<String, dynamic> json,
) => GrammarPracticeProgressModel(
  lessonId: json['lessonId'] as String,
  totalExercisesCompleted: (json['totalExercisesCompleted'] as num).toInt(),
  totalScore: (json['totalScore'] as num).toInt(),
  averageAccuracy: (json['averageAccuracy'] as num).toDouble(),
);

Map<String, dynamic> _$GrammarPracticeProgressModelToJson(
  GrammarPracticeProgressModel instance,
) => <String, dynamic>{
  'lessonId': instance.lessonId,
  'totalExercisesCompleted': instance.totalExercisesCompleted,
  'totalScore': instance.totalScore,
  'averageAccuracy': instance.averageAccuracy,
};
