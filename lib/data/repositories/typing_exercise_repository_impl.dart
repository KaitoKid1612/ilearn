import 'package:dartz/dartz.dart';
import '../../domain/entities/typing_exercise.dart';
import '../../domain/repositories/typing_exercise_repository.dart';
import '../datasources/typing_exercise_remote_datasource.dart';

class TypingExerciseRepositoryImpl implements TypingExerciseRepository {
  final TypingExerciseRemoteDataSource remoteDataSource;

  TypingExerciseRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, TypingExercise>> createTypingExercise(
    String lessonId, {
    int limit = 10,
  }) async {
    try {
      final exercise = await remoteDataSource.createTypingExercise(
        lessonId,
        limit: limit,
      );
      return Right(exercise);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, TypingExerciseResult>> submitTypingExercise(
    String exerciseId,
    Map<String, String> answers,
  ) async {
    try {
      final result = await remoteDataSource.submitTypingExercise(
        exerciseId,
        answers,
      );
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
