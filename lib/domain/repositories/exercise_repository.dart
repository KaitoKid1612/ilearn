import 'package:dartz/dartz.dart';
import '../../domain/entities/exercise.dart';
import '../../data/models/lesson_exercise_model.dart';
import '../../data/models/exercise_session_model.dart';

abstract class ExerciseRepository {
  /// Lấy danh sách bài tập của lesson
  Future<Either<String, LessonExerciseListModel>> getLessonExercises(
    String lessonId,
  );

  /// Tạo bài tập trắc nghiệm từ lesson
  Future<Either<String, Exercise>> createMultipleChoiceExercise(
    String lessonId,
  );

  /// Nộp bài tập và nhận kết quả
  Future<Either<String, ExerciseResult>> submitExercise(
    String exerciseId,
    Map<String, String> answers,
  );

  /// Start exercise session
  Future<Either<String, ExerciseSessionModel>> startExerciseSession(
    String lessonId,
  );

  /// Submit exercise session
  Future<Either<String, ExerciseSessionResultModel>> submitExerciseSession(
    String lessonId,
    String sessionId,
    Map<String, String> answers,
  );
}
