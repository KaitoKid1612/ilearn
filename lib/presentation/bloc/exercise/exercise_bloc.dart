import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/create_multiple_choice_exercise.dart';
import '../../../domain/usecases/submit_exercise.dart';
import 'exercise_event.dart';
import 'exercise_state.dart';

class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  final CreateMultipleChoiceExercise createMultipleChoiceExercise;
  final SubmitExercise submitExercise;

  ExerciseBloc({
    required this.createMultipleChoiceExercise,
    required this.submitExercise,
  }) : super(const ExerciseInitial()) {
    on<LoadExerciseEvent>(_onLoadExercise);
    on<SelectAnswerEvent>(_onSelectAnswer);
    on<NextQuestionEvent>(_onNextQuestion);
    on<PreviousQuestionEvent>(_onPreviousQuestion);
    on<SubmitExerciseEvent>(_onSubmitExercise);
    on<ResetExerciseEvent>(_onResetExercise);
  }

  Future<void> _onLoadExercise(
    LoadExerciseEvent event,
    Emitter<ExerciseState> emit,
  ) async {
    emit(const ExerciseLoading());

    final result = await createMultipleChoiceExercise(event.lessonId);

    result.fold(
      (error) => emit(ExerciseError(error)),
      (exercise) => emit(
        ExerciseInProgress(
          exercise: exercise,
          currentQuestionIndex: 0,
          userAnswers: {},
          totalQuestions: exercise.totalQuestions,
        ),
      ),
    );
  }

  void _onSelectAnswer(SelectAnswerEvent event, Emitter<ExerciseState> emit) {
    if (state is ExerciseInProgress) {
      final currentState = state as ExerciseInProgress;
      final updatedAnswers = Map<String, String>.from(currentState.userAnswers);
      updatedAnswers[event.questionId] = event.selectedOption;

      emit(currentState.copyWith(userAnswers: updatedAnswers));
    }
  }

  void _onNextQuestion(NextQuestionEvent event, Emitter<ExerciseState> emit) {
    if (state is ExerciseInProgress) {
      final currentState = state as ExerciseInProgress;
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
    PreviousQuestionEvent event,
    Emitter<ExerciseState> emit,
  ) {
    if (state is ExerciseInProgress) {
      final currentState = state as ExerciseInProgress;
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
    SubmitExerciseEvent event,
    Emitter<ExerciseState> emit,
  ) async {
    if (state is ExerciseInProgress) {
      final currentState = state as ExerciseInProgress;

      if (!currentState.canSubmit) {
        emit(const ExerciseError('Vui lòng trả lời tất cả các câu hỏi'));
        emit(currentState);
        return;
      }

      emit(const ExerciseSubmitting());

      final result = await submitExercise(
        currentState.exercise.exerciseId,
        currentState.userAnswers,
      );

      result.fold((error) {
        emit(ExerciseError(error));
        emit(currentState);
      }, (exerciseResult) => emit(ExerciseCompleted(exerciseResult)));
    }
  }

  void _onResetExercise(ResetExerciseEvent event, Emitter<ExerciseState> emit) {
    emit(const ExerciseInitial());
  }
}
