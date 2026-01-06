import 'package:ilearn/core/network/dio_client.dart';
import 'package:ilearn/core/constants/api_endpoints.dart';
import 'package:ilearn/data/models/dashboard_model.dart';
import 'package:ilearn/data/models/roadmap_model.dart';
import 'package:ilearn/data/models/lesson_detail_model.dart';
import 'package:ilearn/data/models/lesson_vocabulary_model.dart';

class LearningRemoteDataSource {
  final DioClient _dioClient;

  LearningRemoteDataSource(this._dioClient);

  /// Get dashboard data (stats, current textbook, challenges, achievements)
  Future<DashboardResponseModel> getDashboard() async {
    try {
      final response = await _dioClient.get(ApiEndpoints.dashboard);
      final data = response.data['data'] as Map<String, dynamic>;
      return DashboardResponseModel.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }

  /// Get textbook roadmap with units and lessons
  Future<RoadmapResponseModel> getTextbookRoadmap(String textbookId) async {
    try {
      final response = await _dioClient.get(
        ApiEndpoints.textbookRoadmap(textbookId),
      );
      return RoadmapResponseModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  /// Get lesson detail with components
  Future<LessonDetailModel> getLessonDetail(String lessonId) async {
    try {
      final response = await _dioClient.get(
        ApiEndpoints.lessonDetail(lessonId),
      );
      final data = response.data['data'] as Map<String, dynamic>;
      return LessonDetailModel.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }

  /// Get lesson vocabulary
  Future<LessonVocabularyDataModel> getLessonVocabulary(String lessonId) async {
    try {
      final response = await _dioClient.get(
        ApiEndpoints.lessonVocabulary(lessonId),
      );
      final responseModel = LessonVocabularyResponseModel.fromJson(
        response.data,
      );
      return responseModel.data;
    } catch (e) {
      rethrow;
    }
  }
}
