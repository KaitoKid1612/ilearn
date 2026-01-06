import 'package:dartz/dartz.dart';
import '../entities/exercise.dart';
import '../repositories/exercise_repository.dart';

class CreateMultipleChoiceExercise {
  final ExerciseRepository repository;

  CreateMultipleChoiceExercise(this.repository);

  Future<Either<String, Exercise>> call(String lessonId) async {
    return await repository.createMultipleChoiceExercise(lessonId);
  }
}
