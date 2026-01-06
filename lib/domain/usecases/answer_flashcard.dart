import 'package:dartz/dartz.dart';
import 'package:ilearn/core/errors/failures.dart';
import 'package:ilearn/data/models/flashcard_model.dart';
import 'package:ilearn/data/repositories/flashcard_repository.dart';

/// Use case để trả lời flashcard
class AnswerFlashcardUseCase {
  final FlashcardRepository repository;

  AnswerFlashcardUseCase(this.repository);

  Future<Either<Failure, FlashcardAnswerResponse>> call({
    required String flashcardId,
    required bool isRemembered,
  }) {
    return repository.answerFlashcard(
      flashcardId: flashcardId,
      isRemembered: isRemembered,
    );
  }
}
