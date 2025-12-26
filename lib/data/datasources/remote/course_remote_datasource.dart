import 'package:dio/dio.dart';
import 'package:ilearn/core/constants/api_endpoints.dart';
import 'package:ilearn/core/errors/exceptions.dart';
import 'package:ilearn/core/network/dio_client.dart';
import 'package:ilearn/data/models/course_model.dart';
import 'package:ilearn/data/models/learning_stats_model.dart';

class CourseRemoteDataSource {
  final DioClient _dioClient;

  CourseRemoteDataSource(this._dioClient);

  // Get list of courses
  Future<List<CourseModel>> getCourses({
    String? category,
    String? level,
    String? search,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
        if (category != null) 'category': category,
        if (level != null) 'level': level,
        if (search != null) 'search': search,
      };

      final response = await _dioClient.get(
        ApiEndpoints.courses,
        queryParameters: queryParams,
      );

      final List<dynamic> data = response.data['data'] ?? response.data;
      return data.map((json) => CourseModel.fromJson(json)).toList();
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  // Get my enrolled courses
  Future<List<CourseModel>> getMyCourses() async {
    try {
      final response = await _dioClient.get(ApiEndpoints.myCourses);

      final List<dynamic> data = response.data['data'] ?? response.data;
      return data.map((json) => CourseModel.fromJson(json)).toList();
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  // Get course detail
  Future<CourseDetailModel> getCourseDetail(String courseId) async {
    try {
      final response = await _dioClient.get(
        ApiEndpoints.courseDetail(courseId),
      );

      return CourseDetailModel.fromJson(response.data['data'] ?? response.data);
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  // Enroll in a course
  Future<void> enrollCourse(String courseId) async {
    try {
      await _dioClient.post(ApiEndpoints.courseEnroll(courseId));
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  // Get course progress
  Future<CourseProgressModel> getCourseProgress(String courseId) async {
    try {
      final response = await _dioClient.get(
        ApiEndpoints.courseProgress(courseId),
      );

      return CourseProgressModel.fromJson(
        response.data['data'] ?? response.data,
      );
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  // Get learning statistics
  Future<LearningStatsModel> getLearningStats() async {
    try {
      final response = await _dioClient.get(ApiEndpoints.learningStats);

      return LearningStatsModel.fromJson(
        response.data['data'] ?? response.data,
      );
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  // Get recent activities
  Future<List<ActivityModel>> getRecentActivities({int limit = 5}) async {
    try {
      final response = await _dioClient.get(
        ApiEndpoints.analytics,
        queryParameters: {'type': 'recent_activities', 'limit': limit},
      );

      final List<dynamic> data = response.data['data'] ?? response.data;
      return data.map((json) => ActivityModel.fromJson(json)).toList();
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  void _handleDioError(DioException e) {
    if (e.response?.statusCode == 401) {
      throw UnauthorizedException(
        message: e.response?.data['message'] ?? 'Unauthorized',
      );
    } else if (e.response?.statusCode == 404) {
      throw NotFoundException(
        message: e.response?.data['message'] ?? 'Not found',
      );
    } else if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      throw NetworkException();
    } else {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Server error',
        statusCode: e.response?.statusCode,
      );
    }
  }
}
