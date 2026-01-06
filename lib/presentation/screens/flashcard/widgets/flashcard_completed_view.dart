import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ilearn/core/theme/app_colors.dart';
import 'package:ilearn/presentation/bloc/flashcard/flashcard_bloc.dart';
import 'package:ilearn/presentation/bloc/flashcard/flashcard_event.dart';
import 'package:ilearn/presentation/bloc/flashcard/flashcard_state.dart';
import 'package:ilearn/presentation/bloc/vocabulary/vocabulary_bloc.dart';

/// Widget hiển thị kết quả sau khi hoàn thành học flashcard
class FlashcardCompletedView extends StatefulWidget {
  final FlashcardCompleted state;
  final String lessonId;

  const FlashcardCompletedView({
    super.key,
    required this.state,
    required this.lessonId,
  });

  @override
  State<FlashcardCompletedView> createState() => _FlashcardCompletedViewState();
}

class _FlashcardCompletedViewState extends State<FlashcardCompletedView> {
  bool _isMarkingLearned = false;

  void _markAllAsLearned(BuildContext context) {
    setState(() => _isMarkingLearned = true);

    // Get all vocabulary IDs from flashcard set
    final vocabIds = widget.state.flashcardSet.flashcards
        .map((card) => card.vocabularyId)
        .toList();

    // Create vocabulary bloc to call mark learned API
    final vocabBloc = context.read<VocabularyBloc>();
    vocabBloc.add(
      BatchMarkVocabulariesLearned(
        lessonId: widget.lessonId,
        vocabularyIds: vocabIds,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đang đánh dấu ${vocabIds.length} từ là đã học...'),
        backgroundColor: AppColors.success,
        duration: const Duration(seconds: 2),
      ),
    );

    // Reset state after a delay
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _isMarkingLearned = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.green.withOpacity(0.05),
            Colors.green.withOpacity(0.02),
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
                    _buildSuccessIcon(),
                    const SizedBox(height: 32),
                    _buildTitle(),
                    const SizedBox(height: 24),
                    _buildStats(),
                    const SizedBox(height: 24),
                    _buildMarkAllButton(context),
                    const SizedBox(height: 32),
                    _buildAccuracy(),
                    const SizedBox(height: 40),
                    _buildActions(context),
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
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 48),
          const Text(
            'Hoàn thành',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
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
            onPressed: () => context.pop(),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.green.shade400, Colors.green.shade600],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.3),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: const Icon(Icons.check_rounded, size: 80, color: Colors.white),
    );
  }

  Widget _buildTitle() {
    return Column(
      children: [
        const Text(
          'Xuất sắc! 🎉',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
            height: 1.3,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'Bạn đã hoàn thành ${widget.state.totalCards} thẻ',
          style: TextStyle(
            fontSize: 17,
            color: Colors.grey.shade600,
            height: 1.5,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }

  Widget _buildMarkAllButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _isMarkingLearned ? null : () => _markAllAsLearned(context),
        icon: _isMarkingLearned
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : const Icon(Icons.check_circle_outline),
        label: Text(
          _isMarkingLearned ? 'Đang xử lý...' : 'Đánh dấu tất cả là đã học',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            height: 1.3,
            letterSpacing: 0.2,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.success,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
      ),
    );
  }

  Widget _buildStats() {
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
            'Kết quả',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              height: 1.3,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  icon: Icons.check_circle,
                  label: 'Đúng',
                  value: '${widget.state.correctCount}',
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                  icon: Icons.cancel,
                  label: 'Sai',
                  value: '${widget.state.incorrectCount}',
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3), width: 1.5),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 14),
          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: color,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
              height: 1.3,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccuracy() {
    final accuracy = (widget.state.accuracy * 100).toInt();
    Color accuracyColor;
    String message;

    if (accuracy >= 80) {
      accuracyColor = Colors.green;
      message = 'Tuyệt vời!';
    } else if (accuracy >= 60) {
      accuracyColor = Colors.blue;
      message = 'Tốt lắm!';
    } else if (accuracy >= 40) {
      accuracyColor = Colors.orange;
      message = 'Cần cố gắng thêm';
    } else {
      accuracyColor = Colors.red;
      message = 'Hãy ôn lại nhé';
    }

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            accuracyColor.withOpacity(0.1),
            accuracyColor.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: accuracyColor.withOpacity(0.3), width: 2),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.speed, color: accuracyColor, size: 28),
              const SizedBox(width: 12),
              Text(
                'Độ chính xác',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                  height: 1.4,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            '$accuracy%',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: accuracyColor,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            message,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: accuracyColor,
              height: 1.4,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              context.read<FlashcardBloc>().add(
                StartStudyEvent(widget.lessonId),
              );
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
                Icon(Icons.refresh, size: 24),
                SizedBox(width: 10),
                Text(
                  'Học lại',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () => context.pop(),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.textPrimary,
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              side: BorderSide(color: Colors.grey.shade300, width: 1.5),
            ),
            child: const Text(
              'Quay lại',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                height: 1.3,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
