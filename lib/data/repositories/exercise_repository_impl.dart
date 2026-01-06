import 'package:dartz/dartz.dart';
import '../../domain/entities/exercise.dart';
import '../../domain/repositories/exercise_repository.dart';
import '../datasources/exercise_remote_datasource.dart';
import '../models/lesson_exercise_model.dart';
import '../models/exercise_session_model.dart';

class ExerciseRepositoryImpl implements ExerciseRepository {
  final ExerciseRemoteDataSource remoteDataSource;

  ExerciseRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, LessonExerciseListModel>> getLessonExercises(
    String lessonId,
  ) async {
    try {
      final exercises = await remoteDataSource.getLessonExercises(lessonId);
      return Right(exercises);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Exercise>> createMultipleChoiceExercise(
    String lessonId,
  ) async {
    try {
      final exercise = await remoteDataSource.createMultipleChoiceExercise(
        lessonId,
      );
      return Right(exercise);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, ExerciseResult>> submitExercise(
    String exerciseId,
    Map<String, String> answers,
  ) async {
    try {
      final result = await remoteDataSource.submitExercise(exerciseId, answers);
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, ExerciseSessionModel>> startExerciseSession(
    String lessonId,
  ) async {
    try {
      final session = await remoteDataSource.startExerciseSession(lessonId);
      return Right(session);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, ExerciseSessionResultModel>> submitExerciseSession(
    String lessonId,
    String sessionId,
    Map<String, String> answers,
  ) async {
    try {
      final result = await remoteDataSource.submitExerciseSession(
        lessonId,
        sessionId,
        answers,
      );
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
