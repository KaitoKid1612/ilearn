import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ilearn/core/theme/app_colors.dart';
import 'package:ilearn/core/theme/app_text_styles.dart';
import 'package:ilearn/presentation/bloc/home/home_bloc.dart';
import 'package:ilearn/presentation/bloc/home/home_event.dart';
import 'package:ilearn/presentation/bloc/home/home_state.dart';
import 'package:ilearn/presentation/screens/home/widgets/learning_stats_card.dart';
import 'package:ilearn/presentation/screens/home/widgets/continue_learning_card.dart';
import 'package:ilearn/presentation/screens/home/widgets/category_card.dart';
import 'package:ilearn/presentation/screens/home/widgets/activity_item.dart';
import 'package:ilearn/presentation/screens/home/widgets/section_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(LoadHomeData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'iLearn',
          style: AppTextStyles.h5.copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.search_rounded), onPressed: () {}),
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.notifications_outlined),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.error,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is HomeError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: AppColors.error,
                  ),
                  const SizedBox(height: 16),
                  Text('Không thể tải dữ liệu', style: AppTextStyles.h5),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () =>
                        context.read<HomeBloc>().add(LoadHomeData()),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Thử lại'),
                  ),
                ],
              ),
            );
          }

          if (state is! HomeLoaded) {
            return const SizedBox.shrink();
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<HomeBloc>().add(RefreshHomeData());
              await Future.delayed(const Duration(seconds: 1));
            },
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Welcome Section
                      _buildWelcomeSection(),
                      const SizedBox(height: 24),

                      // Learning Stats
                      LearningStatsCard(stats: state.stats),
                      const SizedBox(height: 24),

                      // Continue Learning Section
                      SectionHeader(title: 'Tiếp tục học', onSeeAll: () {}),
                      const SizedBox(height: 12),
                      ContinueLearningCard(
                        progress: state.continueLesson,
                        onTap: state.continueLesson != null
                            ? () => context.go(
                                '/courses/${state.continueLesson!.courseId}',
                              )
                            : null,
                      ),
                      const SizedBox(height: 24),

                      // Categories Section
                      _buildCategoriesSection(context, state.courses),
                      const SizedBox(height: 24),

                      // Recent Activities
                      const SectionHeader(title: 'Hoạt động gần đây'),
                      const SizedBox(height: 16),
                      _buildRecentActivities(state.recentActivities),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.auto_awesome),
        label: const Text('Tạo với AI'),
        backgroundColor: AppColors.primary,
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildWelcomeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Chào mừng trở lại! 👋', style: AppTextStyles.h4),
        const SizedBox(height: 8),
        Text(
          'Hãy tiếp tục hành trình học tập của bạn',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoriesSection(BuildContext context, List courses) {
    // Count courses by category (mock data for now)
    final coursesCount = courses.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Danh mục học tập'),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.1,
          children: [
            CategoryCard(
              icon: Icons.book_rounded,
              title: 'Bài học',
              subtitle: '$coursesCount khóa học',
              color: AppColors.primary,
              onTap: () => context.go('/lessons'),
            ),
            CategoryCard(
              icon: Icons.style_rounded,
              title: 'Flashcard',
              subtitle: '156 thẻ',
              color: AppColors.secondary,
              onTap: () => context.go('/flashcards'),
            ),
            CategoryCard(
              icon: Icons.quiz_rounded,
              title: 'Trắc nghiệm',
              subtitle: '18 bài test',
              color: AppColors.accent,
              onTap: () => context.go('/quiz'),
            ),
            CategoryCard(
              icon: Icons.games_rounded,
              title: 'Trò chơi',
              subtitle: '8 mini game',
              color: AppColors.info,
              onTap: () => context.go('/games'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRecentActivities(List activities) {
    if (activities.isEmpty) {
      return Center(
        child: Text(
          'Chưa có hoạt động nào',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      );
    }

    return Column(
      children: activities.map((activity) {
        IconData icon;
        Color color;

        switch (activity.type) {
          case 'completed_lesson':
            icon = Icons.check_circle;
            color = AppColors.success;
            break;
          case 'achievement':
            icon = Icons.emoji_events;
            color = AppColors.accent;
            break;
          case 'high_score':
            icon = Icons.star;
            color = AppColors.warning;
            break;
          default:
            icon = Icons.info;
            color = AppColors.info;
        }

        final now = DateTime.now();
        final diff = now.difference(activity.createdAt);
        String timeAgo;

        if (diff.inMinutes < 60) {
          timeAgo = '${diff.inMinutes} phút trước';
        } else if (diff.inHours < 24) {
          timeAgo = '${diff.inHours} giờ trước';
        } else {
          timeAgo = '${diff.inDays} ngày trước';
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: ActivityItem(
            icon: icon,
            color: color,
            title: activity.title,
            subtitle: activity.description,
            time: timeAgo,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          // Handle navigation
          switch (index) {
            case 0:
              // Already on home
              break;
            case 1:
              context.go('/lessons');
              break;
            case 2:
              // Profile or settings
              break;
            case 3:
              // More options
              break;
          }
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school_rounded),
            label: 'Học tập',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Cá nhân',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_rounded),
            label: 'Thêm',
          ),
        ],
      ),
    );
  }
}
