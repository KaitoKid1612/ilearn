import 'package:dio/dio.dart';
import 'package:ilearn/data/models/grammar_practice_model.dart';

abstract class GrammarPracticeRepository {
  /// Create grammar practice exercise for a specific grammar point
  Future<GrammarPracticeResponseModel> createGrammarPractice(String grammarId);

  /// Create grammar practice exercise for entire lesson
  Future<GrammarPracticeResponseModel> createLessonPractice(String lessonId);

  /// Submit grammar practice answers
  Future<SubmitGrammarPracticeResponseModel> submitPractice(
    String exerciseId,
    Map<String, dynamic> answers,
  );

  /// Get grammar practice progress for lesson
  Future<GrammarPracticeProgressResponseModel> getLessonProgress(
    String lessonId,
  );
}

class GrammarPracticeRepositoryImpl implements GrammarPracticeRepository {
  final Dio dio;

  GrammarPracticeRepositoryImpl({required this.dio});

  @override
  Future<GrammarPracticeResponseModel> createGrammarPractice(
    String grammarId,
  ) async {
    try {
      final response = await dio.post(
        '/api/v1/grammar-practice/grammar/$grammarId',
      );
      if (response.data == null) {
        throw Exception('Response data is null');
      }
      return GrammarPracticeResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to create grammar practice: ${e.message}');
    } catch (e) {
      throw Exception('Failed to create grammar practice: $e');
    }
  }

  @override
  Future<GrammarPracticeResponseModel> createLessonPractice(
    String lessonId,
  ) async {
    try {
      final response = await dio.post(
        '/api/v1/grammar-practice/lessons/$lessonId',
      );
      if (response.data == null) {
        throw Exception('Response data is null');
      }
      return GrammarPracticeResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to create lesson practice: ${e.message}');
    } catch (e) {
      throw Exception('Failed to create lesson practice: $e');
    }
  }

  @override
  Future<SubmitGrammarPracticeResponseModel> submitPractice(
    String exerciseId,
    Map<String, dynamic> answers,
  ) async {
    try {
      final response = await dio.post(
        '/api/v1/grammar-practice/$exerciseId/submit',
        data: {'answers': answers},
      );
      if (response.data == null) {
        throw Exception('Response data is null');
      }
      return SubmitGrammarPracticeResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to submit practice: ${e.message}');
    } catch (e) {
      throw Exception('Failed to submit practice: $e');
    }
  }

  @override
  Future<GrammarPracticeProgressResponseModel> getLessonProgress(
    String lessonId,
  ) async {
    try {
      final response = await dio.get(
        '/api/v1/grammar-practice/lessons/$lessonId/progress',
      );
      if (response.data == null) {
        throw Exception('Response data is null');
      }
      return GrammarPracticeProgressResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to get lesson progress: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get lesson progress: $e');
    }
  }
}
