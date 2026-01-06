import 'package:dartz/dartz.dart';
import 'package:ilearn/core/errors/failures.dart';
import 'package:ilearn/data/repositories/flashcard_repository.dart';
import 'package:ilearn/domain/entities/flashcard.dart';

/// Use case để lấy flashcards của lesson
class GetFlashcardsByLessonUseCase {
  final FlashcardRepository repository;

  GetFlashcardsByLessonUseCase(this.repository);

  Future<Either<Failure, FlashcardSet>> call(String lessonId) {
    return repository.getFlashcardsByLesson(lessonId);
  }
}
