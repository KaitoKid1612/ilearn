import 'package:dartz/dartz.dart';
import 'package:ilearn/core/errors/failures.dart';
import 'package:ilearn/data/repositories/vocabulary_repository_impl.dart';

class SubmitVocabularyProgress {
  final VocabularyRepository repository;

  SubmitVocabularyProgress(this.repository);

  Future<Either<Failure, void>> call(
    String lessonId,
    Map<String, dynamic> progressData,
  ) async {
    return await repository.submitProgress(lessonId, progressData);
  }
}
