import 'package:dio/dio.dart';
import 'package:ilearn/data/models/grammar_model.dart';

abstract class GrammarRepository {
  Future<GrammarListResponseModel> getGrammarList(String lessonId);
  Future<GrammarDetailResponseModel> getGrammarDetail(
    String lessonId,
    String grammarId,
  );
  Future<MarkLearnedResponseModel> markAsLearned(
    String lessonId,
    String itemId,
    String itemType,
  );
}

class GrammarRepositoryImpl implements GrammarRepository {
  final Dio dio;

  GrammarRepositoryImpl({required this.dio});

  @override
  Future<GrammarListResponseModel> getGrammarList(String lessonId) async {
    try {
      final response = await dio.get('/api/v1/lessons/$lessonId/grammar');
      if (response.data == null) {
        throw Exception('Response data is null');
      }
      return GrammarListResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to load grammar list: ${e.message}');
    } catch (e) {
      throw Exception('Failed to load grammar list: $e');
    }
  }

  @override
  Future<GrammarDetailResponseModel> getGrammarDetail(
    String lessonId,
    String grammarId,
  ) async {
    try {
      final response = await dio.get(
        '/api/v1/lessons/$lessonId/grammar/$grammarId',
      );
      if (response.data == null) {
        throw Exception('Response data is null');
      }
      return GrammarDetailResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to load grammar detail: ${e.message}');
    } catch (e) {
      throw Exception('Failed to load grammar detail: $e');
    }
  }

  @override
  Future<MarkLearnedResponseModel> markAsLearned(
    String lessonId,
    String itemId,
    String itemType,
  ) async {
    try {
      final response = await dio.post(
        '/api/v1/lessons/$lessonId/mark-learned',
        data: {'itemId': itemId, 'itemType': itemType},
      );

      // Check if the response indicates success
      if (response.data is Map<String, dynamic>) {
        final success = response.data['success'] == true;
        if (!success) {
          throw Exception(
            response.data['message'] ?? 'Failed to mark as learned',
          );
        }

        // Extract xpEarned safely
        final xpEarned = response.data['xpEarned'] is int
            ? response.data['xpEarned'] as int
            : 0;

        // Return a simplified response without parsing progress data
        // Note: progress field from API is lesson-level progress {vocabulary, kanji, grammar, exercises, overall}
        // which doesn't match GrammarProgressModel structure, so we skip it
        return MarkLearnedResponseModel(
          success: true,
          statusCode: response.statusCode ?? 200,
          data: MarkLearnedDataModel(
            message: response.data['message'] ?? 'Đã đánh dấu thành công',
            xpEarned: xpEarned,
            progress: null, // Don't parse lesson-level progress
          ),
        );
      }

      throw Exception('Invalid response format');
    } catch (e) {
      throw Exception('Failed to mark as learned: $e');
    }
  }
}
