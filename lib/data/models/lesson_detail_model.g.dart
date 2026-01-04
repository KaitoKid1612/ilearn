// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LessonDetailResponseModel _$LessonDetailResponseModelFromJson(
  Map<String, dynamic> json,
) => LessonDetailResponseModel(
  lesson: LessonDetailModel.fromJson(json['lesson'] as Map<String, dynamic>),
);

Map<String, dynamic> _$LessonDetailResponseModelToJson(
  LessonDetailResponseModel instance,
) => <String, dynamic>{'lesson': instance.lesson.toJson()};

LessonDetailModel _$LessonDetailModelFromJson(Map<String, dynamic> json) =>
    LessonDetailModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      unit: UnitInfoModel.fromJson(json['unit'] as Map<String, dynamic>),
      isLocked: json['isLocked'] as bool,
      isCompleted: json['isCompleted'] as bool,
      isCurrent: json['isCurrent'] as bool,
      overallProgress: (json['overallProgress'] as num).toInt(),
      components: ComponentsModel.fromJson(
        json['components'] as Map<String, dynamic>,
      ),
      prerequisites: (json['prerequisites'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      nextLesson: json['nextLesson'] as String?,
    );

Map<String, dynamic> _$LessonDetailModelToJson(LessonDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'unit': instance.unit.toJson(),
      'isLocked': instance.isLocked,
      'isCompleted': instance.isCompleted,
      'isCurrent': instance.isCurrent,
      'overallProgress': instance.overallProgress,
      'components': instance.components.toJson(),
      'prerequisites': instance.prerequisites,
      if (instance.nextLesson case final value?) 'nextLesson': value,
    };

UnitInfoModel _$UnitInfoModelFromJson(Map<String, dynamic> json) =>
    UnitInfoModel(id: json['id'] as String, title: json['title'] as String);

Map<String, dynamic> _$UnitInfoModelToJson(UnitInfoModel instance) =>
    <String, dynamic>{'id': instance.id, 'title': instance.title};

ComponentsModel _$ComponentsModelFromJson(Map<String, dynamic> json) =>
    ComponentsModel(
      vocabulary: ComponentDetailModel.fromJson(
        json['vocabulary'] as Map<String, dynamic>,
      ),
      grammar: ComponentDetailModel.fromJson(
        json['grammar'] as Map<String, dynamic>,
      ),
      kanji: ComponentDetailModel.fromJson(
        json['kanji'] as Map<String, dynamic>,
      ),
      exercises: ComponentDetailModel.fromJson(
        json['exercises'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$ComponentsModelToJson(ComponentsModel instance) =>
    <String, dynamic>{
      'vocabulary': instance.vocabulary.toJson(),
      'grammar': instance.grammar.toJson(),
      'kanji': instance.kanji.toJson(),
      'exercises': instance.exercises.toJson(),
    };

ComponentDetailModel _$ComponentDetailModelFromJson(
  Map<String, dynamic> json,
) => ComponentDetailModel(
  id: json['id'] as String,
  total: (json['total'] as num).toInt(),
  completed: (json['completed'] as num).toInt(),
  percentage: (json['percentage'] as num).toInt(),
  isUnlocked: json['isUnlocked'] as bool,
);

Map<String, dynamic> _$ComponentDetailModelToJson(
  ComponentDetailModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'total': instance.total,
  'completed': instance.completed,
  'percentage': instance.percentage,
  'isUnlocked': instance.isUnlocked,
};
