import 'package:flutter/material.dart';
import 'package:ilearn/core/theme/app_colors.dart';
import 'package:ilearn/data/models/roadmap_model.dart';

class LessonNode extends StatelessWidget {
  final LessonModel lesson;
  final VoidCallback? onTap;
  final Alignment alignment;

  const LessonNode({
    super.key,
    required this.lesson,
    this.onTap,
    this.alignment = Alignment.centerLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Lesson node (circle)
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: _getNodeColor(),
                shape: BoxShape.circle,
                border: Border.all(color: _getBorderColor(), width: 4),
                boxShadow: lesson.isLocked
                    ? null
                    : [
                        BoxShadow(
                          color: _getNodeColor().withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
              ),
              child: Center(child: _buildNodeContent()),
            ),
            const SizedBox(height: 8),

            // Lesson title
            SizedBox(
              width: 100,
              child: Text(
                lesson.title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: lesson.isLocked
                      ? AppColors.textSecondary
                      : AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            // Stars or lock requirement
            if (!lesson.isLocked && lesson.status == 'COMPLETED')
              _buildStars()
            else if (lesson.isLocked && lesson.unlockRequirement != null)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: SizedBox(
                  width: 100,
                  child: Text(
                    lesson.unlockRequirement!,
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildNodeContent() {
    if (lesson.isLocked) {
      return const Icon(Icons.lock, color: Colors.white, size: 32);
    }

    switch (lesson.status) {
      case 'COMPLETED':
        return const Icon(Icons.check, color: Colors.white, size: 32);
      case 'IN_PROGRESS':
        return Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3),
          ),
          child: Center(
            child: Text(
              '${lesson.score}%',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      default:
        return Icon(_getLessonTypeIcon(), color: Colors.white, size: 32);
    }
  }

  IconData _getLessonTypeIcon() {
    switch (lesson.type) {
      case 'VOCABULARY':
        return Icons.abc;
      case 'GRAMMAR':
        return Icons.book;
      case 'PRACTICE':
        return Icons.fitness_center;
      case 'QUIZ':
        return Icons.quiz;
      default:
        return Icons.school;
    }
  }

  Color _getNodeColor() {
    if (lesson.isLocked) {
      return AppColors.grey;
    }

    switch (lesson.status) {
      case 'COMPLETED':
        return AppColors.secondary;
      case 'IN_PROGRESS':
        return AppColors.warning;
      default:
        return AppColors.primary;
    }
  }

  Color _getBorderColor() {
    if (lesson.isLocked) {
      return AppColors.greyLight;
    }

    switch (lesson.status) {
      case 'COMPLETED':
        return AppColors.secondaryDark;
      case 'IN_PROGRESS':
        return AppColors.accentDark;
      default:
        return AppColors.primaryDark;
    }
  }

  Widget _buildStars() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return Icon(
          index < lesson.stars ? Icons.star : Icons.star_border,
          color: AppColors.accent,
          size: 16,
        );
      }),
    );
  }
}
