import 'package:dartz/dartz.dart';
import 'package:ilearn/core/errors/failures.dart';
import 'package:ilearn/data/repositories/vocabulary_repository_impl.dart';
import 'package:ilearn/domain/entities/vocabulary.dart';

class GetLessonVocabulary {
  final VocabularyRepository repository;

  GetLessonVocabulary(this.repository);

  Future<Either<Failure, VocabularyLessonData>> call(String lessonId) async {
    return await repository.getLessonVocabulary(lessonId);
  }
}
