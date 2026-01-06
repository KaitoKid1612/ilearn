import 'package:equatable/equatable.dart';

abstract class LessonExerciseEvent extends Equatable {
  const LessonExerciseEvent();

  @override
  List<Object?> get props => [];
}

class LoadLessonExercises extends LessonExerciseEvent {
  final String lessonId;

  const LoadLessonExercises(this.lessonId);

  @override
  List<Object?> get props => [lessonId];
}
