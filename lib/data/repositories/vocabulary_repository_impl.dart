import 'package:dartz/dartz.dart';
import 'package:ilearn/core/errors/failures.dart';
import 'package:ilearn/data/datasources/vocabulary_remote_datasource.dart';
import 'package:ilearn/domain/entities/vocabulary.dart';
import 'package:ilearn/domain/entities/vocabulary_progress.dart';

abstract class VocabularyRepository {
  Future<Either<Failure, VocabularyLessonData>> getLessonVocabulary(
    String lessonId,
  );
  Future<Either<Failure, VocabularyProgress?>> getVocabularyProgress(
    String lessonId,
  );
  Future<Either<Failure, void>> submitProgress(
    String lessonId,
    Map<String, dynamic> progressData,
  );
  Future<Either<Failure, void>> markItemLearned({
    required String lessonId,
    required String itemId,
    required String itemType,
  });
  Future<Either<Failure, void>> batchMarkLearned({
    required String lessonId,
    required String itemType,
    required List<String> itemIds,
  });
}

class VocabularyRepositoryImpl implements VocabularyRepository {
  final VocabularyRemoteDataSource remoteDataSource;

  VocabularyRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, VocabularyLessonData>> getLessonVocabulary(
    String lessonId,
  ) async {
    try {
      final result = await remoteDataSource.getLessonVocabulary(lessonId);
      return Right(result.toEntity());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, VocabularyProgress?>> getVocabularyProgress(
    String lessonId,
  ) async {
    try {
      final result = await remoteDataSource.getVocabularyProgress(lessonId);
      return Right(result?.toEntity());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> submitProgress(
    String lessonId,
    Map<String, dynamic> progressData,
  ) async {
    try {
      await remoteDataSource.submitProgress(lessonId, progressData);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> markItemLearned({
    required String lessonId,
    required String itemId,
    required String itemType,
  }) async {
    try {
      await remoteDataSource.markItemLearned(
        lessonId: lessonId,
        itemId: itemId,
        itemType: itemType,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> batchMarkLearned({
    required String lessonId,
    required String itemType,
    required List<String> itemIds,
  }) async {
    try {
      await remoteDataSource.batchMarkLearned(
        lessonId: lessonId,
        itemType: itemType,
        itemIds: itemIds,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
