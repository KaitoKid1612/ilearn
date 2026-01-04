// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardResponseModel _$DashboardResponseModelFromJson(
  Map<String, dynamic> json,
) => DashboardResponseModel(
  user: DashboardUserModel.fromJson(json['user'] as Map<String, dynamic>),
  currentPath: CurrentPathModel.fromJson(
    json['currentPath'] as Map<String, dynamic>,
  ),
  units: (json['units'] as List<dynamic>)
      .map((e) => UnitModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  overallProgress: (json['overallProgress'] as num).toInt(),
);

Map<String, dynamic> _$DashboardResponseModelToJson(
  DashboardResponseModel instance,
) => <String, dynamic>{
  'user': instance.user.toJson(),
  'currentPath': instance.currentPath.toJson(),
  'units': instance.units.map((e) => e.toJson()).toList(),
  'overallProgress': instance.overallProgress,
};

DashboardUserModel _$DashboardUserModelFromJson(Map<String, dynamic> json) =>
    DashboardUserModel(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      currentLevel: json['currentLevel'] as String,
      totalPoints: (json['totalPoints'] as num).toInt(),
      currentStreak: (json['currentStreak'] as num).toInt(),
      longestStreak: (json['longestStreak'] as num).toInt(),
      level: (json['level'] as num).toInt(),
      experience: (json['experience'] as num).toInt(),
      avatar: json['avatar'] as String?,
    );

Map<String, dynamic> _$DashboardUserModelToJson(DashboardUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'currentLevel': instance.currentLevel,
      'totalPoints': instance.totalPoints,
      'currentStreak': instance.currentStreak,
      'longestStreak': instance.longestStreak,
      'level': instance.level,
      'experience': instance.experience,
      if (instance.avatar case final value?) 'avatar': value,
    };

CurrentPathModel _$CurrentPathModelFromJson(Map<String, dynamic> json) =>
    CurrentPathModel(
      id: json['id'] as String,
      level: json['level'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$CurrentPathModelToJson(CurrentPathModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'level': instance.level,
      'title': instance.title,
      'description': instance.description,
    };

UnitModel _$UnitModelFromJson(Map<String, dynamic> json) => UnitModel(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  order: (json['order'] as num).toInt(),
  isLocked: json['isLocked'] as bool,
  isCompleted: json['isCompleted'] as bool,
  progress: (json['progress'] as num).toInt(),
  lessons: (json['lessons'] as List<dynamic>)
      .map((e) => LessonModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$UnitModelToJson(UnitModel instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'order': instance.order,
  'isLocked': instance.isLocked,
  'isCompleted': instance.isCompleted,
  'progress': instance.progress,
  'lessons': instance.lessons.map((e) => e.toJson()).toList(),
};

LessonModel _$LessonModelFromJson(Map<String, dynamic> json) => LessonModel(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  order: (json['order'] as num).toInt(),
  isLocked: json['isLocked'] as bool,
  isCompleted: json['isCompleted'] as bool,
  isCurrent: json['isCurrent'] as bool,
  overallProgress: (json['overallProgress'] as num).toInt(),
  progress: LessonProgressModel.fromJson(
    json['progress'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$LessonModelToJson(LessonModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'order': instance.order,
      'isLocked': instance.isLocked,
      'isCompleted': instance.isCompleted,
      'isCurrent': instance.isCurrent,
      'overallProgress': instance.overallProgress,
      'progress': instance.progress.toJson(),
    };

LessonProgressModel _$LessonProgressModelFromJson(Map<String, dynamic> json) =>
    LessonProgressModel(
      vocabulary: ProgressDetailModel.fromJson(
        json['vocabulary'] as Map<String, dynamic>,
      ),
      grammar: ProgressDetailModel.fromJson(
        json['grammar'] as Map<String, dynamic>,
      ),
      kanji: ProgressDetailModel.fromJson(
        json['kanji'] as Map<String, dynamic>,
      ),
      exercises: ProgressDetailModel.fromJson(
        json['exercises'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$LessonProgressModelToJson(
  LessonProgressModel instance,
) => <String, dynamic>{
  'vocabulary': instance.vocabulary.toJson(),
  'grammar': instance.grammar.toJson(),
  'kanji': instance.kanji.toJson(),
  'exercises': instance.exercises.toJson(),
};

ProgressDetailModel _$ProgressDetailModelFromJson(Map<String, dynamic> json) =>
    ProgressDetailModel(
      total: (json['total'] as num).toInt(),
      completed: (json['completed'] as num).toInt(),
      percentage: (json['percentage'] as num).toInt(),
    );

Map<String, dynamic> _$ProgressDetailModelToJson(
  ProgressDetailModel instance,
) => <String, dynamic>{
  'total': instance.total,
  'completed': instance.completed,
  'percentage': instance.percentage,
};

RecentAchievementModel _$RecentAchievementModelFromJson(
  Map<String, dynamic> json,
) => RecentAchievementModel(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  icon: json['icon'] as String,
  earnedAt: json['earnedAt'] as String,
);

Map<String, dynamic> _$RecentAchievementModelToJson(
  RecentAchievementModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'icon': instance.icon,
  'earnedAt': instance.earnedAt,
};

ActiveChallengeModel _$ActiveChallengeModelFromJson(
  Map<String, dynamic> json,
) => ActiveChallengeModel(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  goal: (json['goal'] as num).toInt(),
  progress: (json['progress'] as num).toInt(),
  deadline: json['deadline'] as String,
  xpReward: (json['xpReward'] as num).toInt(),
  gemReward: (json['gemReward'] as num).toInt(),
);

Map<String, dynamic> _$ActiveChallengeModelToJson(
  ActiveChallengeModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'goal': instance.goal,
  'progress': instance.progress,
  'deadline': instance.deadline,
  'xpReward': instance.xpReward,
  'gemReward': instance.gemReward,
};

CurrentTextbookModel _$CurrentTextbookModelFromJson(
  Map<String, dynamic> json,
) => CurrentTextbookModel(
  id: json['id'] as String,
  title: json['title'] as String,
  level: json['level'] as String,
  progress: (json['progress'] as num).toInt(),
  totalLessons: (json['totalLessons'] as num).toInt(),
  completedLessons: (json['completedLessons'] as num).toInt(),
);

Map<String, dynamic> _$CurrentTextbookModelToJson(
  CurrentTextbookModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'level': instance.level,
  'progress': instance.progress,
  'totalLessons': instance.totalLessons,
  'completedLessons': instance.completedLessons,
};

StatsModel _$StatsModelFromJson(Map<String, dynamic> json) => StatsModel(
  totalXP: (json['totalXP'] as num).toInt(),
  gems: (json['gems'] as num).toInt(),
  level: (json['level'] as num).toInt(),
  currentStreak: (json['currentStreak'] as num).toInt(),
);

Map<String, dynamic> _$StatsModelToJson(StatsModel instance) =>
    <String, dynamic>{
      'totalXP': instance.totalXP,
      'gems': instance.gems,
      'level': instance.level,
      'currentStreak': instance.currentStreak,
    };
