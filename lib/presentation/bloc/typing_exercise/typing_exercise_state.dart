import 'package:equatable/equatable.dart';
import '../../../domain/entities/typing_exercise.dart';

abstract class TypingExerciseState extends Equatable {
  const TypingExerciseState();

  @override
  List<Object?> get props => [];
}

/// State ban đầu
class TypingExerciseInitial extends TypingExerciseState {
  const TypingExerciseInitial();
}

/// State đang load bài tập
class TypingExerciseLoading extends TypingExerciseState {
  const TypingExerciseLoading();
}

/// State đang làm bài tập
class TypingExerciseInProgress extends TypingExerciseState {
  final TypingExercise exercise;
  final int currentQuestionIndex;
  final Map<String, String> userAnswers;
  final int totalQuestions;

  const TypingExerciseInProgress({
    required this.exercise,
    required this.currentQuestionIndex,
    required this.userAnswers,
    required this.totalQuestions,
  });

  TypingQuestion get currentQuestion =>
      exercise.questions[currentQuestionIndex];

  String? get currentAnswer => userAnswers[currentQuestion.id];

  bool get isFirstQuestion => currentQuestionIndex == 0;
  bool get isLastQuestion => currentQuestionIndex == totalQuestions - 1;
  bool get canSubmit => userAnswers.length == totalQuestions;

  @override
  List<Object?> get props => [
    exercise,
    currentQuestionIndex,
    userAnswers,
    totalQuestions,
  ];

  TypingExerciseInProgress copyWith({
    TypingExercise? exercise,
    int? currentQuestionIndex,
    Map<String, String>? userAnswers,
    int? totalQuestions,
  }) {
    return TypingExerciseInProgress(
      exercise: exercise ?? this.exercise,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      userAnswers: userAnswers ?? this.userAnswers,
      totalQuestions: totalQuestions ?? this.totalQuestions,
    );
  }
}

/// State đang nộp bài
class TypingExerciseSubmitting extends TypingExerciseState {
  const TypingExerciseSubmitting();
}

/// State hoàn thành bài tập
class TypingExerciseCompleted extends TypingExerciseState {
  final TypingExerciseResult result;

  const TypingExerciseCompleted(this.result);

  @override
  List<Object> get props => [result];
}

/// State lỗi
class TypingExerciseError extends TypingExerciseState {
  final String message;

  const TypingExerciseError(this.message);

  @override
  List<Object> get props => [message];
}
