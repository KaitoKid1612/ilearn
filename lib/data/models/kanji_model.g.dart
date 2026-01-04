// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kanji_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KanjiModel _$KanjiModelFromJson(Map<String, dynamic> json) => KanjiModel(
  id: json['id'] as String,
  character: json['character'] as String,
  meaning: json['meaning'] as String,
  onyomi: json['onyomi'] as String?,
  kunyomi: json['kunyomi'] as String?,
  strokeCount: (json['strokeCount'] as num).toInt(),
  strokeOrderVideo: json['strokeOrderVideo'] as String?,
  mnemonic: json['mnemonic'] as String?,
  examples: KanjiModel._examplesFromJson(json['examples']),
  image: json['image'] as String?,
  isLearned: json['isLearned'] as bool,
  writingLevel: (json['writingLevel'] as num).toInt(),
  readingLevel: (json['readingLevel'] as num).toInt(),
);

Map<String, dynamic> _$KanjiModelToJson(KanjiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'character': instance.character,
      'meaning': instance.meaning,
      'onyomi': instance.onyomi,
      'kunyomi': instance.kunyomi,
      'strokeCount': instance.strokeCount,
      'strokeOrderVideo': instance.strokeOrderVideo,
      'mnemonic': instance.mnemonic,
      'examples': instance.examples,
      'image': instance.image,
      'isLearned': instance.isLearned,
      'writingLevel': instance.writingLevel,
      'readingLevel': instance.readingLevel,
    };

KanjiProgressModel _$KanjiProgressModelFromJson(Map<String, dynamic> json) =>
    KanjiProgressModel(
      total: (json['total'] as num).toInt(),
      learned: (json['learned'] as num).toInt(),
      percentage: (json['percentage'] as num).toInt(),
    );

Map<String, dynamic> _$KanjiProgressModelToJson(KanjiProgressModel instance) =>
    <String, dynamic>{
      'total': instance.total,
      'learned': instance.learned,
      'percentage': instance.percentage,
    };

KanjiLessonDataModel _$KanjiLessonDataModelFromJson(
  Map<String, dynamic> json,
) => KanjiLessonDataModel(
  lessonId: json['lessonId'] as String,
  kanjis: (json['kanjis'] as List<dynamic>)
      .map((e) => KanjiModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  progress: KanjiProgressModel.fromJson(
    json['progress'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$KanjiLessonDataModelToJson(
  KanjiLessonDataModel instance,
) => <String, dynamic>{
  'lessonId': instance.lessonId,
  'kanjis': instance.kanjis,
  'progress': instance.progress,
};

KanjiLessonResponse _$KanjiLessonResponseFromJson(Map<String, dynamic> json) =>
    KanjiLessonResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: KanjiLessonDataModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$KanjiLessonResponseToJson(
  KanjiLessonResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
};
