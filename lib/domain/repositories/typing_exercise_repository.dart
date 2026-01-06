import 'package:dartz/dartz.dart';
import '../../domain/entities/typing_exercise.dart';

abstract class TypingExerciseRepository {
  /// Tạo bài tập typing từ lesson
  Future<Either<String, TypingExercise>> createTypingExercise(
    String lessonId, {
    int limit = 10,
  });

  /// Nộp bài tập typing và nhận kết quả
  Future<Either<String, TypingExerciseResult>> submitTypingExercise(
    String exerciseId,
    Map<String, String> answers,
  );
}
