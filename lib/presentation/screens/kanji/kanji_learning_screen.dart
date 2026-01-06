import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ilearn/core/di/dependency_injection.dart';
import 'package:ilearn/core/theme/app_colors.dart';
import 'package:ilearn/presentation/bloc/kanji/kanji_bloc.dart';
import 'package:ilearn/presentation/screens/kanji/widgets/kanji_card.dart';
import 'package:ilearn/presentation/widgets/common/animations/fade_in_animation.dart';

class KanjiLearningScreen extends StatelessWidget {
  final String lessonId;
  final String? lessonTitle;

  const KanjiLearningScreen({
    Key? key,
    required this.lessonId,
    this.lessonTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<KanjiBloc>()..add(LoadLessonKanji(lessonId)),
      child: _KanjiLearningScreenContent(
        lessonId: lessonId,
        lessonTitle: lessonTitle,
      ),
    );
  }
}

class _KanjiLearningScreenContent extends StatelessWidget {
  final String lessonId;
  final String? lessonTitle;

  const _KanjiLearningScreenContent({required this.lessonId, this.lessonTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          lessonTitle ?? 'Chữ Hán',
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
      body: BlocBuilder<KanjiBloc, KanjiState>(
        builder: (context, state) {
          if (state is KanjiLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is KanjiError) {
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
                      context.read<KanjiBloc>().add(LoadLessonKanji(lessonId));
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

          if (state is KanjiLoaded) {
            return Column(
              children: [
                // Progress Overview
                _buildProgressOverview(state),
                const SizedBox(height: 16),
                // Kanji List
                Expanded(child: _buildKanjiList(context, state)),
              ],
            );
          }

          return const Center(child: Text('Unknown state'));
        },
      ),
    );
  }

  Widget _buildProgressOverview(KanjiLoaded state) {
    final progress = state.kanjiData.progress;
    final percentage = progress.percentage;

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
            color: AppColors.primary.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(
                  icon: Icons.school,
                  label: 'Tổng số',
                  value: '${progress.total}',
                  color: AppColors.primary,
                ),
                _buildStatItem(
                  icon: Icons.check_circle,
                  label: 'Đã học',
                  value: '${progress.learned}',
                  color: AppColors.success,
                ),
                _buildStatItem(
                  icon: Icons.pending,
                  label: 'Chưa học',
                  value: '${progress.total - progress.learned}',
                  color: AppColors.warning,
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Progress Bar
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Tiến độ',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      '$percentage%',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: percentage / 100,
                    minHeight: 10,
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
      ],
    );
  }

  Widget _buildKanjiList(BuildContext context, KanjiLoaded state) {
    final kanjis = state.kanjiData.kanjis;

    if (kanjis.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox_outlined,
              size: 64,
              color: AppColors.textSecondary.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'Chưa có chữ Hán nào',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary.withOpacity(0.7),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: kanjis.length,
      itemBuilder: (context, index) {
        final kanji = kanjis[index];
        return FadeInAnimation(
          delay: Duration(milliseconds: 50 * index),
          child: KanjiCard(
            kanji: kanji,
            onTap: () {
              // TODO: Navigate to kanji detail screen
              _showKanjiDetail(context, kanji);
            },
          ),
        );
      },
    );
  }

  void _showKanjiDetail(BuildContext context, kanji) {
    // Capture the bloc before opening modal
    final kanjiBloc = context.read<KanjiBloc>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (modalContext) => BlocProvider.value(
        value: kanjiBloc,
        child: DraggableScrollableSheet(
          initialChildSize: 0.9,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Character
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.primary.withOpacity(0.1),
                              AppColors.secondary.withOpacity(0.05),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          kanji.character,
                          style: const TextStyle(
                            fontSize: 80,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Meaning
                    _buildDetailSection(
                      'Nghĩa',
                      kanji.meaning,
                      Icons.translate,
                    ),
                    const SizedBox(height: 16),
                    // Readings
                    _buildDetailSection(
                      'Âm On (音読み)',
                      kanji.onyomi,
                      Icons.volume_up,
                    ),
                    const SizedBox(height: 16),
                    _buildDetailSection(
                      'Âm Kun (訓読み)',
                      kanji.kunyomi,
                      Icons.record_voice_over,
                    ),
                    const SizedBox(height: 16),
                    // Stroke Count
                    _buildDetailSection(
                      'Số nét',
                      '${kanji.strokeCount} nét',
                      Icons.edit,
                    ),
                    const SizedBox(height: 16),
                    // Mnemonic
                    _buildDetailSection(
                      'Gợi nhớ',
                      kanji.mnemonic,
                      Icons.lightbulb,
                    ),
                    const SizedBox(height: 16),
                    // Examples
                    if (kanji.examples.isNotEmpty) ...[
                      const Text(
                        'Ví dụ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...kanji.examples.map(
                        (example) => Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            example,
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 24),
                    // Status
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: kanji.isLearned
                            ? AppColors.success.withOpacity(0.1)
                            : AppColors.warning.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: kanji.isLearned
                              ? AppColors.success
                              : AppColors.warning,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            kanji.isLearned
                                ? Icons.check_circle
                                : Icons.pending,
                            color: kanji.isLearned
                                ? AppColors.success
                                : AppColors.warning,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  kanji.isLearned ? 'Đã học' : 'Chưa học',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: kanji.isLearned
                                        ? AppColors.success
                                        : AppColors.warning,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Mức độ viết: ${kanji.writingLevel}/5 | Mức độ đọc: ${kanji.readingLevel}/5',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Action Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: kanji.isLearned
                            ? null
                            : () {
                                context.read<KanjiBloc>().add(
                                  MarkKanjiLearned(
                                    lessonId: lessonId,
                                    kanjiId: kanji.id,
                                  ),
                                );
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Đã đánh dấu "${kanji.character}" là đã học!',
                                    ),
                                    backgroundColor: AppColors.success,
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },
                        icon: Icon(
                          kanji.isLearned ? Icons.check_circle : Icons.check,
                        ),
                        label: Text(
                          kanji.isLearned ? 'Đã học rồi' : 'Đánh dấu đã học',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kanji.isLearned
                              ? Colors.grey.shade300
                              : AppColors.primary,
                          foregroundColor: kanji.isLearned
                              ? Colors.grey.shade600
                              : Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          disabledBackgroundColor: Colors.grey.shade300,
                          disabledForegroundColor: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, String content, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: AppColors.primary),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            content,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textPrimary,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
