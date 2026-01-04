import 'package:json_annotation/json_annotation.dart';

part 'lesson_detail_model.g.dart';

// Lesson Detail Response
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LessonDetailResponseModel {
  final LessonDetailModel lesson;

  const LessonDetailResponseModel({required this.lesson});

  factory LessonDetailResponseModel.fromJson(Map<String, dynamic> json) {
    // Handle nested "data" field from API response
    final data = json['data'] as Map<String, dynamic>?;
    return LessonDetailResponseModel(
      lesson: LessonDetailModel.fromJson(data ?? json),
    );
  }

  Map<String, dynamic> toJson() => _$LessonDetailResponseModelToJson(this);
}

// Lesson Detail Model
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LessonDetailModel {
  final String id;
  final String title;
  final String description;
  final UnitInfoModel unit;
  final bool isLocked;
  final bool isCompleted;
  final bool isCurrent;
  final int overallProgress;
  final ComponentsModel components;
  final List<String> prerequisites;
  final String? nextLesson;

  const LessonDetailModel({
    required this.id,
    required this.title,
    required this.description,
    required this.unit,
    required this.isLocked,
    required this.isCompleted,
    required this.isCurrent,
    required this.overallProgress,
    required this.components,
    required this.prerequisites,
    this.nextLesson,
  });

  factory LessonDetailModel.fromJson(Map<String, dynamic> json) =>
      _$LessonDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$LessonDetailModelToJson(this);
}

// Unit Info Model
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class UnitInfoModel {
  final String id;
  final String title;

  const UnitInfoModel({required this.id, required this.title});

  factory UnitInfoModel.fromJson(Map<String, dynamic> json) =>
      _$UnitInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$UnitInfoModelToJson(this);
}

// Components Model
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ComponentsModel {
  final ComponentDetailModel vocabulary;
  final ComponentDetailModel grammar;
  final ComponentDetailModel kanji;
  final ComponentDetailModel exercises;

  const ComponentsModel({
    required this.vocabulary,
    required this.grammar,
    required this.kanji,
    required this.exercises,
  });

  factory ComponentsModel.fromJson(Map<String, dynamic> json) =>
      _$ComponentsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ComponentsModelToJson(this);
}

// Component Detail Model
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ComponentDetailModel {
  final String id;
  final int total;
  final int completed;
  final int percentage;
  final bool isUnlocked;

  const ComponentDetailModel({
    required this.id,
    required this.total,
    required this.completed,
    required this.percentage,
    required this.isUnlocked,
  });

  factory ComponentDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ComponentDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$ComponentDetailModelToJson(this);
}
