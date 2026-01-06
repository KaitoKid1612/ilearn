import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilearn/domain/usecases/get_lesson_exercises.dart';
import 'lesson_exercise_event.dart';
import 'lesson_exercise_state.dart';

class LessonExerciseBloc
    extends Bloc<LessonExerciseEvent, LessonExerciseState> {
  final GetLessonExercises getLessonExercises;

  LessonExerciseBloc({required this.getLessonExercises})
    : super(LessonExerciseInitial()) {
    on<LoadLessonExercises>(_onLoadLessonExercises);
  }

  Future<void> _onLoadLessonExercises(
    LoadLessonExercises event,
    Emitter<LessonExerciseState> emit,
  ) async {
    emit(LessonExerciseLoading());

    final result = await getLessonExercises(event.lessonId);

    result.fold(
      (error) => emit(LessonExerciseError(error)),
      (exerciseList) => emit(LessonExerciseLoaded(exerciseList)),
    );
  }
}
