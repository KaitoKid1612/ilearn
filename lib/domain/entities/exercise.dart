import 'package:equatable/equatable.dart';

/// Entity cho câu hỏi trắc nghiệm
class Question extends Equatable {
  final String id;
  final String vocabularyId;
  final String question;
  final String questionText;
  final String? audio;
  final List<QuestionOption> options;

  const Question({
    required this.id,
    required this.vocabularyId,
    required this.question,
    required this.questionText,
    this.audio,
    required this.options,
  });

  @override
  List<Object?> get props => [
    id,
    vocabularyId,
    question,
    questionText,
    audio,
    options,
  ];
}

/// Entity cho option của câu hỏi
class QuestionOption extends Equatable {
  final String id;
  final String text;
  final bool isCorrect;

  const QuestionOption({
    required this.id,
    required this.text,
    required this.isCorrect,
  });

  @override
  List<Object> get props => [id, text, isCorrect];
}

/// Entity cho bài tập trắc nghiệm
class Exercise extends Equatable {
  final String exerciseId;
  final String lessonId;
  final String title;
  final int totalQuestions;
  final List<Question> questions;

  const Exercise({
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

/// Entity cho kết quả câu hỏi
class QuestionResult extends Equatable {
  final String questionId;
  final String userAnswer;
  final String correctAnswer;
  final bool isCorrect;

  const QuestionResult({
    required this.questionId,
    required this.userAnswer,
    required this.correctAnswer,
    required this.isCorrect,
  });

  @override
  List<Object> get props => [questionId, userAnswer, correctAnswer, isCorrect];
}

/// Entity cho kết quả bài tập
class ExerciseResult extends Equatable {
  final String exerciseId;
  final int totalQuestions;
  final int correctAnswers;
  final int incorrectAnswers;
  final int score;
  final int pointsEarned;
  final List<QuestionResult> results;
  final String message;

  const ExerciseResult({
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
