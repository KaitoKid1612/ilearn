import 'package:equatable/equatable.dart';
import 'package:ilearn/data/models/lesson_detail_model.dart';

abstract class LessonState extends Equatable {
  const LessonState();

  @override
  List<Object?> get props => [];
}

class LessonInitial extends LessonState {
  const LessonInitial();
}

class LessonLoading extends LessonState {
  const LessonLoading();
}

class LessonLoaded extends LessonState {
  final LessonDetailModel lesson;

  const LessonLoaded(this.lesson);

  @override
  List<Object?> get props => [lesson];
}

class LessonError extends LessonState {
  final String message;

  const LessonError(this.message);

  @override
  List<Object?> get props => [message];
}
