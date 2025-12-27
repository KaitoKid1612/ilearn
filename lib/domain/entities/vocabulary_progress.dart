import 'package:equatable/equatable.dart';

enum MasteryLevel { NEW, FAMILIAR, MASTERED }

class VocabularyProgress extends Equatable {
  final String lessonId;
  final int totalVocabulary;
  final int learned;
  final int mastered;
  final int reviewing;
  final int notStarted;
  final ProgressByMode progressByMode;
  final List<VocabularyItemProgress> vocabularyList;

  const VocabularyProgress({
    required this.lessonId,
    required this.totalVocabulary,
    required this.learned,
    required this.mastered,
    required this.reviewing,
    required this.notStarted,
    required this.progressByMode,
    required this.vocabularyList,
  });

  @override
  List<Object?> get props => [
    lessonId,
    totalVocabulary,
    learned,
    mastered,
    reviewing,
    notStarted,
    progressByMode,
    vocabularyList,
  ];
}

class ProgressByMode extends Equatable {
  final ModeProgress learn;
  final ModeProgress practice;
  final ModeProgress speaking;
  final ModeProgress writing;

  const ProgressByMode({
    required this.learn,
    required this.practice,
    required this.speaking,
    required this.writing,
  });

  @override
  List<Object?> get props => [learn, practice, speaking, writing];
}

class ModeProgress extends Equatable {
  final int completed;
  final int total;
  final double percentage;

  const ModeProgress({
    required this.completed,
    required this.total,
    required this.percentage,
  });

  @override
  List<Object?> get props => [completed, total, percentage];
}

class VocabularyItemProgress extends Equatable {
  final String vocabularyId;
  final String word;
  final String meaning;
  final MasteryLevel masteryLevel;
  final int correctCount;
  final int totalAttempts;
  final double correctRate;
  final DateTime? lastReviewed;
  final DateTime? nextReview;
  final int reviewInterval;

  const VocabularyItemProgress({
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

  @override
  List<Object?> get props => [
    vocabularyId,
    word,
    meaning,
    masteryLevel,
    correctCount,
    totalAttempts,
    correctRate,
    lastReviewed,
    nextReview,
    reviewInterval,
  ];
}
