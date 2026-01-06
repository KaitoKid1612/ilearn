import 'package:equatable/equatable.dart';

abstract class TypingExerciseEvent extends Equatable {
  const TypingExerciseEvent();

  @override
  List<Object?> get props => [];
}

/// Event để load bài tập typing
class LoadTypingExerciseEvent extends TypingExerciseEvent {
  final String lessonId;
  final int limit;

  const LoadTypingExerciseEvent(this.lessonId, {this.limit = 10});

  @override
  List<Object> get props => [lessonId, limit];
}

/// Event để nhập câu trả lời
class TypeAnswerEvent extends TypingExerciseEvent {
  final String questionId;
  final String answer;

  const TypeAnswerEvent({required this.questionId, required this.answer});

  @override
  List<Object> get props => [questionId, answer];
}

/// Event để chuyển sang câu hỏi tiếp theo
class NextTypingQuestionEvent extends TypingExerciseEvent {
  const NextTypingQuestionEvent();
}

/// Event để quay lại câu hỏi trước
class PreviousTypingQuestionEvent extends TypingExerciseEvent {
  const PreviousTypingQuestionEvent();
}

/// Event để nộp bài tập typing
class SubmitTypingExerciseEvent extends TypingExerciseEvent {
  const SubmitTypingExerciseEvent();
}

/// Event để reset bài tập
class ResetTypingExerciseEvent extends TypingExerciseEvent {
  const ResetTypingExerciseEvent();
}
