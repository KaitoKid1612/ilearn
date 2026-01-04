// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_vocabulary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LessonVocabularyResponseModel _$LessonVocabularyResponseModelFromJson(
  Map<String, dynamic> json,
) => LessonVocabularyResponseModel(
  success: json['success'] as bool,
  statusCode: (json['statusCode'] as num).toInt(),
  message: json['message'] as String,
  data: LessonVocabularyDataModel.fromJson(
    json['data'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$LessonVocabularyResponseModelToJson(
  LessonVocabularyResponseModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'statusCode': instance.statusCode,
  'message': instance.message,
  'data': instance.data,
};

LessonVocabularyDataModel _$LessonVocabularyDataModelFromJson(
  Map<String, dynamic> json,
) => LessonVocabularyDataModel(
  lessonId: json['lessonId'] as String,
  vocabularies: (json['vocabularies'] as List<dynamic>)
      .map((e) => VocabularyItemModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  progress: json['progress'] == null
      ? null
      : VocabularyProgressModel.fromJson(
          json['progress'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$LessonVocabularyDataModelToJson(
  LessonVocabularyDataModel instance,
) => <String, dynamic>{
  'lessonId': instance.lessonId,
  'vocabularies': instance.vocabularies,
  'progress': instance.progress,
};

VocabularyItemModel _$VocabularyItemModelFromJson(Map<String, dynamic> json) =>
    VocabularyItemModel(
      id: json['id'] as String,
      word: json['word'] as String,
      reading: json['reading'] as String,
      meaning: json['meaning'] as String,
      example: json['example'] as String?,
      exampleMeaning: json['exampleMeaning'] as String?,
      audio: json['audio'] as String?,
      image: json['image'] as String?,
      isLearned: json['isLearned'] as bool,
      masteryLevel: (json['masteryLevel'] as num).toInt(),
    );

Map<String, dynamic> _$VocabularyItemModelToJson(
  VocabularyItemModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'word': instance.word,
  'reading': instance.reading,
  'meaning': instance.meaning,
  'example': instance.example,
  'exampleMeaning': instance.exampleMeaning,
  'audio': instance.audio,
  'image': instance.image,
  'isLearned': instance.isLearned,
  'masteryLevel': instance.masteryLevel,
};

VocabularyProgressModel _$VocabularyProgressModelFromJson(
  Map<String, dynamic> json,
) => VocabularyProgressModel(
  total: (json['total'] as num).toInt(),
  learned: (json['learned'] as num).toInt(),
  percentage: (json['percentage'] as num).toDouble(),
);

Map<String, dynamic> _$VocabularyProgressModelToJson(
  VocabularyProgressModel instance,
) => <String, dynamic>{
  'total': instance.total,
  'learned': instance.learned,
  'percentage': instance.percentage,
};
