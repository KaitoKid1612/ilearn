// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roadmap_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoadmapResponseModel _$RoadmapResponseModelFromJson(
  Map<String, dynamic> json,
) => RoadmapResponseModel(
  success: json['success'] as bool,
  data: RoadmapDataModel.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$RoadmapResponseModelToJson(
  RoadmapResponseModel instance,
) => <String, dynamic>{'success': instance.success, 'data': instance.data};

RoadmapDataModel _$RoadmapDataModelFromJson(Map<String, dynamic> json) =>
    RoadmapDataModel(
      textbook: TextbookModel.fromJson(
        json['textbook'] as Map<String, dynamic>,
      ),
      units: (json['units'] as List<dynamic>)
          .map((e) => UnitModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RoadmapDataModelToJson(RoadmapDataModel instance) =>
    <String, dynamic>{'textbook': instance.textbook, 'units': instance.units};

TextbookModel _$TextbookModelFromJson(Map<String, dynamic> json) =>
    TextbookModel(
      id: json['id'] as String,
      title: json['title'] as String,
      level: json['level'] as String,
      description: json['description'] as String,
      thumbnail: json['thumbnail'] as String?,
    );

Map<String, dynamic> _$TextbookModelToJson(TextbookModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'level': instance.level,
      'description': instance.description,
      'thumbnail': instance.thumbnail,
    };

UnitModel _$UnitModelFromJson(Map<String, dynamic> json) => UnitModel(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  thumbnail: json['thumbnail'] as String?,
  order: (json['order'] as num).toInt(),
  requiredXP: (json['requiredXP'] as num).toInt(),
  isLocked: json['isLocked'] as bool,
  unlockRequirement: json['unlockRequirement'] as String?,
  lessons: (json['lessons'] as List<dynamic>)
      .map((e) => LessonModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  progress: ProgressModel.fromJson(json['progress'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UnitModelToJson(UnitModel instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'thumbnail': instance.thumbnail,
  'order': instance.order,
  'requiredXP': instance.requiredXP,
  'isLocked': instance.isLocked,
  'unlockRequirement': instance.unlockRequirement,
  'lessons': instance.lessons,
  'progress': instance.progress,
};

LessonModel _$LessonModelFromJson(Map<String, dynamic> json) => LessonModel(
  id: json['id'] as String,
  title: json['title'] as String,
  type: json['type'] as String,
  order: (json['order'] as num).toInt(),
  xpReward: (json['xpReward'] as num).toInt(),
  duration: (json['duration'] as num).toInt(),
  status: json['status'] as String,
  score: (json['score'] as num).toInt(),
  stars: (json['stars'] as num).toInt(),
  attempts: (json['attempts'] as num).toInt(),
  isLocked: json['isLocked'] as bool,
  unlockRequirement: json['unlockRequirement'] as String?,
);

Map<String, dynamic> _$LessonModelToJson(LessonModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'type': instance.type,
      'order': instance.order,
      'xpReward': instance.xpReward,
      'duration': instance.duration,
      'status': instance.status,
      'score': instance.score,
      'stars': instance.stars,
      'attempts': instance.attempts,
      'isLocked': instance.isLocked,
      'unlockRequirement': instance.unlockRequirement,
    };

ProgressModel _$ProgressModelFromJson(Map<String, dynamic> json) =>
    ProgressModel(
      completed: (json['completed'] as num).toInt(),
      total: (json['total'] as num).toInt(),
      percentage: (json['percentage'] as num).toInt(),
    );

Map<String, dynamic> _$ProgressModelToJson(ProgressModel instance) =>
    <String, dynamic>{
      'completed': instance.completed,
      'total': instance.total,
      'percentage': instance.percentage,
    };
