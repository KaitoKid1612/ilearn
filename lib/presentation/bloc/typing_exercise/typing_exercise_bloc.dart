import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/create_typing_exercise.dart';
import '../../../domain/usecases/submit_typing_exercise.dart';
import 'typing_exercise_event.dart';
import 'typing_exercise_state.dart';

class TypingExerciseBloc
    extends Bloc<TypingExerciseEvent, TypingExerciseState> {
  final CreateTypingExercise createTypingExercise;
  final SubmitTypingExercise submitTypingExercise;

  TypingExerciseBloc({
    required this.createTypingExercise,
    required this.submitTypingExercise,
  }) : super(const TypingExerciseInitial()) {
    on<LoadTypingExerciseEvent>(_onLoadTypingExercise);
    on<TypeAnswerEvent>(_onTypeAnswer);
    on<NextTypingQuestionEvent>(_onNextQuestion);
    on<PreviousTypingQuestionEvent>(_onPreviousQuestion);
    on<SubmitTypingExerciseEvent>(_onSubmitExercise);
    on<ResetTypingExerciseEvent>(_onResetExercise);
  }

  Future<void> _onLoadTypingExercise(
    LoadTypingExerciseEvent event,
    Emitter<TypingExerciseState> emit,
  ) async {
    emit(const TypingExerciseLoading());

    final result = await createTypingExercise(
      event.lessonId,
      limit: event.limit,
    );

    result.fold(
      (error) => emit(TypingExerciseError(error)),
      (exercise) => emit(
        TypingExerciseInProgress(
          exercise: exercise,
          currentQuestionIndex: 0,
          userAnswers: {},
          totalQuestions: exercise.totalQuestions,
        ),
      ),
    );
  }

  void _onTypeAnswer(TypeAnswerEvent event, Emitter<TypingExerciseState> emit) {
    if (state is TypingExerciseInProgress) {
      final currentState = state as TypingExerciseInProgress;
      final updatedAnswers = Map<String, String>.from(currentState.userAnswers);
      updatedAnswers[event.questionId] = event.answer;

      emit(currentState.copyWith(userAnswers: updatedAnswers));
    }
  }

  void _onNextQuestion(
    NextTypingQuestionEvent event,
    Emitter<TypingExerciseState> emit,
  ) {
    if (state is TypingExerciseInProgress) {
      final currentState = state as TypingExerciseInProgress;
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
    PreviousTypingQuestionEvent event,
    Emitter<TypingExerciseState> emit,
  ) {
    if (state is TypingExerciseInProgress) {
      final currentState = state as TypingExerciseInProgress;
      if (!currentState.isFirstQuestion) {
        emit(
          currentState.copyWith(
            currentQuestionIndex: currentState.currentQuestionIndex - 1,
          ),
        );
      }
    }
  }

  Future<void> _onSubmitExercise(
    SubmitTypingExerciseEvent event,
    Emitter<TypingExerciseState> emit,
  ) async {
    if (state is TypingExerciseInProgress) {
      final currentState = state as TypingExerciseInProgress;

      if (!currentState.canSubmit) {
        emit(const TypingExerciseError('Vui lòng trả lời tất cả các câu hỏi'));
        emit(currentState);
        return;
      }

      emit(const TypingExerciseSubmitting());

      final result = await submitTypingExercise(
        currentState.exercise.exerciseId,
        currentState.userAnswers,
      );

      result.fold((error) {
        emit(TypingExerciseError(error));
        emit(currentState);
      }, (exerciseResult) => emit(TypingExerciseCompleted(exerciseResult)));
    }
  }

  void _onResetExercise(
    ResetTypingExerciseEvent event,
    Emitter<TypingExerciseState> emit,
  ) {
    emit(const TypingExerciseInitial());
  }
}
