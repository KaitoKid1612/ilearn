import 'package:dio/dio.dart';
import '../../core/constants/api_endpoints.dart';
import '../models/typing_exercise_model.dart';

abstract class TypingExerciseRemoteDataSource {
  /// Tạo bài tập typing từ lesson
  Future<TypingExerciseModel> createTypingExercise(
    String lessonId, {
    int limit = 10,
  });

  /// Nộp bài tập typing và nhận kết quả
  Future<TypingExerciseResultModel> submitTypingExercise(
    String exerciseId,
    Map<String, String> answers,
  );
}

class TypingExerciseRemoteDataSourceImpl
    implements TypingExerciseRemoteDataSource {
  final Dio dio;

  TypingExerciseRemoteDataSourceImpl({required this.dio});

  @override
  Future<TypingExerciseModel> createTypingExercise(
    String lessonId, {
    int limit = 10,
  }) async {
    try {
      final response = await dio.post(
        ApiEndpoints.createTypingExercise(lessonId, limit: limit),
      );

      final data = response.data;
      print('Typing Exercise Response: $data');

      if (data == null) {
        throw Exception('No data received from server');
      }

      // Extract data from wrapper if exists
      final exerciseData =
          data is Map<String, dynamic> && data.containsKey('data')
          ? data['data'] as Map<String, dynamic>
          : data as Map<String, dynamic>;

      return TypingExerciseModel.fromJson(exerciseData);
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      print('Response: ${e.response?.data}');
      throw Exception('Failed to create typing exercise: ${e.message}');
    } catch (e) {
      print('Error creating typing exercise: $e');
      rethrow;
    }
  }

  @override
  Future<TypingExerciseResultModel> submitTypingExercise(
    String exerciseId,
    Map<String, String> answers,
  ) async {
    try {
      // Convert Map to array format expected by backend
      final answersArray = answers.entries
          .map((entry) => {'questionId': entry.key, 'userAnswer': entry.value})
          .toList();

      print('Submitting typing answers: $answersArray');
      final response = await dio.post(
        ApiEndpoints.submitTypingExercise(exerciseId),
        data: {'answers': answersArray},
      );

      final data = response.data;
      print('Submit Typing Response: $data');

      if (data == null) {
        throw Exception('No data received from server');
      }

      // Extract data from wrapper if exists
      final resultData =
          data is Map<String, dynamic> && data.containsKey('data')
          ? data['data'] as Map<String, dynamic>
          : data as Map<String, dynamic>;

      return TypingExerciseResultModel.fromJson(resultData);
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      print('Response: ${e.response?.data}');
      throw Exception('Failed to submit typing exercise: ${e.message}');
    } catch (e) {
      print('Error submitting typing exercise: $e');
      rethrow;
    }
  }
}
