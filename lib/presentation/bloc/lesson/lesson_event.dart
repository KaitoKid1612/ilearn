import 'package:equatable/equatable.dart';

abstract class LessonEvent extends Equatable {
  const LessonEvent();

  @override
  List<Object?> get props => [];
}

class LoadLessonDetailEvent extends LessonEvent {
  final String lessonId;

  const LoadLessonDetailEvent(this.lessonId);

  @override
  List<Object?> get props => [lessonId];
}
