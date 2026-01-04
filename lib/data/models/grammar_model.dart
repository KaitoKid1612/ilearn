import 'package:json_annotation/json_annotation.dart';

part 'grammar_model.g.dart';

/// 📚 GRAMMAR LIST MODEL
/// API: GET /api/v1/lessons/:lessonId/grammar
@JsonSerializable(explicitToJson: true)
class GrammarListResponseModel {
  final bool success;
  final int statusCode;
  final String message;
  final GrammarListDataModel data;

  GrammarListResponseModel({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory GrammarListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GrammarListResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GrammarListResponseModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GrammarListDataModel {
  final String lessonId;
  @JsonKey(defaultValue: [])
  final List<GrammarItemModel> grammars;

  final GrammarProgressModel? progress;

  GrammarListDataModel({
    required this.lessonId,
    required this.grammars,
    this.progress,
  });

  factory GrammarListDataModel.fromJson(Map<String, dynamic> json) =>
      _$GrammarListDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$GrammarListDataModelToJson(this);
}

@JsonSerializable()
class GrammarItemModel {
  final String id;
  final String title;
  final String pattern;
  final String meaning;
  final bool isLearned;

  GrammarItemModel({
    required this.id,
    required this.title,
    required this.pattern,
    required this.meaning,
    required this.isLearned,
  });

  factory GrammarItemModel.fromJson(Map<String, dynamic> json) =>
      _$GrammarItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$GrammarItemModelToJson(this);
}

@JsonSerializable()
class GrammarProgressModel {
  final int total;
  final int learned;
  final double percentage;

  GrammarProgressModel({
    required this.total,
    required this.learned,
    required this.percentage,
  });

  factory GrammarProgressModel.fromJson(Map<String, dynamic> json) =>
      _$GrammarProgressModelFromJson(json);

  Map<String, dynamic> toJson() => _$GrammarProgressModelToJson(this);
}

/// 📖 GRAMMAR DETAIL MODEL
/// API: GET /api/v1/lessons/:lessonId/grammar/:grammarId
@JsonSerializable(explicitToJson: true)
class GrammarDetailResponseModel {
  final bool success;
  final int statusCode;
  final String message;
  final GrammarDetailModel data;

  GrammarDetailResponseModel({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory GrammarDetailResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GrammarDetailResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GrammarDetailResponseModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GrammarDetailModel {
  final String id;
  final String title;
  final String pattern;
  final String meaning;
  final String? explanation;
  final String? usage;
  final String? formality;
  final String? level;
  @JsonKey(defaultValue: [])
  final List<String>? tags;
  @JsonKey(defaultValue: [])
  final List<GrammarExampleModel> examples;
  @JsonKey(defaultValue: [])
  final List<RelatedGrammarModel>? relatedGrammar;
  final bool isLearned;

  GrammarDetailModel({
    required this.id,
    required this.title,
    required this.pattern,
    required this.meaning,
    this.explanation,
    this.usage,
    this.formality,
    this.level,
    this.tags,
    required this.examples,
    this.relatedGrammar,
    required this.isLearned,
  });

  factory GrammarDetailModel.fromJson(Map<String, dynamic> json) =>
      _$GrammarDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$GrammarDetailModelToJson(this);
}

@JsonSerializable()
class GrammarExampleModel {
  final String sentence;
  final String meaning;
  final String? breakdown;
  final String? audio;

  GrammarExampleModel({
    required this.sentence,
    required this.meaning,
    this.breakdown,
    this.audio,
  });

  factory GrammarExampleModel.fromJson(Map<String, dynamic> json) =>
      _$GrammarExampleModelFromJson(json);

  Map<String, dynamic> toJson() => _$GrammarExampleModelToJson(this);
}

@JsonSerializable()
class RelatedGrammarModel {
  final String id;
  final String title;
  final String pattern;
  final String meaning;

  RelatedGrammarModel({
    required this.id,
    required this.title,
    required this.pattern,
    required this.meaning,
  });

  factory RelatedGrammarModel.fromJson(Map<String, dynamic> json) =>
      _$RelatedGrammarModelFromJson(json);

  Map<String, dynamic> toJson() => _$RelatedGrammarModelToJson(this);
}

/// ✅ MARK AS LEARNED MODEL
/// API: POST /api/v1/lessons/:lessonId/mark-learned
@JsonSerializable(explicitToJson: true)
class MarkLearnedResponseModel {
  final bool success;
  final int statusCode;
  final MarkLearnedDataModel data;

  MarkLearnedResponseModel({
    required this.success,
    required this.statusCode,
    required this.data,
  });

  factory MarkLearnedResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MarkLearnedResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$MarkLearnedResponseModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MarkLearnedDataModel {
  final String message;
  final int xpEarned;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final GrammarProgressModel? progress;

  MarkLearnedDataModel({
    required this.message,
    required this.xpEarned,
    this.progress,
  });

  factory MarkLearnedDataModel.fromJson(Map<String, dynamic> json) =>
      _$MarkLearnedDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$MarkLearnedDataModelToJson(this);
}
