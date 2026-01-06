import 'package:equatable/equatable.dart';

// Main Speaking Exercise Entity
class SpeakingExercise extends Equatable {
  final String exerciseId;
  final String lessonId;
  final int totalQuestions;
  final List<SpeakingQuestion> questions;
  final DateTime expiresAt;

  const SpeakingExercise({
    required this.exerciseId,
    required this.lessonId,
    required this.totalQuestions,
    required this.questions,
    required this.expiresAt,
  });

  @override
  List<Object?> get props => [
    exerciseId,
    lessonId,
    totalQuestions,
    questions,
    expiresAt,
  ];

  SpeakingExercise copyWith({
    String? exerciseId,
    String? lessonId,
    int? totalQuestions,
    List<SpeakingQuestion>? questions,
    DateTime? expiresAt,
  }) {
    return SpeakingExercise(
      exerciseId: exerciseId ?? this.exerciseId,
      lessonId: lessonId ?? this.lessonId,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      questions: questions ?? this.questions,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }
}

// Speaking Question Entity
class SpeakingQuestion extends Equatable {
  final String id;
  final String japaneseText;
  final String romaji;
  final String vietnameseMeaning;
  final String audioUrl;
  final String? userTranscription;
  final double? confidence;

  const SpeakingQuestion({
    required this.id,
    required this.japaneseText,
    required this.romaji,
    required this.vietnameseMeaning,
    required this.audioUrl,
    this.userTranscription,
    this.confidence,
  });

  @override
  List<Object?> get props => [
    id,
    japaneseText,
    romaji,
    vietnameseMeaning,
    audioUrl,
    userTranscription,
    confidence,
  ];

  SpeakingQuestion copyWith({
    String? id,
    String? japaneseText,
    String? romaji,
    String? vietnameseMeaning,
    String? audioUrl,
    String? userTranscription,
    double? confidence,
  }) {
    return SpeakingQuestion(
      id: id ?? this.id,
      japaneseText: japaneseText ?? this.japaneseText,
      romaji: romaji ?? this.romaji,
      vietnameseMeaning: vietnameseMeaning ?? this.vietnameseMeaning,
      audioUrl: audioUrl ?? this.audioUrl,
      userTranscription: userTranscription ?? this.userTranscription,
      confidence: confidence ?? this.confidence,
    );
  }
}

// Transcription Result Entity
class TranscriptionResult extends Equatable {
  final String transcribedText;
  final double confidence;
  final List<String> alternatives;

  const TranscriptionResult({
    required this.transcribedText,
    required this.confidence,
    required this.alternatives,
  });

  @override
  List<Object?> get props => [transcribedText, confidence, alternatives];
}

// Speaking Exercise Result Entity
class SpeakingExerciseResult extends Equatable {
  final String exerciseId;
  final int totalQuestions;
  final int correctAnswers;
  final double score;
  final List<SpeakingQuestionResult> questionResults;

  const SpeakingExerciseResult({
    required this.exerciseId,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.score,
    required this.questionResults,
  });

  @override
  List<Object?> get props => [
    exerciseId,
    totalQuestions,
    correctAnswers,
    score,
    questionResults,
  ];
}

// Speaking Question Result Entity
class SpeakingQuestionResult extends Equatable {
  final String questionId;
  final String expectedText;
  final String userTranscription;
  final bool isCorrect;
  final double confidence;
  final double similarityScore;

  const SpeakingQuestionResult({
    required this.questionId,
    required this.expectedText,
    required this.userTranscription,
    required this.isCorrect,
    required this.confidence,
    required this.similarityScore,
  });

  @override
  List<Object?> get props => [
    questionId,
    expectedText,
    userTranscription,
    isCorrect,
    confidence,
    similarityScore,
  ];
}
