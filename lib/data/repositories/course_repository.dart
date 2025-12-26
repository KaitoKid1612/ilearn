import 'package:ilearn/data/datasources/remote/course_remote_datasource.dart';
import 'package:ilearn/data/models/course_model.dart';
import 'package:ilearn/data/models/learning_stats_model.dart';

class CourseRepository {
  final CourseRemoteDataSource _remoteDataSource;

  CourseRepository(this._remoteDataSource);

  Future<List<CourseModel>> getCourses({
    String? category,
    String? level,
    String? search,
    int page = 1,
    int limit = 10,
  }) async {
    return await _remoteDataSource.getCourses(
      category: category,
      level: level,
      search: search,
      page: page,
      limit: limit,
    );
  }

  Future<List<CourseModel>> getMyCourses() async {
    return await _remoteDataSource.getMyCourses();
  }

  Future<CourseDetailModel> getCourseDetail(String courseId) async {
    return await _remoteDataSource.getCourseDetail(courseId);
  }

  Future<void> enrollCourse(String courseId) async {
    return await _remoteDataSource.enrollCourse(courseId);
  }

  Future<CourseProgressModel> getCourseProgress(String courseId) async {
    return await _remoteDataSource.getCourseProgress(courseId);
  }

  Future<LearningStatsModel> getLearningStats() async {
    return await _remoteDataSource.getLearningStats();
  }

  Future<List<ActivityModel>> getRecentActivities({int limit = 5}) async {
    return await _remoteDataSource.getRecentActivities(limit: limit);
  }
}
