import 'package:equatable/equatable.dart';

/// Base event cho Flashcard
abstract class FlashcardEvent extends Equatable {
  const FlashcardEvent();

  @override
  List<Object?> get props => [];
}

/// Event để load flashcards của lesson
class LoadFlashcardsEvent extends FlashcardEvent {
  final String lessonId;

  const LoadFlashcardsEvent(this.lessonId);

  @override
  List<Object> get props => [lessonId];
}

/// Event để bắt đầu học
class StartStudyEvent extends FlashcardEvent {
  final String lessonId;

  const StartStudyEvent(this.lessonId);

  @override
  List<Object> get props => [lessonId];
}

/// Event để lật flashcard (xem đáp án)
class FlipCardEvent extends FlashcardEvent {
  const FlipCardEvent();
}

/// Event để trả lời flashcard (isRemembered: true = Nhớ, false = Chưa nhớ)
class AnswerCardEvent extends FlashcardEvent {
  final String flashcardId;
  final bool isRemembered;

  const AnswerCardEvent({
    required this.flashcardId,
    required this.isRemembered,
  });

  @override
  List<Object> get props => [flashcardId, isRemembered];
}

/// Event để chuyển sang card tiếp theo
class NextCardEvent extends FlashcardEvent {
  const NextCardEvent();
}

/// Event để reset study session
class ResetStudyEvent extends FlashcardEvent {
  const ResetStudyEvent();
}
