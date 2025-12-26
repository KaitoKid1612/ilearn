import 'package:flutter/material.dart';
import 'package:ilearn/core/theme/app_colors.dart';
import 'package:ilearn/core/theme/app_text_styles.dart';
import 'package:ilearn/data/models/learning_stats_model.dart';

class ContinueLearningCard extends StatelessWidget {
  final CourseProgressModel? progress;
  final VoidCallback? onTap;

  const ContinueLearningCard({super.key, this.progress, this.onTap});

  @override
  Widget build(BuildContext context) {
    if (progress == null) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Center(
          child: Text(
            'Chưa có khóa học nào đang học',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.secondary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.book,
                color: AppColors.secondary,
                size: 30,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(progress!.courseName, style: AppTextStyles.h6),
                  const SizedBox(height: 4),
                  Text(
                    progress!.currentLessonTitle ?? 'Tiếp tục học',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: progress!.progress / 100,
                    backgroundColor: AppColors.border,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.secondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${progress!.progress}% hoàn thành',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            const Icon(
              Icons.play_circle_filled,
              color: AppColors.secondary,
              size: 36,
            ),
          ],
        ),
      ),
    );
  }
}
