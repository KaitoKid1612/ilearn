import 'package:dartz/dartz.dart';
import 'package:ilearn/core/errors/failures.dart';
import 'package:ilearn/data/repositories/kanji_repository_impl.dart';
import 'package:ilearn/domain/entities/kanji.dart';

class GetLessonKanji {
  final KanjiRepository repository;

  GetLessonKanji(this.repository);

  Future<Either<Failure, KanjiLessonData>> call(String lessonId) async {
    return await repository.getLessonKanji(lessonId);
  }
}
