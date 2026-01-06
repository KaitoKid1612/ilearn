import 'package:dartz/dartz.dart';
import 'package:ilearn/core/errors/failures.dart';
import 'package:ilearn/data/repositories/flashcard_repository.dart';

/// Use case để bắt đầu session học flashcard
class StartStudySessionUseCase {
  final FlashcardRepository repository;

  StartStudySessionUseCase(this.repository);

  Future<Either<Failure, Map<String, dynamic>>> call(String lessonId) {
    return repository.startStudySession(lessonId);
  }
}
