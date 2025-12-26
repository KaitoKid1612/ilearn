// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseModel _$CourseModelFromJson(Map<String, dynamic> json) => CourseModel(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  thumbnail: json['thumbnail'] as String?,
  level: json['level'] as String,
  category: json['category'] as String,
  totalLessons: (json['totalLessons'] as num).toInt(),
  totalStudents: (json['totalStudents'] as num).toInt(),
  rating: (json['rating'] as num).toDouble(),
  isEnrolled: json['isEnrolled'] as bool? ?? false,
  progress: (json['progress'] as num?)?.toInt(),
  authorId: json['authorId'] as String,
  authorName: json['authorName'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$CourseModelToJson(CourseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'thumbnail': instance.thumbnail,
      'level': instance.level,
      'category': instance.category,
      'totalLessons': instance.totalLessons,
      'totalStudents': instance.totalStudents,
      'rating': instance.rating,
      'isEnrolled': instance.isEnrolled,
      'progress': instance.progress,
      'authorId': instance.authorId,
      'authorName': instance.authorName,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

CourseDetailModel _$CourseDetailModelFromJson(Map<String, dynamic> json) =>
    CourseDetailModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      thumbnail: json['thumbnail'] as String?,
      level: json['level'] as String,
      category: json['category'] as String,
      totalLessons: (json['totalLessons'] as num).toInt(),
      totalStudents: (json['totalStudents'] as num).toInt(),
      rating: (json['rating'] as num).toDouble(),
      isEnrolled: json['isEnrolled'] as bool? ?? false,
      progress: (json['progress'] as num?)?.toInt(),
      authorId: json['authorId'] as String,
      authorName: json['authorName'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      lessons: (json['lessons'] as List<dynamic>)
          .map((e) => LessonModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      objective: json['objective'] as String?,
      requirements: (json['requirements'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CourseDetailModelToJson(CourseDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'thumbnail': instance.thumbnail,
      'level': instance.level,
      'category': instance.category,
      'totalLessons': instance.totalLessons,
      'totalStudents': instance.totalStudents,
      'rating': instance.rating,
      'isEnrolled': instance.isEnrolled,
      'progress': instance.progress,
      'authorId': instance.authorId,
      'authorName': instance.authorName,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'lessons': instance.lessons,
      'objective': instance.objective,
      'requirements': instance.requirements,
      'tags': instance.tags,
    };

LessonModel _$LessonModelFromJson(Map<String, dynamic> json) => LessonModel(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String?,
  courseId: json['courseId'] as String,
  order: (json['order'] as num).toInt(),
  contentType: json['contentType'] as String,
  content: json['content'] as String?,
  videoUrl: json['videoUrl'] as String?,
  audioUrl: json['audioUrl'] as String?,
  duration: (json['duration'] as num).toInt(),
  isCompleted: json['isCompleted'] as bool? ?? false,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$LessonModelToJson(LessonModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'courseId': instance.courseId,
      'order': instance.order,
      'contentType': instance.contentType,
      'content': instance.content,
      'videoUrl': instance.videoUrl,
      'audioUrl': instance.audioUrl,
      'duration': instance.duration,
      'isCompleted': instance.isCompleted,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
