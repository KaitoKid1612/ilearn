// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grammar_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GrammarListResponseModel _$GrammarListResponseModelFromJson(
  Map<String, dynamic> json,
) => GrammarListResponseModel(
  success: json['success'] as bool,
  statusCode: (json['statusCode'] as num).toInt(),
  message: json['message'] as String,
  data: GrammarListDataModel.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$GrammarListResponseModelToJson(
  GrammarListResponseModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'statusCode': instance.statusCode,
  'message': instance.message,
  'data': instance.data.toJson(),
};

GrammarListDataModel _$GrammarListDataModelFromJson(
  Map<String, dynamic> json,
) => GrammarListDataModel(
  lessonId: json['lessonId'] as String,
  grammars:
      (json['grammars'] as List<dynamic>?)
          ?.map((e) => GrammarItemModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  progress: json['progress'] == null
      ? null
      : GrammarProgressModel.fromJson(json['progress'] as Map<String, dynamic>),
);

Map<String, dynamic> _$GrammarListDataModelToJson(
  GrammarListDataModel instance,
) => <String, dynamic>{
  'lessonId': instance.lessonId,
  'grammars': instance.grammars.map((e) => e.toJson()).toList(),
  'progress': instance.progress?.toJson(),
};

GrammarItemModel _$GrammarItemModelFromJson(Map<String, dynamic> json) =>
    GrammarItemModel(
      id: json['id'] as String,
      title: json['title'] as String,
      pattern: json['pattern'] as String,
      meaning: json['meaning'] as String,
      isLearned: json['isLearned'] as bool,
    );

Map<String, dynamic> _$GrammarItemModelToJson(GrammarItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'pattern': instance.pattern,
      'meaning': instance.meaning,
      'isLearned': instance.isLearned,
    };

GrammarProgressModel _$GrammarProgressModelFromJson(
  Map<String, dynamic> json,
) => GrammarProgressModel(
  total: (json['total'] as num).toInt(),
  learned: (json['learned'] as num).toInt(),
  percentage: (json['percentage'] as num).toDouble(),
);

Map<String, dynamic> _$GrammarProgressModelToJson(
  GrammarProgressModel instance,
) => <String, dynamic>{
  'total': instance.total,
  'learned': instance.learned,
  'percentage': instance.percentage,
};

GrammarDetailResponseModel _$GrammarDetailResponseModelFromJson(
  Map<String, dynamic> json,
) => GrammarDetailResponseModel(
  success: json['success'] as bool,
  statusCode: (json['statusCode'] as num).toInt(),
  message: json['message'] as String,
  data: GrammarDetailModel.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$GrammarDetailResponseModelToJson(
  GrammarDetailResponseModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'statusCode': instance.statusCode,
  'message': instance.message,
  'data': instance.data.toJson(),
};

GrammarDetailModel _$GrammarDetailModelFromJson(
  Map<String, dynamic> json,
) => GrammarDetailModel(
  id: json['id'] as String,
  title: json['title'] as String,
  pattern: json['pattern'] as String,
  meaning: json['meaning'] as String,
  explanation: json['explanation'] as String?,
  usage: json['usage'] as String?,
  formality: json['formality'] as String?,
  level: json['level'] as String?,
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
  examples:
      (json['examples'] as List<dynamic>?)
          ?.map((e) => GrammarExampleModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  relatedGrammar:
      (json['relatedGrammar'] as List<dynamic>?)
          ?.map((e) => RelatedGrammarModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  isLearned: json['isLearned'] as bool,
);

Map<String, dynamic> _$GrammarDetailModelToJson(
  GrammarDetailModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'pattern': instance.pattern,
  'meaning': instance.meaning,
  'explanation': instance.explanation,
  'usage': instance.usage,
  'formality': instance.formality,
  'level': instance.level,
  'tags': instance.tags,
  'examples': instance.examples.map((e) => e.toJson()).toList(),
  'relatedGrammar': instance.relatedGrammar?.map((e) => e.toJson()).toList(),
  'isLearned': instance.isLearned,
};

GrammarExampleModel _$GrammarExampleModelFromJson(Map<String, dynamic> json) =>
    GrammarExampleModel(
      sentence: json['sentence'] as String,
      meaning: json['meaning'] as String,
      breakdown: json['breakdown'] as String?,
      audio: json['audio'] as String?,
    );

Map<String, dynamic> _$GrammarExampleModelToJson(
  GrammarExampleModel instance,
) => <String, dynamic>{
  'sentence': instance.sentence,
  'meaning': instance.meaning,
  'breakdown': instance.breakdown,
  'audio': instance.audio,
};

RelatedGrammarModel _$RelatedGrammarModelFromJson(Map<String, dynamic> json) =>
    RelatedGrammarModel(
      id: json['id'] as String,
      title: json['title'] as String,
      pattern: json['pattern'] as String,
      meaning: json['meaning'] as String,
    );

Map<String, dynamic> _$RelatedGrammarModelToJson(
  RelatedGrammarModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'pattern': instance.pattern,
  'meaning': instance.meaning,
};

MarkLearnedResponseModel _$MarkLearnedResponseModelFromJson(
  Map<String, dynamic> json,
) => MarkLearnedResponseModel(
  success: json['success'] as bool,
  statusCode: (json['statusCode'] as num).toInt(),
  data: MarkLearnedDataModel.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$MarkLearnedResponseModelToJson(
  MarkLearnedResponseModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'statusCode': instance.statusCode,
  'data': instance.data.toJson(),
};

MarkLearnedDataModel _$MarkLearnedDataModelFromJson(
  Map<String, dynamic> json,
) => MarkLearnedDataModel(
  message: json['message'] as String,
  xpEarned: (json['xpEarned'] as num).toInt(),
);

Map<String, dynamic> _$MarkLearnedDataModelToJson(
  MarkLearnedDataModel instance,
) => <String, dynamic>{
  'message': instance.message,
  'xpEarned': instance.xpEarned,
};
