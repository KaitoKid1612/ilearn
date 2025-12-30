import 'package:flutter/material.dart';
import 'package:ilearn/core/theme/app_colors.dart';
import 'package:ilearn/data/models/dashboard_model.dart';

class StatsCard extends StatelessWidget {
  final StatsModel stats;

  const StatsCard({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Top row: XP and Gems
          Row(
            children: [
              Expanded(
                child: _StatItem(
                  icon: Icons.bolt,
                  iconColor: AppColors.accent,
                  label: 'Tổng XP',
                  value: stats.totalXP.toString(),
                  backgroundColor: AppColors.accent.withOpacity(0.1),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatItem(
                  icon: Icons.diamond,
                  iconColor: AppColors.info,
                  label: 'Gems',
                  value: stats.gems.toString(),
                  backgroundColor: AppColors.info.withOpacity(0.1),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Bottom row: Level and Streak
          Row(
            children: [
              Expanded(
                child: _StatItem(
                  icon: Icons.star,
                  iconColor: AppColors.secondary,
                  label: 'Cấp độ',
                  value: stats.level.toString(),
                  backgroundColor: AppColors.secondary.withOpacity(0.1),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatItem(
                  icon: Icons.local_fire_department,
                  iconColor: AppColors.error,
                  label: 'Streak',
                  value: '${stats.currentStreak} ngày',
                  backgroundColor: AppColors.error.withOpacity(0.1),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final Color backgroundColor;

  const _StatItem({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: iconColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
