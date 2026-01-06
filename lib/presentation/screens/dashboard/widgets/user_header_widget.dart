import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ilearn/core/theme/app_colors.dart';
import 'package:ilearn/data/models/dashboard_model.dart';
import 'package:ilearn/presentation/widgets/common/animations/fade_in_animation.dart';

/// Widget hiển thị header với thông tin user trong Dashboard
class UserHeaderWidget extends StatelessWidget {
  final DashboardUserModel user;

  const UserHeaderWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return FadeInAnimation(
      child: Row(
        children: [
          // Avatar with navigation to profile
          _buildAvatar(context),
          const SizedBox(width: 16),
          // User info
          Expanded(child: _buildUserInfo()),
          // Settings button
          _buildSettingsButton(),
        ],
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/profile'),
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipOval(
          child: user.avatar != null && user.avatar!.isNotEmpty
              ? Image.network(
                  user.avatar!,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => _buildDefaultAvatar(),
                )
              : _buildDefaultAvatar(),
        ),
      ),
    );
  }

  Widget _buildDefaultAvatar() {
    return Center(
      child: Text(
        user.fullName[0].toUpperCase(),
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildUserInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Xin chào!',
          style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.9)),
        ),
        Text(
          user.fullName,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            _buildStatBadge(
              icon: Icons.bolt,
              value: '${user.totalPoints} XP',
              backgroundColor: Colors.amber.withOpacity(0.2),
              iconColor: Colors.amber,
            ),
            const SizedBox(width: 8),
            _buildStatBadge(
              icon: Icons.local_fire_department,
              value: '${user.currentStreak}',
              backgroundColor: Colors.orange.withOpacity(0.2),
              iconColor: Colors.orange,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatBadge({
    required IconData icon,
    required String value,
    required Color backgroundColor,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor, size: 14),
          const SizedBox(width: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsButton() {
    return IconButton(
      icon: const Icon(Icons.settings_outlined, color: Colors.white, size: 28),
      onPressed: () {
        // TODO: Navigate to settings
      },
    );
  }
}
