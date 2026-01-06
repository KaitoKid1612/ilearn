import 'package:ilearn/core/network/dio_client.dart';
import 'package:ilearn/data/models/vocabulary_model.dart';
import 'package:ilearn/data/models/vocabulary_progress_model.dart';
import 'package:ilearn/core/constants/api_endpoints.dart';

abstract class VocabularyRemoteDataSource {
  Future<VocabularyLessonDataModel> getLessonVocabulary(String lessonId);
  Future<VocabularyProgressModel?> getVocabularyProgress(String lessonId);
  Future<void> submitProgress(
    String lessonId,
    Map<String, dynamic> progressData,
  );
  Future<void> markItemLearned({
    required String lessonId,
    required String itemId,
    required String itemType,
  });
  Future<void> batchMarkLearned({
    required String lessonId,
    required String itemType,
    required List<String> itemIds,
  });
}

class VocabularyRemoteDataSourceImpl implements VocabularyRemoteDataSource {
  final DioClient dioClient;

  VocabularyRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<VocabularyLessonDataModel> getLessonVocabulary(String lessonId) async {
    try {
      final response = await dioClient.get(
        '/api/v1/lessons/$lessonId/vocabulary',
      );

      final vocabularyResponse = VocabularyLessonResponse.fromJson(
        response.data,
      );

      if (!vocabularyResponse.success) {
        throw Exception(vocabularyResponse.message);
      }

      return vocabularyResponse.data;
    } catch (e) {
      throw Exception('Failed to load vocabulary: $e');
    }
  }

  @override
  Future<VocabularyProgressModel?> getVocabularyProgress(
    String lessonId,
  ) async {
    try {
      final response = await dioClient.get(
        '/api/v1/lessons/$lessonId/vocabulary/progress',
      );

      final progressResponse = VocabularyProgressResponse.fromJson(
        response.data,
      );

      if (!progressResponse.success) {
        return null;
      }

      return progressResponse.data;
    } catch (e) {
      // Return null if user hasn't started learning or not logged in
      return null;
    }
  }

  @override
  Future<void> submitProgress(
    String lessonId,
    Map<String, dynamic> progressData,
  ) async {
    try {
      final response = await dioClient.post(
        '/api/v1/lessons/$lessonId/vocabulary/submit-progress',
        data: progressData,
      );

      if (response.data['success'] != true) {
        throw Exception(
          response.data['message'] ?? 'Failed to submit progress',
        );
      }
    } catch (e) {
      throw Exception('Failed to submit progress: $e');
    }
  }

  @override
  Future<void> markItemLearned({
    required String lessonId,
    required String itemId,
    required String itemType,
  }) async {
    try {
      final response = await dioClient.post(
        ApiEndpoints.markItemLearned(lessonId),
        data: {'itemId': itemId, 'itemType': itemType},
      );

      if (response.data['success'] != true) {
        throw Exception(
          response.data['message'] ?? 'Failed to mark item as learned',
        );
      }
    } catch (e) {
      throw Exception('Failed to mark item as learned: $e');
    }
  }

  @override
  Future<void> batchMarkLearned({
    required String lessonId,
    required String itemType,
    required List<String> itemIds,
  }) async {
    try {
      final response = await dioClient.post(
        ApiEndpoints.batchMarkLearned(lessonId),
        data: {'itemType': itemType, 'itemIds': itemIds},
      );

      if (response.data['success'] != true) {
        throw Exception(
          response.data['message'] ?? 'Failed to batch mark items as learned',
        );
      }
    } catch (e) {
      throw Exception('Failed to batch mark items as learned: $e');
    }
  }
}
