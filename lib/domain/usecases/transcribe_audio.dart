import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../../data/repositories/speaking_exercise_repository_impl.dart';
import '../entities/speaking_exercise.dart';

class TranscribeAudio {
  final SpeakingExerciseRepository repository;

  TranscribeAudio(this.repository);

  Future<Either<Failure, TranscriptionResult>> call(
    String exerciseId,
    File audioFile,
  ) async {
    return await repository.transcribeAudio(exerciseId, audioFile);
  }
}
