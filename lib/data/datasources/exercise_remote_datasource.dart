import 'package:dio/dio.dart';
import '../../core/constants/api_endpoints.dart';
import '../models/exercise_model.dart';
import '../models/lesson_exercise_model.dart';
import '../models/exercise_session_model.dart';

abstract class ExerciseRemoteDataSource {
  /// Lấy danh sách bài tập của lesson
  Future<LessonExerciseListModel> getLessonExercises(String lessonId);

  /// Tạo bài tập trắc nghiệm từ lesson
  Future<ExerciseModel> createMultipleChoiceExercise(String lessonId);

  /// Nộp bài tập và nhận kết quả
  Future<ExerciseResultModel> submitExercise(
    String exerciseId,
    Map<String, String> answers,
  );

  /// Start exercise session
  Future<ExerciseSessionModel> startExerciseSession(String lessonId);

  /// Submit exercise session
  Future<ExerciseSessionResultModel> submitExerciseSession(
    String lessonId,
    String sessionId,
    Map<String, String> answers,
  );
}

class ExerciseRemoteDataSourceImpl implements ExerciseRemoteDataSource {
  final Dio dio;

  ExerciseRemoteDataSourceImpl({required this.dio});

  @override
  Future<LessonExerciseListModel> getLessonExercises(String lessonId) async {
    try {
      final response = await dio.get(ApiEndpoints.lessonExercises(lessonId));

      final data = response.data;
      if (data == null) {
        throw Exception('No data received from server');
      }

      // Extract data from wrapper if exists
      final exerciseData =
          data is Map<String, dynamic> && data.containsKey('data')
          ? data['data'] as Map<String, dynamic>
          : data as Map<String, dynamic>;

      return LessonExerciseListModel.fromJson(exerciseData);
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      print('Response: ${e.response?.data}');
      throw Exception('Failed to get lesson exercises: ${e.message}');
    } catch (e) {
      print('Error getting lesson exercises: $e');
      rethrow;
    }
  }

  @override
  Future<ExerciseModel> createMultipleChoiceExercise(String lessonId) async {
    try {
      final response = await dio.post(
        ApiEndpoints.createMultipleChoiceExercise(lessonId),
      );

      final data = response.data;
      print('Exercise Response: $data');
      print('Exercise Response Type: ${data.runtimeType}');

      if (data == null) {
        throw Exception('No data received from server');
      }

      // Extract data from wrapper if exists
      final exerciseData =
          data is Map<String, dynamic> && data.containsKey('data')
          ? data['data'] as Map<String, dynamic>
          : data as Map<String, dynamic>;

      print('Extracted Exercise Data: $exerciseData');

      return ExerciseModel.fromJson(exerciseData);
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      print('Response: ${e.response?.data}');
      throw Exception('Failed to create exercise: ${e.message}');
    } catch (e) {
      print('Error creating exercise: $e');
      rethrow;
    }
  }

  @override
  Future<ExerciseResultModel> submitExercise(
    String exerciseId,
    Map<String, String> answers,
  ) async {
    try {
      // Convert Map to array format expected by backend
      final answersArray = answers.entries
          .map((entry) => {'questionId': entry.key, 'answerId': entry.value})
          .toList();

      print('Submitting answers: $answersArray');
      final response = await dio.post(
        ApiEndpoints.submitExercise(exerciseId),
        data: {'answers': answersArray},
      );

      final data = response.data;
      print('Submit Response: $data');
      print('Submit Response Type: ${data.runtimeType}');

      if (data == null) {
        throw Exception('No data received from server');
      }

      // Extract data from wrapper if exists
      final resultData =
          data is Map<String, dynamic> && data.containsKey('data')
          ? data['data'] as Map<String, dynamic>
          : data as Map<String, dynamic>;

      print('Extracted Result Data: $resultData');

      return ExerciseResultModel.fromJson(resultData);
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      print('Response: ${e.response?.data}');
      throw Exception('Failed to submit exercise: ${e.message}');
    } catch (e) {
      print('Error submitting exercise: $e');
      rethrow;
    }
  }

  @override
  Future<ExerciseSessionModel> startExerciseSession(String lessonId) async {
    try {
      final response = await dio.post(
        ApiEndpoints.startExerciseSession(lessonId),
      );

      final data = response.data;
      if (data == null) {
        throw Exception('No data received from server');
      }

      // Extract data from wrapper if exists
      final sessionData =
          data is Map<String, dynamic> && data.containsKey('data')
          ? data['data'] as Map<String, dynamic>
          : data as Map<String, dynamic>;

      return ExerciseSessionModel.fromJson(sessionData);
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      print('Response: ${e.response?.data}');
      throw Exception('Failed to start exercise session: ${e.message}');
    } catch (e) {
      print('Error starting exercise session: $e');
      rethrow;
    }
  }

  @override
  Future<ExerciseSessionResultModel> submitExerciseSession(
    String lessonId,
    String sessionId,
    Map<String, String> answers,
  ) async {
    try {
      // Convert answers to array format
      final answersArray = answers.entries
          .map((entry) => {'exerciseId': entry.key, 'answer': entry.value})
          .toList();

      print('Submitting answers array: $answersArray');

      final response = await dio.post(
        ApiEndpoints.submitExerciseSession(lessonId, sessionId),
        data: {'answers': answersArray},
      );

      final data = response.data;
      if (data == null) {
        throw Exception('No data received from server');
      }

      // Extract data from wrapper if exists
      final resultData =
          data is Map<String, dynamic> && data.containsKey('data')
          ? data['data'] as Map<String, dynamic>
          : data as Map<String, dynamic>;

      return ExerciseSessionResultModel.fromJson(resultData);
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      print('Response: ${e.response?.data}');
      throw Exception('Failed to submit exercise session: ${e.message}');
    } catch (e) {
      print('Error submitting exercise session: $e');
      rethrow;
    }
  }
}
