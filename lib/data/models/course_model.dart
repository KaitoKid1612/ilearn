import 'package:json_annotation/json_annotation.dart';

part 'course_model.g.dart';

@JsonSerializable()
class CourseModel {
  final String id;
  final String title;
  final String description;
  final String? thumbnail;
  final String level; // beginner, intermediate, advanced
  final String category;
  final int totalLessons;
  final int totalStudents;
  final double rating;
  final bool isEnrolled;
  final int? progress; // 0-100
  final String authorId;
  final String authorName;
  final DateTime createdAt;
  final DateTime updatedAt;

  CourseModel({
    required this.id,
    required this.title,
    required this.description,
    this.thumbnail,
    required this.level,
    required this.category,
    required this.totalLessons,
    required this.totalStudents,
    required this.rating,
    this.isEnrolled = false,
    this.progress,
    required this.authorId,
    required this.authorName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) =>
      _$CourseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseModelToJson(this);
}

@JsonSerializable()
class CourseDetailModel extends CourseModel {
  final List<LessonModel> lessons;
  final String? objective;
  final List<String>? requirements;
  final List<String>? tags;

  CourseDetailModel({
    required super.id,
    required super.title,
    required super.description,
    super.thumbnail,
    required super.level,
    required super.category,
    required super.totalLessons,
    required super.totalStudents,
    required super.rating,
    super.isEnrolled,
    super.progress,
    required super.authorId,
    required super.authorName,
    required super.createdAt,
    required super.updatedAt,
    required this.lessons,
    this.objective,
    this.requirements,
    this.tags,
  });

  factory CourseDetailModel.fromJson(Map<String, dynamic> json) =>
      _$CourseDetailModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CourseDetailModelToJson(this);
}

@JsonSerializable()
class LessonModel {
  final String id;
  final String title;
  final String? description;
  final String courseId;
  final int order;
  final String contentType; // text, video, audio
  final String? content;
  final String? videoUrl;
  final String? audioUrl;
  final int duration; // in minutes
  final bool isCompleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  LessonModel({
    required this.id,
    required this.title,
    this.description,
    required this.courseId,
    required this.order,
    required this.contentType,
    this.content,
    this.videoUrl,
    this.audioUrl,
    required this.duration,
    this.isCompleted = false,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) =>
      _$LessonModelFromJson(json);

  Map<String, dynamic> toJson() => _$LessonModelToJson(this);
}
