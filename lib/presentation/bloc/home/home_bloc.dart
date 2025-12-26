import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilearn/data/models/course_model.dart';
import 'package:ilearn/data/models/learning_stats_model.dart';
import 'package:ilearn/data/repositories/course_repository.dart';
import 'package:ilearn/presentation/bloc/home/home_event.dart';
import 'package:ilearn/presentation/bloc/home/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final CourseRepository _courseRepository;

  HomeBloc(this._courseRepository) : super(HomeInitial()) {
    on<LoadHomeData>(_onLoadHomeData);
    on<RefreshHomeData>(_onRefreshHomeData);
  }

  Future<void> _onLoadHomeData(
    LoadHomeData event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());

    try {
      // Load all data in parallel
      final results = await Future.wait([
        _courseRepository.getLearningStats(),
        _courseRepository.getMyCourses(),
        _courseRepository.getRecentActivities(limit: 3),
      ]);

      final stats = results[0] as LearningStatsModel;
      final myCourses = results[1] as List<CourseModel>;
      final activities = results[2] as List<ActivityModel>;

      // Get continue learning (first incomplete course)
      CourseProgressModel? continueLesson;
      if (myCourses.isNotEmpty) {
        final firstIncompleteCourse = myCourses.firstWhere(
          (course) => (course.progress ?? 0) < 100,
          orElse: () => myCourses.first,
        );

        try {
          continueLesson = await _courseRepository.getCourseProgress(
            firstIncompleteCourse.id,
          );
        } catch (e) {
          // If failed to get progress, continue without it
        }
      }

      // Get all courses for categories section
      final allCourses = await _courseRepository.getCourses(limit: 10);

      emit(
        HomeLoaded(
          stats: stats,
          courses: allCourses,
          continueLesson: continueLesson,
          recentActivities: activities,
        ),
      );
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> _onRefreshHomeData(
    RefreshHomeData event,
    Emitter<HomeState> emit,
  ) async {
    // Keep current state while refreshing
    final currentState = state;

    try {
      final results = await Future.wait([
        _courseRepository.getLearningStats(),
        _courseRepository.getMyCourses(),
        _courseRepository.getRecentActivities(limit: 3),
      ]);

      final stats = results[0] as LearningStatsModel;
      final myCourses = results[1] as List<CourseModel>;
      final activities = results[2] as List<ActivityModel>;

      CourseProgressModel? continueLesson;
      if (myCourses.isNotEmpty) {
        final firstIncompleteCourse = myCourses.firstWhere(
          (course) => (course.progress ?? 0) < 100,
          orElse: () => myCourses.first,
        );

        try {
          continueLesson = await _courseRepository.getCourseProgress(
            firstIncompleteCourse.id,
          );
        } catch (e) {
          // Continue without progress
        }
      }

      final allCourses = await _courseRepository.getCourses(limit: 10);

      emit(
        HomeLoaded(
          stats: stats,
          courses: allCourses,
          continueLesson: continueLesson,
          recentActivities: activities,
        ),
      );
    } catch (e) {
      // If refresh fails, restore previous state
      if (currentState is HomeLoaded) {
        emit(currentState);
      } else {
        emit(HomeError(e.toString()));
      }
    }
  }
}
