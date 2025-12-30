import 'package:json_annotation/json_annotation.dart';
import 'package:ilearn/domain/entities/vocabulary.dart';

part 'vocabulary_model.g.dart';

@JsonSerializable()
class VocabularyModel {
  final String id;
  final String word;
  final String? hiragana;
  final String? katakana;
  final String? romaji;
  final String meaning;
  final String? level;
  final String? partOfSpeech;
  final bool isPublished;
  final List<VocabularyExampleModel> examples;

  VocabularyModel({
    required this.id,
    required this.word,
    this.hiragana,
    this.katakana,
    this.romaji,
    required this.meaning,
    this.level,
    this.partOfSpeech,
    required this.isPublished,
    required this.examples,
  });

  factory VocabularyModel.fromJson(Map<String, dynamic> json) =>
      _$VocabularyModelFromJson(json);

  Map<String, dynamic> toJson() => _$VocabularyModelToJson(this);

  Vocabulary toEntity() {
    return Vocabulary(
      id: id,
      word: word,
      hiragana: hiragana,
      katakana: katakana,
      romaji: romaji ?? '',
      meaning: meaning,
      level: level ?? '',
      partOfSpeech: partOfSpeech ?? '',
      isPublished: isPublished,
      examples: examples.map((e) => e.toEntity()).toList(),
    );
  }
}

@JsonSerializable()
class VocabularyExampleModel {
  final String id;
  final String example;
  final String translation;
  final int order;

  VocabularyExampleModel({
    required this.id,
    required this.example,
    required this.translation,
    required this.order,
  });

  factory VocabularyExampleModel.fromJson(Map<String, dynamic> json) =>
      _$VocabularyExampleModelFromJson(json);

  Map<String, dynamic> toJson() => _$VocabularyExampleModelToJson(this);

  VocabularyExample toEntity() {
    return VocabularyExample(
      id: id,
      example: example,
      translation: translation,
      order: order,
    );
  }
}

@JsonSerializable()
class VocabularyLessonModel {
  final String id;
  final String title;
  final String type;

  VocabularyLessonModel({
    required this.id,
    required this.title,
    required this.type,
  });

  factory VocabularyLessonModel.fromJson(Map<String, dynamic> json) =>
      _$VocabularyLessonModelFromJson(json);

  Map<String, dynamic> toJson() => _$VocabularyLessonModelToJson(this);

  VocabularyLesson toEntity() {
    return VocabularyLesson(id: id, title: title, type: type);
  }
}

@JsonSerializable()
class VocabularyLessonDataModel {
  final VocabularyLessonModel lesson;
  final List<VocabularyModel> vocabulary;

  VocabularyLessonDataModel({required this.lesson, required this.vocabulary});

  factory VocabularyLessonDataModel.fromJson(Map<String, dynamic> json) =>
      _$VocabularyLessonDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$VocabularyLessonDataModelToJson(this);

  VocabularyLessonData toEntity() {
    return VocabularyLessonData(
      lesson: lesson.toEntity(),
      vocabulary: vocabulary.map((v) => v.toEntity()).toList(),
    );
  }
}

@JsonSerializable()
class VocabularyLessonResponse {
  final bool success;
  final String message;
  final VocabularyLessonDataModel data;

  VocabularyLessonResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory VocabularyLessonResponse.fromJson(Map<String, dynamic> json) =>
      _$VocabularyLessonResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VocabularyLessonResponseToJson(this);
}
