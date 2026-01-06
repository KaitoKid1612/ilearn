import 'package:dio/dio.dart';
import 'package:ilearn/core/constants/api_endpoints.dart';
import 'package:ilearn/data/models/flashcard_model.dart';

/// Datasource cho Flashcard API
class FlashcardRemoteDataSource {
  final Dio dio;

  FlashcardRemoteDataSource({required this.dio});

  /// Lấy flashcard set của lesson
  Future<FlashcardSetModel> getFlashcardsByLesson(String lessonId) async {
    try {
      final response = await dio.get(ApiEndpoints.flashcardsByLesson(lessonId));
      return FlashcardSetModel.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  /// Bắt đầu session học flashcard
  Future<Map<String, dynamic>> startStudySession(String lessonId) async {
    try {
      final response = await dio.post(
        ApiEndpoints.flashcardStartStudy(lessonId),
      );
      return response.data as Map<String, dynamic>;
    } catch (e) {
      rethrow;
    }
  }

  /// Trả lời flashcard với isRemembered (true: nhớ, false: chưa nhớ)
  Future<FlashcardAnswerResponse> answerFlashcard({
    required String flashcardId,
    required bool isRemembered,
  }) async {
    try {
      final response = await dio.post(
        ApiEndpoints.flashcardAnswer(flashcardId),
        data: {'isRemembered': isRemembered},
      );
      return FlashcardAnswerResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Lấy flashcards cần ôn tập hàng ngày
  Future<FlashcardSetModel> getDailyReview() async {
    try {
      final response = await dio.get(ApiEndpoints.flashcardDailyReview);
      return FlashcardSetModel.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }
}
