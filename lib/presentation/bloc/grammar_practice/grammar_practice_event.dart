import 'package:equatable/equatable.dart';
import 'package:ilearn/data/models/grammar_practice_model.dart';

// Events
abstract class GrammarPracticeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class StartGrammarPractice extends GrammarPracticeEvent {
  final String grammarId;

  StartGrammarPractice(this.grammarId);

  @override
  List<Object?> get props => [grammarId];
}

class StartLessonPractice extends GrammarPracticeEvent {
  final String lessonId;

  StartLessonPractice(this.lessonId);

  @override
  List<Object?> get props => [lessonId];
}

class AnswerQuestion extends GrammarPracticeEvent {
  final int questionIndex;
  final String answer;

  AnswerQuestion(this.questionIndex, this.answer);

  @override
  List<Object?> get props => [questionIndex, answer];
}

class SubmitPractice extends GrammarPracticeEvent {
  final String exerciseId;
  final Map<String, dynamic> answers;

  SubmitPractice(this.exerciseId, this.answers);

  @override
  List<Object?> get props => [exerciseId, answers];
}

class LoadLessonProgress extends GrammarPracticeEvent {
  final String lessonId;

  LoadLessonProgress(this.lessonId);

  @override
  List<Object?> get props => [lessonId];
}

class NextQuestion extends GrammarPracticeEvent {}

class PreviousQuestion extends GrammarPracticeEvent {}

class ResetPractice extends GrammarPracticeEvent {}

// States
abstract class GrammarPracticeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GrammarPracticeInitial extends GrammarPracticeState {}

class GrammarPracticeLoading extends GrammarPracticeState {}

class GrammarPracticeLoaded extends GrammarPracticeState {
  final GrammarPracticeDataModel practiceData;
  final int currentQuestionIndex;
  final Map<int, String> userAnswers;

  GrammarPracticeLoaded({
    required this.practiceData,
    this.currentQuestionIndex = 0,
    this.userAnswers = const {},
  });

  GrammarPracticeLoaded copyWith({
    GrammarPracticeDataModel? practiceData,
    int? currentQuestionIndex,
    Map<int, String>? userAnswers,
  }) {
    return GrammarPracticeLoaded(
      practiceData: practiceData ?? this.practiceData,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      userAnswers: userAnswers ?? this.userAnswers,
    );
  }

  bool get isLastQuestion =>
      currentQuestionIndex >= practiceData.exercises.length - 1;

  bool get hasAnsweredCurrent => userAnswers.containsKey(currentQuestionIndex);

  @override
  List<Object?> get props => [practiceData, currentQuestionIndex, userAnswers];
}

class GrammarPracticeSubmitting extends GrammarPracticeState {}

class GrammarPracticeCompleted extends GrammarPracticeState {
  final SubmitGrammarPracticeResponseModel result;

  GrammarPracticeCompleted(this.result);

  @override
  List<Object?> get props => [result];
}

class GrammarPracticeProgressLoaded extends GrammarPracticeState {
  final GrammarPracticeProgressModel progress;

  GrammarPracticeProgressLoaded(this.progress);

  @override
  List<Object?> get props => [progress];
}

class GrammarPracticeError extends GrammarPracticeState {
  final String message;

  GrammarPracticeError(this.message);

  @override
  List<Object?> get props => [message];
}
