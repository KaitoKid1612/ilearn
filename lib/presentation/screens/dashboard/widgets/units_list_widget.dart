import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ilearn/core/enums/lesson_status.dart';
import 'package:ilearn/data/models/dashboard_model.dart';
import 'package:ilearn/presentation/widgets/common/animations/slide_animation.dart';
import 'package:ilearn/presentation/widgets/common/cards/lesson_card.dart';
import 'package:ilearn/presentation/widgets/common/cards/unit_card.dart';

/// Widget hiển thị danh sách units và lessons
class UnitsListWidget extends StatelessWidget {
  final List<UnitModel> units;

  const UnitsListWidget({super.key, required this.units});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final unit = units[index];

        return SlideAnimation(
          direction: SlideDirection.up,
          delay: Duration(milliseconds: 50 * index),
          child: UnitCard(
            unitId: unit.id,
            title: unit.title,
            description: unit.description,
            order: unit.order,
            isLocked: unit.isLocked,
            isCompleted: unit.isCompleted,
            progress:
                unit.progress / 100, // Convert percentage to decimal (0-1)
            totalLessons: unit.lessons.length,
            completedLessons: unit.lessons.where((l) => l.isCompleted).length,
            initiallyExpanded: unit.lessons.any((l) => l.isCurrent),
            child: Column(
              children: unit.lessons.map((lesson) {
                final lessonStatus = _getLessonStatus(lesson);

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: LessonCard(
                    lessonId: lesson.id,
                    title: lesson.title,
                    subtitle: lesson.description,
                    status: lessonStatus,
                    progress: lesson.overallProgress / 100,
                    order: lesson.order,
                    onTap: lesson.isLocked
                        ? null
                        : () => context.push('/lesson/${lesson.id}'),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      }, childCount: units.length),
    );
  }

  LessonStatus _getLessonStatus(lesson) {
    if (lesson.isLocked) return LessonStatus.locked;
    if (lesson.isCompleted) return LessonStatus.completed;
    if (lesson.isCurrent) return LessonStatus.inProgress;
    return LessonStatus.unlocked;
  }
}
