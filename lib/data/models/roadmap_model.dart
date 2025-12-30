import 'package:json_annotation/json_annotation.dart';

part 'roadmap_model.g.dart';

@JsonSerializable()
class RoadmapResponseModel {
  final bool success;
  final RoadmapDataModel data;

  const RoadmapResponseModel({required this.success, required this.data});

  factory RoadmapResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RoadmapResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoadmapResponseModelToJson(this);
}

@JsonSerializable()
class RoadmapDataModel {
  final TextbookModel textbook;
  final List<UnitModel> units;

  const RoadmapDataModel({required this.textbook, required this.units});

  factory RoadmapDataModel.fromJson(Map<String, dynamic> json) =>
      _$RoadmapDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoadmapDataModelToJson(this);
}

@JsonSerializable()
class TextbookModel {
  final String id;
  final String title;
  final String level;
  final String description;
  final String? thumbnail;

  const TextbookModel({
    required this.id,
    required this.title,
    required this.level,
    required this.description,
    this.thumbnail,
  });

  factory TextbookModel.fromJson(Map<String, dynamic> json) =>
      _$TextbookModelFromJson(json);

  Map<String, dynamic> toJson() => _$TextbookModelToJson(this);
}

@JsonSerializable()
class UnitModel {
  final String id;
  final String title;
  final String description;
  final String? thumbnail;
  final int order;
  final int requiredXP;
  final bool isLocked;
  final String? unlockRequirement;
  final List<LessonModel> lessons;
  final ProgressModel progress;

  const UnitModel({
    required this.id,
    required this.title,
    required this.description,
    this.thumbnail,
    required this.order,
    required this.requiredXP,
    required this.isLocked,
    this.unlockRequirement,
    required this.lessons,
    required this.progress,
  });

  factory UnitModel.fromJson(Map<String, dynamic> json) =>
      _$UnitModelFromJson(json);

  Map<String, dynamic> toJson() => _$UnitModelToJson(this);
}

@JsonSerializable()
class LessonModel {
  final String id;
  final String title;
  final String type;
  final int order;
  final int xpReward;
  final int duration;
  final String status;
  final int score;
  final int stars;
  final int attempts;
  final bool isLocked;
  final String? unlockRequirement;

  const LessonModel({
    required this.id,
    required this.title,
    required this.type,
    required this.order,
    required this.xpReward,
    required this.duration,
    required this.status,
    required this.score,
    required this.stars,
    required this.attempts,
    required this.isLocked,
    this.unlockRequirement,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) =>
      _$LessonModelFromJson(json);

  Map<String, dynamic> toJson() => _$LessonModelToJson(this);
}

@JsonSerializable()
class ProgressModel {
  final int completed;
  final int total;
  final int percentage;

  const ProgressModel({
    required this.completed,
    required this.total,
    required this.percentage,
  });

  factory ProgressModel.fromJson(Map<String, dynamic> json) =>
      _$ProgressModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProgressModelToJson(this);
}
