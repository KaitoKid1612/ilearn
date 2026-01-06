import 'package:dartz/dartz.dart';
import '../entities/typing_exercise.dart';
import '../repositories/typing_exercise_repository.dart';

class CreateTypingExercise {
  final TypingExerciseRepository repository;

  CreateTypingExercise(this.repository);

  Future<Either<String, TypingExercise>> call(
    String lessonId, {
    int limit = 10,
  }) async {
    return await repository.createTypingExercise(lessonId, limit: limit);
  }
}
