import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/enums/lesson_status.dart';
import '../indicators/lesson_status_icon.dart';
import '../progress/custom_progress_bar.dart';

class LessonCard extends StatelessWidget {
  final String lessonId;
  final String title;
  final String? subtitle;
  final LessonStatus status;
  final double? progress;
  final VoidCallback? onTap;
  final bool showProgress;
  final int? order;

  const LessonCard({
    Key? key,
    required this.lessonId,
    required this.title,
    this.subtitle,
    required this.status,
    this.progress,
    this.onTap,
    this.showProgress = true,
    this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLocked = status == LessonStatus.locked;
    final isCompleted = status == LessonStatus.completed;
    final isCurrent = status == LessonStatus.inProgress;

    return Opacity(
      opacity: isLocked ? 0.6 : 1.0,
      child: Card(
        elevation: isLocked ? 1 : 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: isCurrent
              ? BorderSide(color: AppColors.primary, width: 2)
              : BorderSide.none,
        ),
        child: InkWell(
          onTap: isLocked ? null : onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Order badge (if provided)
                if (order != null) ...[
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: isCompleted
                          ? AppColors.primary.withOpacity(0.1)
                          : Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        '$order',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isCompleted ? AppColors.primary : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                ],

                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: isLocked ? Colors.grey : Colors.black87,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          LessonStatusIcon(status: status),
                        ],
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          subtitle!,
                          style: TextStyle(
                            fontSize: 14,
                            color: isLocked ? Colors.grey : Colors.black54,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                      if (showProgress && progress != null && !isLocked) ...[
                        const SizedBox(height: 12),
                        CustomProgressBar(
                          progress: progress!,
                          height: 6,
                          showPercentage: true,
                        ),
                      ],
                      if (isLocked) ...[
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.lock_outline,
                              size: 14,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Complete previous lessons to unlock',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
