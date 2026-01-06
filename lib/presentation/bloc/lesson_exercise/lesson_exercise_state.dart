import 'package:equatable/equatable.dart';
import 'package:ilearn/data/models/lesson_exercise_model.dart';

abstract class LessonExerciseState extends Equatable {
  const LessonExerciseState();

  @override
  List<Object?> get props => [];
}

class LessonExerciseInitial extends LessonExerciseState {}

class LessonExerciseLoading extends LessonExerciseState {}

class LessonExerciseLoaded extends LessonExerciseState {
  final LessonExerciseListModel exerciseList;

  const LessonExerciseLoaded(this.exerciseList);

  @override
  List<Object?> get props => [exerciseList];
}

class LessonExerciseError extends LessonExerciseState {
  final String message;

  const LessonExerciseError(this.message);

  @override
  List<Object?> get props => [message];
}
