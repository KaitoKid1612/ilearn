import 'package:ilearn/core/network/dio_client.dart';
import 'package:ilearn/data/models/kanji_model.dart';
import 'package:ilearn/core/constants/api_endpoints.dart';

abstract class KanjiRemoteDataSource {
  Future<KanjiLessonDataModel> getLessonKanji(String lessonId);
  Future<void> markKanjiLearned({
    required String lessonId,
    required String kanjiId,
  });
}

class KanjiRemoteDataSourceImpl implements KanjiRemoteDataSource {
  final DioClient dioClient;

  KanjiRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<KanjiLessonDataModel> getLessonKanji(String lessonId) async {
    try {
      final response = await dioClient.get(ApiEndpoints.lessonKanji(lessonId));

      // If the response has a standard success/message/data structure
      if (response.data is Map<String, dynamic> &&
          response.data.containsKey('data')) {
        final responseModel = KanjiLessonResponse.fromJson(response.data);
        return responseModel.data;
      }

      // If the response is directly the data
      return KanjiLessonDataModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> markKanjiLearned({
    required String lessonId,
    required String kanjiId,
  }) async {
    try {
      final response = await dioClient.post(
        ApiEndpoints.markItemLearned(lessonId),
        data: {'itemId': kanjiId, 'itemType': 'KANJI'},
      );

      // Check if the response indicates success
      if (response.data is Map<String, dynamic> &&
          response.data['success'] != true) {
        throw Exception(
          response.data['message'] ?? 'Failed to mark kanji as learned',
        );
      }
    } catch (e) {
      throw Exception('Failed to mark kanji as learned: $e');
    }
  }
}
