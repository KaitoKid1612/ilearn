import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilearn/core/theme/app_colors.dart';
import 'package:ilearn/domain/entities/flashcard.dart';
import 'package:ilearn/presentation/bloc/flashcard/flashcard_bloc.dart';
import 'package:ilearn/presentation/bloc/flashcard/flashcard_event.dart';
import 'package:ilearn/presentation/bloc/flashcard/flashcard_state.dart';

/// Widget hiển thị progress statistics của flashcard set
class FlashcardProgressStatsWidget extends StatelessWidget {
  final FlashcardProgress progress;

  const FlashcardProgressStatsWidget({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Trạng thái học tập',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                label: 'Mới',
                count: progress.newCards,
                color: Colors.blue,
                icon: Icons.fiber_new,
              ),
              _buildStatItem(
                label: 'Học',
                count: progress.learning,
                color: Colors.orange,
                icon: Icons.school,
              ),
              _buildStatItem(
                label: 'Ôn',
                count: progress.review,
                color: Colors.purple,
                icon: Icons.refresh,
              ),
              _buildStatItem(
                label: 'Thạo',
                count: progress.mastered,
                color: Colors.green,
                icon: Icons.check_circle,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required String label,
    required int count,
    required Color color,
    required IconData icon,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 10),
        Text(
          '$count',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
            height: 1.3,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }
}

/// Widget màn hình start để bắt đầu học flashcard
class FlashcardStartView extends StatelessWidget {
  final FlashcardLoaded state;
  final String lessonId;

  const FlashcardStartView({
    super.key,
    required this.state,
    required this.lessonId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withOpacity(0.05),
            AppColors.primaryLight.withOpacity(0.02),
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    _buildIcon(),
                    const SizedBox(height: 32),
                    _buildTitle(),
                    const SizedBox(height: 24),
                    FlashcardProgressStatsWidget(
                      progress: state.flashcardSet.progress,
                    ),
                    const SizedBox(height: 32),
                    _buildTotalCards(),
                    const SizedBox(height: 32),
                    _buildStartButton(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: const Icon(Icons.close, size: 20),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          Expanded(
            child: Text(
              state.flashcardSet.setTitle,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.1),
            AppColors.primaryLight.withOpacity(0.05),
          ],
        ),
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.style, size: 80, color: AppColors.primary),
    );
  }

  Widget _buildTitle() {
    return Column(
      children: [
        const Text(
          'Sẵn sàng học',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
            height: 1.4,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Ôn tập kiến thức với thẻ ghi nhớ',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey.shade600,
            height: 1.5,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }

  Widget _buildTotalCards() {
    final total = state.flashcardSet.progress.total;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.collections_bookmark,
            color: AppColors.primary,
            size: 24,
          ),
          const SizedBox(width: 12),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.textPrimary,
                height: 1.4,
                letterSpacing: 0.2,
              ),
              children: [
                const TextSpan(text: 'Tổng cộng '),
                TextSpan(
                  text: '$total',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppColors.primary,
                  ),
                ),
                const TextSpan(text: ' thẻ'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStartButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          context.read<FlashcardBloc>().add(StartStudyEvent(lessonId));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 2,
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.play_arrow_rounded, size: 28),
            SizedBox(width: 10),
            Text(
              'Bắt đầu học',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.3,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
