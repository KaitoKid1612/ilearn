import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ilearn/core/theme/app_colors.dart';
import 'package:ilearn/presentation/bloc/vocabulary/vocabulary_bloc.dart';
import 'package:ilearn/presentation/widgets/common/animations/fade_in_animation.dart';
import 'package:ilearn/presentation/widgets/common/animations/slide_animation.dart';

class VocabularyLearningScreen extends StatefulWidget {
  final String lessonId;
  final String lessonTitle;

  const VocabularyLearningScreen({
    Key? key,
    required this.lessonId,
    required this.lessonTitle,
  }) : super(key: key);

  @override
  State<VocabularyLearningScreen> createState() =>
      _VocabularyLearningScreenState();
}

class _VocabularyLearningScreenState extends State<VocabularyLearningScreen> {
  @override
  void initState() {
    super.initState();
    context.read<VocabularyBloc>().add(LoadVocabularyLesson(widget.lessonId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          widget.lessonTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primary, AppColors.primaryDark],
            ),
          ),
        ),
      ),
      body: BlocBuilder<VocabularyBloc, VocabularyState>(
        builder: (context, state) {
          if (state is VocabularyLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is VocabularyError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: AppColors.error),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      state.message,
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      context.read<VocabularyBloc>().add(
                        LoadVocabularyLesson(widget.lessonId),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Thử lại'),
                  ),
                ],
              ),
            );
          }

          if (state is VocabularyLoaded) {
            return Column(
              children: [
                // Progress Overview
                _buildProgressOverview(state),
                const SizedBox(height: 16),
                // Learning Modes
                Expanded(child: _buildLearningModes(context, state)),
              ],
            );
          }

          return const Center(child: Text('Unknown state'));
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _navigateToVocabularyList(context),
        icon: const Icon(Icons.list),
        label: const Text('Danh sách từ vựng'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget _buildProgressOverview(VocabularyLoaded state) {
    final total = state.lessonData.vocabularies.length;
    final learned = state.lessonData.vocabularies
        .where((v) => v.isLearned)
        .length;
    final mastered = state.lessonData.vocabularies
        .where((v) => v.masteryLevel >= 4)
        .length;
    final notStarted = state.lessonData.vocabularies
        .where((v) => !v.isLearned)
        .length;

    return FadeInAnimation(
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primary.withOpacity(0.1),
              AppColors.secondary.withOpacity(0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.primary.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.bar_chart,
                    color: AppColors.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Tiến độ học tập',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(
                  'Tổng số',
                  total.toString(),
                  AppColors.primary,
                  Icons.book,
                ),
                _buildStatItem(
                  'Đã học',
                  learned.toString(),
                  AppColors.secondary,
                  Icons.check_circle,
                ),
                _buildStatItem(
                  'Thành thạo',
                  mastered.toString(),
                  AppColors.accent,
                  Icons.emoji_events,
                ),
                _buildStatItem(
                  'Mới',
                  notStarted.toString(),
                  AppColors.info,
                  Icons.fiber_new,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
    String label,
    String value,
    Color color,
    IconData icon,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
        ),
      ],
    );
  }

  Widget _buildLearningModes(BuildContext context, VocabularyLoaded state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            '🎯 Chế độ học tập',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            padding: const EdgeInsets.all(16),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: [
              SlideAnimation(
                direction: SlideDirection.left,
                delay: const Duration(milliseconds: 100),
                child: _buildModeCard(
                  context: context,
                  icon: Icons.menu_book,
                  title: 'Học',
                  subtitle: 'Flashcards',
                  color: AppColors.primary,
                  progress: null,
                  onTap: () => _navigateToLearnMode(context, state),
                ),
              ),
              SlideAnimation(
                direction: SlideDirection.right,
                delay: const Duration(milliseconds: 200),
                child: _buildModeCard(
                  context: context,
                  icon: Icons.quiz,
                  title: 'Luyện tập',
                  subtitle: 'Trắc nghiệm',
                  color: AppColors.secondary,
                  progress: null,
                  onTap: () => _navigateToPracticeMode(context, state),
                ),
              ),
              SlideAnimation(
                direction: SlideDirection.left,
                delay: const Duration(milliseconds: 300),
                child: _buildModeCard(
                  context: context,
                  icon: Icons.mic,
                  title: 'Phát âm',
                  subtitle: 'Speaking',
                  color: AppColors.accent,
                  progress: null,
                  onTap: () => _navigateToSpeakingMode(context, state),
                ),
              ),
              SlideAnimation(
                direction: SlideDirection.right,
                delay: const Duration(milliseconds: 400),
                child: _buildModeCard(
                  context: context,
                  icon: Icons.edit,
                  title: 'Viết',
                  subtitle: 'Writing',
                  color: AppColors.info,
                  progress: null,
                  onTap: () => _navigateToWritingMode(context, state),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildModeCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
    dynamic progress,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      shadowColor: color.withOpacity(0.3),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [color.withOpacity(0.15), color.withOpacity(0.05)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(icon, size: 40, color: color),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
              if (progress != null) ...[
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress.percentage / 100,
                    backgroundColor: AppColors.greyLight,
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                    minHeight: 6,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${progress.completed}/${progress.total}',
                  style: TextStyle(
                    fontSize: 11,
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToLearnMode(BuildContext context, VocabularyLoaded state) {
    context.pushNamed(
      'flashcard',
      pathParameters: {'lessonId': widget.lessonId},
    );
  }

  void _navigateToPracticeMode(BuildContext context, VocabularyLoaded state) {
    context.pushNamed(
      'exercise',
      pathParameters: {'lessonId': widget.lessonId},
    );
  }

  void _navigateToSpeakingMode(BuildContext context, VocabularyLoaded state) {
    context.pushNamed(
      'vocabulary-speaking',
      extra: {
        'lessonId': widget.lessonId,
        'vocabularies': state.lessonData.vocabularies,
      },
    );
  }

  void _navigateToWritingMode(BuildContext context, VocabularyLoaded state) {
    context.pushNamed(
      'typing-exercise',
      pathParameters: {'lessonId': widget.lessonId},
    );
  }

  void _navigateToVocabularyList(BuildContext context) {
    context.pushNamed(
      'vocabulary-list',
      pathParameters: {'lessonId': widget.lessonId},
      queryParameters: {'title': widget.lessonTitle},
    );
  }
}
