import 'package:equatable/equatable.dart';
import 'package:ilearn/data/models/course_model.dart';
import 'package:ilearn/data/models/learning_stats_model.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final LearningStatsModel stats;
  final List<CourseModel> courses;
  final CourseProgressModel? continueLesson;
  final List<ActivityModel> recentActivities;

  const HomeLoaded({
    required this.stats,
    required this.courses,
    this.continueLesson,
    required this.recentActivities,
  });

  @override
  List<Object?> get props => [stats, courses, continueLesson, recentActivities];

  HomeLoaded copyWith({
    LearningStatsModel? stats,
    List<CourseModel>? courses,
    CourseProgressModel? continueLesson,
    List<ActivityModel>? recentActivities,
  }) {
    return HomeLoaded(
      stats: stats ?? this.stats,
      courses: courses ?? this.courses,
      continueLesson: continueLesson ?? this.continueLesson,
      recentActivities: recentActivities ?? this.recentActivities,
    );
  }
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
