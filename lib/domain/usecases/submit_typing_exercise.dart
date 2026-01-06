import 'package:dartz/dartz.dart';
import '../entities/typing_exercise.dart';
import '../repositories/typing_exercise_repository.dart';

class SubmitTypingExercise {
  final TypingExerciseRepository repository;

  SubmitTypingExercise(this.repository);

  Future<Either<String, TypingExerciseResult>> call(
    String exerciseId,
    Map<String, String> answers,
  ) async {
    return await repository.submitTypingExercise(exerciseId, answers);
  }
}
