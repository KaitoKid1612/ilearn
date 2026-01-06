import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/speaking_exercise.dart';
import '../datasources/speaking_exercise_remote_datasource.dart';

abstract class SpeakingExerciseRepository {
  Future<Either<Failure, SpeakingExercise>> createSpeakingExercise(
    String lessonId,
  );
  Future<Either<Failure, TranscriptionResult>> transcribeAudio(
    String exerciseId,
    File audioFile,
  );
  Future<Either<Failure, SpeakingExerciseResult>> submitSpeakingExercise(
    String exerciseId,
    Map<String, String> answers,
  );
}

class SpeakingExerciseRepositoryImpl implements SpeakingExerciseRepository {
  final SpeakingExerciseRemoteDataSource remoteDataSource;

  SpeakingExerciseRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, SpeakingExercise>> createSpeakingExercise(
    String lessonId,
  ) async {
    try {
      final result = await remoteDataSource.createSpeakingExercise(lessonId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TranscriptionResult>> transcribeAudio(
    String exerciseId,
    File audioFile,
  ) async {
    try {
      final result = await remoteDataSource.transcribeAudio(
        exerciseId,
        audioFile,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SpeakingExerciseResult>> submitSpeakingExercise(
    String exerciseId,
    Map<String, String> answers,
  ) async {
    try {
      final result = await remoteDataSource.submitSpeakingExercise(
        exerciseId,
        answers,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
