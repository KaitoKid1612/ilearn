import 'package:dartz/dartz.dart';
import '../entities/exercise.dart';
import '../repositories/exercise_repository.dart';

class SubmitExercise {
  final ExerciseRepository repository;

  SubmitExercise(this.repository);

  Future<Either<String, ExerciseResult>> call(
    String exerciseId,
    Map<String, String> answers,
  ) async {
    return await repository.submitExercise(exerciseId, answers);
  }
}
