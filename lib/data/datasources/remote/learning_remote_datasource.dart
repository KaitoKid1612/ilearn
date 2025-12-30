import 'package:ilearn/core/network/dio_client.dart';
import 'package:ilearn/core/constants/api_endpoints.dart';
import 'package:ilearn/data/models/dashboard_model.dart';
import 'package:ilearn/data/models/roadmap_model.dart';

class LearningRemoteDataSource {
  final DioClient _dioClient;

  LearningRemoteDataSource(this._dioClient);

  /// Get dashboard data (stats, current textbook, challenges, achievements)
  Future<DashboardResponseModel> getDashboard() async {
    try {
      final response = await _dioClient.get(ApiEndpoints.dashboard);
      return DashboardResponseModel.fromJson(response.data);
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
}
