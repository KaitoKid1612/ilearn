import 'package:dartz/dartz.dart';
import 'package:ilearn/data/models/lesson_exercise_model.dart';
import 'package:ilearn/domain/repositories/exercise_repository.dart';

class GetLessonExercises {
  final ExerciseRepository repository;

  GetLessonExercises(this.repository);

  Future<Either<String, LessonExerciseListModel>> call(String lessonId) async {
    return await repository.getLessonExercises(lessonId);
  }
}
