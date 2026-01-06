import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilearn/core/theme/app_colors.dart';
import 'package:ilearn/presentation/bloc/auth/auth_bloc.dart';
import 'package:ilearn/presentation/bloc/auth/auth_state.dart';
import 'package:ilearn/presentation/widgets/common/loading_widget.dart';
import 'package:ilearn/presentation/screens/profile/widgets/profile_header_widget.dart';
import 'package:ilearn/presentation/screens/profile/widgets/stats_grid_widget.dart';
import 'package:ilearn/presentation/screens/profile/widgets/experience_progress_widget.dart';
import 'package:ilearn/presentation/screens/profile/widgets/user_info_card_widget.dart';
import 'package:ilearn/presentation/screens/profile/widgets/bio_card_widget.dart';
import 'package:ilearn/presentation/screens/profile/widgets/actions_card_widget.dart';

/// 👤 PROFILE SCREEN - Màn hình thông tin cá nhân
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is! Authenticated) {
            return const Center(child: LoadingWidget());
          }

          final user = state.user;

          return CustomScrollView(
            slivers: [
              // App Bar with gradient and Profile Header (expandedHeight: 320)
              ProfileHeaderWidget(user: user),

              // Stats Cards
              StatsGridWidget(points: user.points),

              // Experience Progress
              if (user.points != null)
                SliverToBoxAdapter(
                  child: ExperienceProgressWidget(points: user.points!),
                ),

              // User Information Section
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 8, 16, 12),
                  child: Text(
                    '📋 Thông tin cá nhân',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),

              // User Info Card
              UserInfoCardWidget(user: user),

              // Bio Section
              if (user.bio != null && user.bio!.isNotEmpty)
                SliverToBoxAdapter(child: BioCardWidget(bio: user.bio!)),

              // Actions Section
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 8, 16, 12),
                  child: Text(
                    '⚙️ Cài đặt',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),

              // Actions Card
              const SliverToBoxAdapter(child: ActionsCardWidget()),

              // Bottom padding
              const SliverToBoxAdapter(child: SizedBox(height: 32)),
            ],
          );
        },
      ),
    );
  }
}
