import 'package:equatable/equatable.dart';

/// Entity cho câu hỏi typing
class TypingQuestion extends Equatable {
  final String id;
  final String vocabularyId;
  final String question;
  final String hint;
  final String hintType; // 'meaning', 'kanji', 'romaji'
  final String answerType; // 'hiragana', 'kanji', 'romaji'
  final String? audio;

  const TypingQuestion({
    required this.id,
    required this.vocabularyId,
    required this.question,
    required this.hint,
    required this.hintType,
    required this.answerType,
    this.audio,
  });

  @override
  List<Object?> get props => [
    id,
    vocabularyId,
    question,
    hint,
    hintType,
    answerType,
    audio,
  ];
}

/// Entity cho bài tập typing
class TypingExercise extends Equatable {
  final String exerciseId;
  final String lessonId;
  final String title;
  final int totalQuestions;
  final List<TypingQuestion> questions;

  const TypingExercise({
    required this.exerciseId,
    required this.lessonId,
    required this.title,
    required this.totalQuestions,
    required this.questions,
  });

  @override
  List<Object> get props => [
    exerciseId,
    lessonId,
    title,
    totalQuestions,
    questions,
  ];
}

/// Entity cho kết quả câu hỏi typing
class TypingQuestionResult extends Equatable {
  final String questionId;
  final String userAnswer;
  final String correctAnswer;
  final bool isCorrect;

  const TypingQuestionResult({
    required this.questionId,
    required this.userAnswer,
    required this.correctAnswer,
    required this.isCorrect,
  });

  @override
  List<Object> get props => [questionId, userAnswer, correctAnswer, isCorrect];
}

/// Entity cho kết quả bài tập typing
class TypingExerciseResult extends Equatable {
  final String exerciseId;
  final int totalQuestions;
  final int correctAnswers;
  final int incorrectAnswers;
  final int score;
  final int pointsEarned;
  final List<TypingQuestionResult> results;
  final String message;

  const TypingExerciseResult({
    required this.exerciseId,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.incorrectAnswers,
    required this.score,
    required this.pointsEarned,
    required this.results,
    required this.message,
  });

  @override
  List<Object> get props => [
    exerciseId,
    totalQuestions,
    correctAnswers,
    incorrectAnswers,
    score,
    pointsEarned,
    results,
    message,
  ];
}
