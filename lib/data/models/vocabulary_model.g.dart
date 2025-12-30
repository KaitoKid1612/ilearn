// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vocabulary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VocabularyModel _$VocabularyModelFromJson(Map<String, dynamic> json) =>
    VocabularyModel(
      id: json['id'] as String,
      word: json['word'] as String,
      hiragana: json['hiragana'] as String?,
      katakana: json['katakana'] as String?,
      romaji: json['romaji'] as String?,
      meaning: json['meaning'] as String,
      level: json['level'] as String?,
      partOfSpeech: json['partOfSpeech'] as String?,
      isPublished: json['isPublished'] as bool,
      examples: (json['examples'] as List<dynamic>)
          .map(
            (e) => VocabularyExampleModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );

Map<String, dynamic> _$VocabularyModelToJson(VocabularyModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'word': instance.word,
      'hiragana': instance.hiragana,
      'katakana': instance.katakana,
      'romaji': instance.romaji,
      'meaning': instance.meaning,
      'level': instance.level,
      'partOfSpeech': instance.partOfSpeech,
      'isPublished': instance.isPublished,
      'examples': instance.examples,
    };

VocabularyExampleModel _$VocabularyExampleModelFromJson(
  Map<String, dynamic> json,
) => VocabularyExampleModel(
  id: json['id'] as String,
  example: json['example'] as String,
  translation: json['translation'] as String,
  order: (json['order'] as num).toInt(),
);

Map<String, dynamic> _$VocabularyExampleModelToJson(
  VocabularyExampleModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'example': instance.example,
  'translation': instance.translation,
  'order': instance.order,
};

VocabularyLessonModel _$VocabularyLessonModelFromJson(
  Map<String, dynamic> json,
) => VocabularyLessonModel(
  id: json['id'] as String,
  title: json['title'] as String,
  type: json['type'] as String,
);

Map<String, dynamic> _$VocabularyLessonModelToJson(
  VocabularyLessonModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'type': instance.type,
};

VocabularyLessonDataModel _$VocabularyLessonDataModelFromJson(
  Map<String, dynamic> json,
) => VocabularyLessonDataModel(
  lesson: VocabularyLessonModel.fromJson(
    json['lesson'] as Map<String, dynamic>,
  ),
  vocabulary: (json['vocabulary'] as List<dynamic>)
      .map((e) => VocabularyModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$VocabularyLessonDataModelToJson(
  VocabularyLessonDataModel instance,
) => <String, dynamic>{
  'lesson': instance.lesson,
  'vocabulary': instance.vocabulary,
};

VocabularyLessonResponse _$VocabularyLessonResponseFromJson(
  Map<String, dynamic> json,
) => VocabularyLessonResponse(
  success: json['success'] as bool,
  message: json['message'] as String,
  data: VocabularyLessonDataModel.fromJson(
    json['data'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$VocabularyLessonResponseToJson(
  VocabularyLessonResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
};
