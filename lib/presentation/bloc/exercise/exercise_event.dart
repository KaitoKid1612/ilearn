import 'package:equatable/equatable.dart';

abstract class ExerciseEvent extends Equatable {
  const ExerciseEvent();

  @override
  List<Object?> get props => [];
}

/// Event để load bài tập trắc nghiệm
class LoadExerciseEvent extends ExerciseEvent {
  final String lessonId;

  const LoadExerciseEvent(this.lessonId);

  @override
  List<Object> get props => [lessonId];
}

/// Event để chọn đáp án cho câu hỏi
class SelectAnswerEvent extends ExerciseEvent {
  final String questionId;
  final String selectedOption;

  const SelectAnswerEvent({
    required this.questionId,
    required this.selectedOption,
  });

  @override
  List<Object> get props => [questionId, selectedOption];
}

/// Event để chuyển sang câu hỏi tiếp theo
class NextQuestionEvent extends ExerciseEvent {
  const NextQuestionEvent();
}

/// Event để quay lại câu hỏi trước
class PreviousQuestionEvent extends ExerciseEvent {
  const PreviousQuestionEvent();
}

/// Event để nộp bài tập
class SubmitExerciseEvent extends ExerciseEvent {
  const SubmitExerciseEvent();
}

/// Event để reset bài tập
class ResetExerciseEvent extends ExerciseEvent {
  const ResetExerciseEvent();
}
