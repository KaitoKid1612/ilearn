import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../../data/repositories/speaking_exercise_repository_impl.dart';
import '../entities/speaking_exercise.dart';

class CreateSpeakingExercise {
  final SpeakingExerciseRepository repository;

  CreateSpeakingExercise(this.repository);

  Future<Either<Failure, SpeakingExercise>> call(String lessonId) async {
    return await repository.createSpeakingExercise(lessonId);
  }
}
