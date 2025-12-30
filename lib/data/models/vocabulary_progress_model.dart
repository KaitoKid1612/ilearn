import 'package:json_annotation/json_annotation.dart';
import 'package:ilearn/domain/entities/vocabulary_progress.dart';

part 'vocabulary_progress_model.g.dart';

@JsonSerializable()
class VocabularyProgressModel {
  final String lessonId;
  final int totalVocabulary;
  final int learned;
  final int mastered;
  final int reviewing;
  final int notStarted;
  final ProgressByModeModel progressByMode;
  final List<VocabularyItemProgressModel> vocabularyList;

  VocabularyProgressModel({
    required this.lessonId,
    required this.totalVocabulary,
    required this.learned,
    required this.mastered,
    required this.reviewing,
    required this.notStarted,
    required this.progressByMode,
    required this.vocabularyList,
  });

  factory VocabularyProgressModel.fromJson(Map<String, dynamic> json) =>
      _$VocabularyProgressModelFromJson(json);

  Map<String, dynamic> toJson() => _$VocabularyProgressModelToJson(this);

  VocabularyProgress toEntity() {
    return VocabularyProgress(
      lessonId: lessonId,
      totalVocabulary: totalVocabulary,
      learned: learned,
      mastered: mastered,
      reviewing: reviewing,
      notStarted: notStarted,
      progressByMode: progressByMode.toEntity(),
      vocabularyList: vocabularyList.map((v) => v.toEntity()).toList(),
    );
  }
}

@JsonSerializable()
class ProgressByModeModel {
  @JsonKey(name: 'LEARN')
  final ModeProgressModel learn;
  @JsonKey(name: 'PRACTICE')
  final ModeProgressModel practice;
  @JsonKey(name: 'SPEAKING')
  final ModeProgressModel speaking;
  @JsonKey(name: 'WRITING')
  final ModeProgressModel writing;

  ProgressByModeModel({
    required this.learn,
    required this.practice,
    required this.speaking,
    required this.writing,
  });

  factory ProgressByModeModel.fromJson(Map<String, dynamic> json) =>
      _$ProgressByModeModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProgressByModeModelToJson(this);

  ProgressByMode toEntity() {
    return ProgressByMode(
      learn: learn.toEntity(),
      practice: practice.toEntity(),
      speaking: speaking.toEntity(),
      writing: writing.toEntity(),
    );
  }
}

@JsonSerializable()
class ModeProgressModel {
  final int completed;
  final int total;
  final double percentage;

  ModeProgressModel({
    required this.completed,
    required this.total,
    required this.percentage,
  });

  factory ModeProgressModel.fromJson(Map<String, dynamic> json) =>
      _$ModeProgressModelFromJson(json);

  Map<String, dynamic> toJson() => _$ModeProgressModelToJson(this);

  ModeProgress toEntity() {
    return ModeProgress(
      completed: completed,
      total: total,
      percentage: percentage,
    );
  }
}

@JsonSerializable()
class VocabularyItemProgressModel {
  final String vocabularyId;
  final String word;
  final String meaning;
  @JsonKey(unknownEnumValue: MasteryLevel.NEW)
  final MasteryLevel masteryLevel;
  final int correctCount;
  final int totalAttempts;
  final double correctRate;
  final DateTime? lastReviewed;
  final DateTime? nextReview;
  final int reviewInterval;

  VocabularyItemProgressModel({
    required this.vocabularyId,
    required this.word,
    required this.meaning,
    required this.masteryLevel,
    required this.correctCount,
    required this.totalAttempts,
    required this.correctRate,
    this.lastReviewed,
    this.nextReview,
    required this.reviewInterval,
  });

  factory VocabularyItemProgressModel.fromJson(Map<String, dynamic> json) =>
      _$VocabularyItemProgressModelFromJson(json);

  Map<String, dynamic> toJson() => _$VocabularyItemProgressModelToJson(this);

  VocabularyItemProgress toEntity() {
    return VocabularyItemProgress(
      vocabularyId: vocabularyId,
      word: word,
      meaning: meaning,
      masteryLevel: masteryLevel,
      correctCount: correctCount,
      totalAttempts: totalAttempts,
      correctRate: correctRate,
      lastReviewed: lastReviewed,
      nextReview: nextReview,
      reviewInterval: reviewInterval,
    );
  }
}

@JsonSerializable()
class VocabularyProgressResponse {
  final bool success;
  final String message;
  final VocabularyProgressModel data;

  VocabularyProgressResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory VocabularyProgressResponse.fromJson(Map<String, dynamic> json) =>
      _$VocabularyProgressResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VocabularyProgressResponseToJson(this);
}
