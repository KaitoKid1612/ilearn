import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ilearn/core/di/dependency_injection.dart';
import 'package:ilearn/presentation/bloc/auth/auth_bloc.dart';
import 'package:ilearn/presentation/bloc/auth/auth_event.dart';
import 'package:ilearn/presentation/bloc/dashboard/dashboard_bloc.dart';
import 'package:ilearn/presentation/bloc/dashboard/dashboard_event.dart';
import 'package:ilearn/presentation/bloc/dashboard/dashboard_state.dart';
import 'package:ilearn/presentation/screens/dashboard/widgets/dashboard_header.dart';
import 'package:ilearn/presentation/screens/dashboard/widgets/stats_card.dart';
import 'package:ilearn/presentation/screens/dashboard/widgets/current_textbook_card.dart';
import 'package:ilearn/presentation/screens/dashboard/widgets/challenges_section.dart';
import 'package:ilearn/presentation/screens/dashboard/widgets/achievements_section.dart';
import 'package:ilearn/presentation/widgets/common/loading_widget.dart';
import 'package:ilearn/presentation/widgets/common/error_widget.dart' as custom;

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<DashboardBloc>()..add(const LoadDashboardEvent()),
      child: const DashboardView(),
    );
  }
}

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<DashboardBloc, DashboardState>(
        listener: (context, state) {
          if (state is DashboardError) {
            print('🚨 Dashboard Error: ${state.message}');

            // Check if error is related to authentication
            final errorMessage = state.message.toLowerCase();
            if (errorMessage.contains('user not found') ||
                errorMessage.contains('unauthorized') ||
                errorMessage.contains('unauthenticated') ||
                errorMessage.contains('internal server error')) {
              print(
                '⚠️ Dashboard: Auth error detected, clearing cache and logging out...',
              );

              // Logout and redirect to login
              context.read<AuthBloc>().add(const LogoutRequested());

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Phiên đăng nhập đã hết hạn hoặc tài khoản không tồn tại. Vui lòng đăng nhập lại.',
                  ),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 3),
                ),
              );

              // Navigate to login
              Future.delayed(const Duration(milliseconds: 1000), () {
                context.go('/login');
              });
            }
          }
        },
        builder: (context, state) {
          if (state is DashboardLoading) {
            return const LoadingWidget();
          }

          if (state is DashboardError) {
            return custom.ErrorWidget(
              message: state.message,
              onRetry: () {
                context.read<DashboardBloc>().add(const LoadDashboardEvent());
              },
            );
          }

          if (state is DashboardLoaded ||
              state is RoadmapLoading ||
              state is RoadmapError) {
            final dashboard = state is DashboardLoaded
                ? state.dashboard
                : state is RoadmapLoading
                ? state.dashboard
                : (state as RoadmapError).dashboard;

            return RefreshIndicator(
              onRefresh: () async {
                context.read<DashboardBloc>().add(
                  const RefreshDashboardEvent(),
                );
              },
              child: CustomScrollView(
                slivers: [
                  // Header with user info
                  SliverToBoxAdapter(
                    child: DashboardHeader(user: dashboard.user),
                  ),

                  // Stats Card (XP, Gems, Level, Streak)
                  SliverToBoxAdapter(child: StatsCard(stats: dashboard.stats)),

                  // Current Textbook Card
                  if (dashboard.currentTextbook != null)
                    SliverToBoxAdapter(
                      child: CurrentTextbookCard(
                        textbook: dashboard.currentTextbook!,
                        onTap: () {
                          // Navigate to roadmap screen
                          _navigateToRoadmap(
                            context,
                            dashboard.currentTextbook!.id,
                          );
                        },
                      ),
                    ),

                  // Active Challenges
                  if (dashboard.activeChallenges.isNotEmpty)
                    SliverToBoxAdapter(
                      child: ChallengesSection(
                        challenges: dashboard.activeChallenges,
                      ),
                    ),

                  // Recent Achievements
                  if (dashboard.recentAchievements.isNotEmpty)
                    SliverToBoxAdapter(
                      child: AchievementsSection(
                        achievements: dashboard.recentAchievements,
                      ),
                    ),

                  // Bottom padding
                  const SliverToBoxAdapter(child: SizedBox(height: 24)),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _navigateToRoadmap(BuildContext context, String textbookId) {
    context.go('/roadmap/$textbookId');
  }
}
