import 'package:equatable/equatable.dart';
import '../../../domain/entities/exercise.dart';

abstract class ExerciseState extends Equatable {
  const ExerciseState();

  @override
  List<Object?> get props => [];
}

/// State ban đầu
class ExerciseInitial extends ExerciseState {
  const ExerciseInitial();
}

/// State đang load bài tập
class ExerciseLoading extends ExerciseState {
  const ExerciseLoading();
}

/// State đang làm bài tập
class ExerciseInProgress extends ExerciseState {
  final Exercise exercise;
  final int currentQuestionIndex;
  final Map<String, String> userAnswers;
  final int totalQuestions;

  const ExerciseInProgress({
    required this.exercise,
    required this.currentQuestionIndex,
    required this.userAnswers,
    required this.totalQuestions,
  });

  Question get currentQuestion => exercise.questions[currentQuestionIndex];

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

  ExerciseInProgress copyWith({
    Exercise? exercise,
    int? currentQuestionIndex,
    Map<String, String>? userAnswers,
    int? totalQuestions,
  }) {
    return ExerciseInProgress(
      exercise: exercise ?? this.exercise,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      userAnswers: userAnswers ?? this.userAnswers,
      totalQuestions: totalQuestions ?? this.totalQuestions,
    );
  }
}

/// State đang nộp bài
class ExerciseSubmitting extends ExerciseState {
  const ExerciseSubmitting();
}

/// State hoàn thành bài tập
class ExerciseCompleted extends ExerciseState {
  final ExerciseResult result;

  const ExerciseCompleted(this.result);

  @override
  List<Object> get props => [result];
}

/// State lỗi
class ExerciseError extends ExerciseState {
  final String message;

  const ExerciseError(this.message);

  @override
  List<Object> get props => [message];
}
