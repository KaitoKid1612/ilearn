import 'package:json_annotation/json_annotation.dart';

part 'lesson_vocabulary_model.g.dart';

/// 📚 LESSON VOCABULARY MODEL
/// API: GET /api/v1/lessons/:lessonId/vocabulary
@JsonSerializable()
class LessonVocabularyResponseModel {
  final bool success;
  final int statusCode;
  final String message;
  final LessonVocabularyDataModel data;

  LessonVocabularyResponseModel({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory LessonVocabularyResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LessonVocabularyResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LessonVocabularyResponseModelToJson(this);
}

@JsonSerializable()
class LessonVocabularyDataModel {
  final String lessonId;
  final List<VocabularyItemModel> vocabularies;
  final VocabularyProgressModel? progress;

  LessonVocabularyDataModel({
    required this.lessonId,
    required this.vocabularies,
    this.progress,
  });

  factory LessonVocabularyDataModel.fromJson(Map<String, dynamic> json) =>
      _$LessonVocabularyDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$LessonVocabularyDataModelToJson(this);
}

@JsonSerializable()
class VocabularyItemModel {
  final String id;
  final String word;
  final String reading;
  final String meaning;
  final String? example;
  final String? exampleMeaning;
  final String? audio;
  final String? image;
  final bool isLearned;
  final int masteryLevel;

  VocabularyItemModel({
    required this.id,
    required this.word,
    required this.reading,
    required this.meaning,
    this.example,
    this.exampleMeaning,
    this.audio,
    this.image,
    required this.isLearned,
    required this.masteryLevel,
  });

  factory VocabularyItemModel.fromJson(Map<String, dynamic> json) =>
      _$VocabularyItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$VocabularyItemModelToJson(this);
}

@JsonSerializable()
class VocabularyProgressModel {
  final int total;
  final int learned;
  final double percentage;

  VocabularyProgressModel({
    required this.total,
    required this.learned,
    required this.percentage,
  });

  factory VocabularyProgressModel.fromJson(Map<String, dynamic> json) =>
      _$VocabularyProgressModelFromJson(json);

  Map<String, dynamic> toJson() => _$VocabularyProgressModelToJson(this);
}
