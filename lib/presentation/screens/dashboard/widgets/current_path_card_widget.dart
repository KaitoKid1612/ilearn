import 'package:flutter/material.dart';
import 'package:ilearn/core/theme/app_colors.dart';
import 'package:ilearn/data/models/dashboard_model.dart';
import 'package:ilearn/presentation/widgets/common/animations/slide_animation.dart';
import 'package:ilearn/presentation/widgets/common/progress/progress_ring.dart';

/// Widget hiển thị card thông tin learning path hiện tại
class CurrentPathCardWidget extends StatelessWidget {
  final CurrentPathModel currentPath;
  final double progress;

  const CurrentPathCardWidget({
    super.key,
    required this.currentPath,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SlideAnimation(
        direction: SlideDirection.up,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [
                  AppColors.secondary.withOpacity(0.1),
                  AppColors.primary.withOpacity(0.05),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 20),
                _buildProgressSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.primary, AppColors.primaryLight],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.flag, color: Colors.white, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                currentPath.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                currentPath.description,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProgressSection() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tiến độ tổng thể',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: progress / 100,
                  minHeight: 12,
                  backgroundColor: AppColors.greyLight,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '${progress.toStringAsFixed(0)}% hoàn thành',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 20),
        AnimatedProgressRing(
          progress: progress / 100,
          size: 80,
          strokeWidth: 8,
        ),
      ],
    );
  }
}
