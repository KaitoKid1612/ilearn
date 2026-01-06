import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../data/models/lesson_detail_model.dart';

class LessonComponentCard extends StatelessWidget {
  final ComponentDetailModel component;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final String route;
  final String? lockMessage;

  const LessonComponentCard({
    super.key,
    required this.component,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.route,
    this.lockMessage,
  });

  @override
  Widget build(BuildContext context) {
    final isLocked = !component.isUnlocked;
    final progress = component.percentage / 100;

    return Card(
      elevation: isLocked ? 1 : 3,
      shadowColor: isLocked
          ? Colors.grey.withOpacity(0.2)
          : iconColor.withOpacity(0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: isLocked ? null : () => context.push(route),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isLocked
                  ? [
                      AppColors.greyLight.withOpacity(0.5),
                      AppColors.greyLight.withOpacity(0.3),
                    ]
                  : [iconColor.withOpacity(0.1), iconColor.withOpacity(0.05)],
            ),
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Icon Container
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isLocked
                              ? Colors.grey.withOpacity(0.3)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: isLocked
                              ? []
                              : [
                                  BoxShadow(
                                    color: iconColor.withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                        ),
                        child: Icon(
                          icon,
                          color: isLocked ? Colors.grey : iconColor,
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 14),

                      // Title & Subtitle
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    title,
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: isLocked
                                          ? AppColors.textSecondary
                                          : AppColors.textPrimary,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (isLocked) ...[
                                  const SizedBox(width: 8),
                                  const Icon(
                                    Icons.lock,
                                    size: 18,
                                    color: AppColors.textSecondary,
                                  ),
                                ],
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              subtitle,
                              style: TextStyle(
                                fontSize: 13,
                                color: isLocked
                                    ? AppColors.textSecondary.withOpacity(0.7)
                                    : AppColors.textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Arrow Icon
                      if (!isLocked)
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color: iconColor.withOpacity(0.6),
                        ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Progress Bar
                  Stack(
                    children: [
                      Container(
                        height: 8,
                        decoration: BoxDecoration(
                          color: isLocked
                              ? Colors.grey.withOpacity(0.2)
                              : AppColors.greyLight,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: progress,
                        child: Container(
                          height: 8,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: isLocked
                                  ? [Colors.grey, Colors.grey]
                                  : [iconColor, iconColor.withOpacity(0.7)],
                            ),
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: isLocked
                                ? []
                                : [
                                    BoxShadow(
                                      color: iconColor.withOpacity(0.4),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Progress Text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${(component.percentage).toStringAsFixed(0)}% hoàn thành',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isLocked
                              ? AppColors.textSecondary.withOpacity(0.7)
                              : iconColor,
                        ),
                      ),
                      if (component.percentage == 100)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.accent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.check, size: 12, color: Colors.white),
                              SizedBox(width: 3),
                              Text(
                                'Đã xong',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),

                  // Lock Message
                  if (isLocked && lockMessage != null) ...[
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.orange.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.info_outline,
                            size: 14,
                            color: Colors.orange,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              lockMessage!,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.orange,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
