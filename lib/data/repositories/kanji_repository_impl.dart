import 'package:dartz/dartz.dart';
import 'package:ilearn/core/errors/failures.dart';
import 'package:ilearn/data/datasources/kanji_remote_datasource.dart';
import 'package:ilearn/domain/entities/kanji.dart';

abstract class KanjiRepository {
  Future<Either<Failure, KanjiLessonData>> getLessonKanji(String lessonId);
  Future<Either<Failure, void>> markKanjiLearned({
    required String lessonId,
    required String kanjiId,
  });
}

class KanjiRepositoryImpl implements KanjiRepository {
  final KanjiRemoteDataSource remoteDataSource;

  KanjiRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, KanjiLessonData>> getLessonKanji(
    String lessonId,
  ) async {
    try {
      final result = await remoteDataSource.getLessonKanji(lessonId);
      return Right(result.toEntity());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> markKanjiLearned({
    required String lessonId,
    required String kanjiId,
  }) async {
    try {
      await remoteDataSource.markKanjiLearned(
        lessonId: lessonId,
        kanjiId: kanjiId,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
