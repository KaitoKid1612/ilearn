import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../../data/repositories/speaking_exercise_repository_impl.dart';
import '../entities/speaking_exercise.dart';

class SubmitSpeakingExercise {
  final SpeakingExerciseRepository repository;

  SubmitSpeakingExercise(this.repository);

  Future<Either<Failure, SpeakingExerciseResult>> call(
    String exerciseId,
    Map<String, String> answers,
  ) async {
    return await repository.submitSpeakingExercise(exerciseId, answers);
  }
}
