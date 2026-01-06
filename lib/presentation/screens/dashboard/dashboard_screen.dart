import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ilearn/core/di/dependency_injection.dart';
import 'package:ilearn/core/theme/app_colors.dart';
import 'package:ilearn/presentation/bloc/auth/auth_bloc.dart';
import 'package:ilearn/presentation/bloc/auth/auth_event.dart';
import 'package:ilearn/presentation/bloc/dashboard/dashboard_bloc.dart';
import 'package:ilearn/presentation/bloc/dashboard/dashboard_event.dart';
import 'package:ilearn/presentation/bloc/dashboard/dashboard_state.dart';
import 'package:ilearn/presentation/widgets/common/loading_widget.dart';
import 'package:ilearn/presentation/widgets/common/error_widget.dart' as custom;
import 'package:ilearn/presentation/screens/dashboard/widgets/user_header_widget.dart';
import 'package:ilearn/presentation/screens/dashboard/widgets/current_path_card_widget.dart';
import 'package:ilearn/presentation/screens/dashboard/widgets/units_list_widget.dart';

/// 🗺️ DASHBOARD SCREEN (Main Learning Dashboard)
/// API Call: GET /api/v1/users/me/dashboard
/// Response: { success, data: { user, currentPath, units[], overallProgress } }

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
      backgroundColor: AppColors.background,
      body: BlocConsumer<DashboardBloc, DashboardState>(
        listener: (context, state) {
          if (state is DashboardError) {
            // Check if error is related to authentication
            final errorMessage = state.message.toLowerCase();
            if (errorMessage.contains('user not found') ||
                errorMessage.contains('unauthorized') ||
                errorMessage.contains('unauthenticated') ||
                errorMessage.contains('internal server error')) {
              // Logout and redirect to login
              context.read<AuthBloc>().add(const LogoutRequested());

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                    'Phiên đăng nhập đã hết hạn hoặc tài khoản không tồn tại. Vui lòng đăng nhập lại.',
                  ),
                  backgroundColor: AppColors.error,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  duration: const Duration(seconds: 3),
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

          if (state is DashboardLoaded) {
            final dashboard = state.dashboard;

            // Calculate actual overall progress from lessons
            int totalLessons = 0;
            int completedLessons = 0;
            for (var unit in dashboard.units) {
              totalLessons += unit.lessons.length;
              completedLessons += unit.lessons
                  .where((l) => l.isCompleted)
                  .length;
            }

            final double actualProgress = totalLessons > 0
                ? (completedLessons / totalLessons) * 100
                : 0;

            return RefreshIndicator(
              onRefresh: () async {
                context.read<DashboardBloc>().add(
                  const RefreshDashboardEvent(),
                );
              },
              color: AppColors.primary,
              child: CustomScrollView(
                slivers: [
                  // App Bar with gradient and User Header
                  SliverAppBar(
                    expandedHeight: 220,
                    floating: false,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [AppColors.primary, AppColors.primaryDark],
                          ),
                        ),
                        child: SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                UserHeaderWidget(user: dashboard.user),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Current Path Card
                  SliverToBoxAdapter(
                    child: CurrentPathCardWidget(
                      currentPath: dashboard.currentPath,
                      progress: actualProgress,
                    ),
                  ),

                  // Section Title
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, 24, 16, 12),
                      child: Text(
                        '📚 Lộ trình học tập',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),

                  // Units and Lessons
                  UnitsListWidget(units: dashboard.units),

                  // Bottom padding
                  const SliverToBoxAdapter(child: SizedBox(height: 32)),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
