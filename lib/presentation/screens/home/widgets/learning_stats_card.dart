import 'package:flutter/material.dart';
import 'package:ilearn/core/theme/app_colors.dart';
import 'package:ilearn/core/theme/app_text_styles.dart';
import 'package:ilearn/data/models/learning_stats_model.dart';

class LearningStatsCard extends StatelessWidget {
  final LearningStatsModel stats;

  const LearningStatsCard({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primary.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.local_fire_department,
                color: Colors.white,
                size: 28,
              ),
              const SizedBox(width: 8),
              Text(
                'Streak của bạn',
                style: AppTextStyles.h6.copyWith(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(stats.streakDays.toString(), 'Ngày liên tiếp'),
              Container(width: 1, height: 40, color: Colors.white30),
              _buildStatItem(stats.todayMinutes.toString(), 'Phút hôm nay'),
              Container(width: 1, height: 40, color: Colors.white30),
              _buildStatItem(
                stats.completedLessons.toString(),
                'Bài hoàn thành',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyles.h4.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(color: Colors.white70),
        ),
      ],
    );
  }
}
