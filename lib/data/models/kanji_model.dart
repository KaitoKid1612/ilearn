import 'package:json_annotation/json_annotation.dart';
import 'package:ilearn/domain/entities/kanji.dart';

part 'kanji_model.g.dart';

@JsonSerializable()
class KanjiModel {
  final String id;
  final String character;
  final String meaning;
  final String? onyomi;
  final String? kunyomi;
  final int strokeCount;
  final String? strokeOrderVideo;
  final String? mnemonic;
  @JsonKey(fromJson: _examplesFromJson)
  final List<String>? examples;
  final String? image;
  final bool isLearned;
  final int writingLevel;
  final int readingLevel;

  KanjiModel({
    required this.id,
    required this.character,
    required this.meaning,
    this.onyomi,
    this.kunyomi,
    required this.strokeCount,
    this.strokeOrderVideo,
    this.mnemonic,
    this.examples,
    this.image,
    required this.isLearned,
    required this.writingLevel,
    required this.readingLevel,
  });

  static List<String>? _examplesFromJson(dynamic json) {
    if (json == null) return null;
    if (json is List) {
      try {
        return json.map((e) => e.toString()).toList();
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  factory KanjiModel.fromJson(Map<String, dynamic> json) =>
      _$KanjiModelFromJson(json);

  Map<String, dynamic> toJson() => _$KanjiModelToJson(this);

  Kanji toEntity() {
    return Kanji(
      id: id,
      character: character,
      meaning: meaning,
      onyomi: onyomi ?? '',
      kunyomi: kunyomi ?? '',
      strokeCount: strokeCount,
      strokeOrderVideo: strokeOrderVideo,
      mnemonic: mnemonic ?? '',
      examples: examples ?? [],
      image: image,
      isLearned: isLearned,
      writingLevel: writingLevel,
      readingLevel: readingLevel,
    );
  }
}

@JsonSerializable()
class KanjiProgressModel {
  final int total;
  final int learned;
  final int percentage;

  KanjiProgressModel({
    required this.total,
    required this.learned,
    required this.percentage,
  });

  factory KanjiProgressModel.fromJson(Map<String, dynamic> json) =>
      _$KanjiProgressModelFromJson(json);

  Map<String, dynamic> toJson() => _$KanjiProgressModelToJson(this);

  KanjiProgress toEntity() {
    return KanjiProgress(
      total: total,
      learned: learned,
      percentage: percentage,
    );
  }
}

@JsonSerializable()
class KanjiLessonDataModel {
  final String lessonId;
  final List<KanjiModel> kanjis;
  final KanjiProgressModel progress;

  KanjiLessonDataModel({
    required this.lessonId,
    required this.kanjis,
    required this.progress,
  });

  factory KanjiLessonDataModel.fromJson(Map<String, dynamic> json) =>
      _$KanjiLessonDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$KanjiLessonDataModelToJson(this);

  KanjiLessonData toEntity() {
    return KanjiLessonData(
      lessonId: lessonId,
      kanjis: kanjis.map((k) => k.toEntity()).toList(),
      progress: progress.toEntity(),
    );
  }
}

@JsonSerializable()
class KanjiLessonResponse {
  final bool success;
  final String message;
  final KanjiLessonDataModel data;

  KanjiLessonResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory KanjiLessonResponse.fromJson(Map<String, dynamic> json) =>
      _$KanjiLessonResponseFromJson(json);

  Map<String, dynamic> toJson() => _$KanjiLessonResponseToJson(this);
}
