import 'package:dartz/dartz.dart';
import 'package:ilearn/core/errors/failures.dart';
import 'package:ilearn/data/repositories/vocabulary_repository_impl.dart';
import 'package:ilearn/domain/entities/vocabulary_progress.dart';

class GetVocabularyProgress {
  final VocabularyRepository repository;

  GetVocabularyProgress(this.repository);

  Future<Either<Failure, VocabularyProgress?>> call(String lessonId) async {
    return await repository.getVocabularyProgress(lessonId);
  }
}
