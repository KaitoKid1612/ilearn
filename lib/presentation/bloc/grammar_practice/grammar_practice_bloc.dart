import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilearn/data/repositories/grammar_practice_repository.dart';
import 'package:ilearn/presentation/bloc/grammar_practice/grammar_practice_event.dart';

class GrammarPracticeBloc
    extends Bloc<GrammarPracticeEvent, GrammarPracticeState> {
  final GrammarPracticeRepository repository;

  GrammarPracticeBloc({required this.repository})
    : super(GrammarPracticeInitial()) {
    on<StartGrammarPractice>(_onStartGrammarPractice);
    on<StartLessonPractice>(_onStartLessonPractice);
    on<AnswerQuestion>(_onAnswerQuestion);
    on<NextQuestion>(_onNextQuestion);
    on<PreviousQuestion>(_onPreviousQuestion);
    on<SubmitPractice>(_onSubmitPractice);
    on<LoadLessonProgress>(_onLoadLessonProgress);
    on<ResetPractice>(_onResetPractice);
  }

  Future<void> _onStartGrammarPractice(
    StartGrammarPractice event,
    Emitter<GrammarPracticeState> emit,
  ) async {
    emit(GrammarPracticeLoading());
    try {
      final response = await repository.createGrammarPractice(event.grammarId);
      emit(
        GrammarPracticeLoaded(
          practiceData: response.data,
          currentQuestionIndex: 0,
          userAnswers: {},
        ),
      );
    } catch (e) {
      emit(GrammarPracticeError(e.toString()));
    }
  }

  Future<void> _onStartLessonPractice(
    StartLessonPractice event,
    Emitter<GrammarPracticeState> emit,
  ) async {
    emit(GrammarPracticeLoading());
    try {
      final response = await repository.createLessonPractice(event.lessonId);
      emit(
        GrammarPracticeLoaded(
          practiceData: response.data,
          currentQuestionIndex: 0,
          userAnswers: {},
        ),
      );
    } catch (e) {
      emit(GrammarPracticeError(e.toString()));
    }
  }

  void _onAnswerQuestion(
    AnswerQuestion event,
    Emitter<GrammarPracticeState> emit,
  ) {
    if (state is GrammarPracticeLoaded) {
      final currentState = state as GrammarPracticeLoaded;
      final updatedAnswers = Map<int, String>.from(currentState.userAnswers);
      updatedAnswers[event.questionIndex] = event.answer;

      emit(currentState.copyWith(userAnswers: updatedAnswers));
    }
  }

  void _onNextQuestion(NextQuestion event, Emitter<GrammarPracticeState> emit) {
    if (state is GrammarPracticeLoaded) {
      final currentState = state as GrammarPracticeLoaded;
      if (!currentState.isLastQuestion) {
        emit(
          currentState.copyWith(
            currentQuestionIndex: currentState.currentQuestionIndex + 1,
          ),
        );
      }
    }
  }

  void _onPreviousQuestion(
    PreviousQuestion event,
    Emitter<GrammarPracticeState> emit,
  ) {
    if (state is GrammarPracticeLoaded) {
      final currentState = state as GrammarPracticeLoaded;
      if (currentState.currentQuestionIndex > 0) {
        emit(
          currentState.copyWith(
            currentQuestionIndex: currentState.currentQuestionIndex - 1,
          ),
        );
      }
    }
  }

  Future<void> _onSubmitPractice(
    SubmitPractice event,
    Emitter<GrammarPracticeState> emit,
  ) async {
    emit(GrammarPracticeSubmitting());
    try {
      final response = await repository.submitPractice(
        event.exerciseId,
        event.answers,
      );
      emit(GrammarPracticeCompleted(response));
    } catch (e) {
      emit(GrammarPracticeError(e.toString()));
    }
  }

  Future<void> _onLoadLessonProgress(
    LoadLessonProgress event,
    Emitter<GrammarPracticeState> emit,
  ) async {
    try {
      final response = await repository.getLessonProgress(event.lessonId);
      if (response.data != null) {
        emit(GrammarPracticeProgressLoaded(response.data!));
      }
    } catch (e) {
      emit(GrammarPracticeError(e.toString()));
    }
  }

  void _onResetPractice(
    ResetPractice event,
    Emitter<GrammarPracticeState> emit,
  ) {
    emit(GrammarPracticeInitial());
  }
}
