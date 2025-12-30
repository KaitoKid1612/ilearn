// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vocabulary_progress_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VocabularyProgressModel _$VocabularyProgressModelFromJson(
  Map<String, dynamic> json,
) => VocabularyProgressModel(
  lessonId: json['lessonId'] as String,
  totalVocabulary: (json['totalVocabulary'] as num).toInt(),
  learned: (json['learned'] as num).toInt(),
  mastered: (json['mastered'] as num).toInt(),
  reviewing: (json['reviewing'] as num).toInt(),
  notStarted: (json['notStarted'] as num).toInt(),
  progressByMode: ProgressByModeModel.fromJson(
    json['progressByMode'] as Map<String, dynamic>,
  ),
  vocabularyList: (json['vocabularyList'] as List<dynamic>)
      .map(
        (e) => VocabularyItemProgressModel.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
);

Map<String, dynamic> _$VocabularyProgressModelToJson(
  VocabularyProgressModel instance,
) => <String, dynamic>{
  'lessonId': instance.lessonId,
  'totalVocabulary': instance.totalVocabulary,
  'learned': instance.learned,
  'mastered': instance.mastered,
  'reviewing': instance.reviewing,
  'notStarted': instance.notStarted,
  'progressByMode': instance.progressByMode,
  'vocabularyList': instance.vocabularyList,
};

ProgressByModeModel _$ProgressByModeModelFromJson(Map<String, dynamic> json) =>
    ProgressByModeModel(
      learn: ModeProgressModel.fromJson(json['LEARN'] as Map<String, dynamic>),
      practice: ModeProgressModel.fromJson(
        json['PRACTICE'] as Map<String, dynamic>,
      ),
      speaking: ModeProgressModel.fromJson(
        json['SPEAKING'] as Map<String, dynamic>,
      ),
      writing: ModeProgressModel.fromJson(
        json['WRITING'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$ProgressByModeModelToJson(
  ProgressByModeModel instance,
) => <String, dynamic>{
  'LEARN': instance.learn,
  'PRACTICE': instance.practice,
  'SPEAKING': instance.speaking,
  'WRITING': instance.writing,
};

ModeProgressModel _$ModeProgressModelFromJson(Map<String, dynamic> json) =>
    ModeProgressModel(
      completed: (json['completed'] as num).toInt(),
      total: (json['total'] as num).toInt(),
      percentage: (json['percentage'] as num).toDouble(),
    );

Map<String, dynamic> _$ModeProgressModelToJson(ModeProgressModel instance) =>
    <String, dynamic>{
      'completed': instance.completed,
      'total': instance.total,
      'percentage': instance.percentage,
    };

VocabularyItemProgressModel _$VocabularyItemProgressModelFromJson(
  Map<String, dynamic> json,
) => VocabularyItemProgressModel(
  vocabularyId: json['vocabularyId'] as String,
  word: json['word'] as String,
  meaning: json['meaning'] as String,
  masteryLevel: $enumDecode(
    _$MasteryLevelEnumMap,
    json['masteryLevel'],
    unknownValue: MasteryLevel.NEW,
  ),
  correctCount: (json['correctCount'] as num).toInt(),
  totalAttempts: (json['totalAttempts'] as num).toInt(),
  correctRate: (json['correctRate'] as num).toDouble(),
  lastReviewed: json['lastReviewed'] == null
      ? null
      : DateTime.parse(json['lastReviewed'] as String),
  nextReview: json['nextReview'] == null
      ? null
      : DateTime.parse(json['nextReview'] as String),
  reviewInterval: (json['reviewInterval'] as num).toInt(),
);

Map<String, dynamic> _$VocabularyItemProgressModelToJson(
  VocabularyItemProgressModel instance,
) => <String, dynamic>{
  'vocabularyId': instance.vocabularyId,
  'word': instance.word,
  'meaning': instance.meaning,
  'masteryLevel': _$MasteryLevelEnumMap[instance.masteryLevel]!,
  'correctCount': instance.correctCount,
  'totalAttempts': instance.totalAttempts,
  'correctRate': instance.correctRate,
  'lastReviewed': instance.lastReviewed?.toIso8601String(),
  'nextReview': instance.nextReview?.toIso8601String(),
  'reviewInterval': instance.reviewInterval,
};

const _$MasteryLevelEnumMap = {
  MasteryLevel.NEW: 'NEW',
  MasteryLevel.FAMILIAR: 'FAMILIAR',
  MasteryLevel.MASTERED: 'MASTERED',
};

VocabularyProgressResponse _$VocabularyProgressResponseFromJson(
  Map<String, dynamic> json,
) => VocabularyProgressResponse(
  success: json['success'] as bool,
  message: json['message'] as String,
  data: VocabularyProgressModel.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$VocabularyProgressResponseToJson(
  VocabularyProgressResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
};
