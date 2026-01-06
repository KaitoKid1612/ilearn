import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilearn/core/theme/app_colors.dart';
import 'package:ilearn/domain/entities/flashcard.dart';
import 'package:ilearn/presentation/bloc/flashcard/flashcard_bloc.dart';
import 'package:ilearn/presentation/bloc/flashcard/flashcard_event.dart';
import 'package:ilearn/presentation/bloc/flashcard/flashcard_state.dart';

/// Widget hiển thị progress bar khi học flashcard
class FlashcardProgressBar extends StatelessWidget {
  final int current;
  final int total;
  final double progress;
  final int learnedCount;

  const FlashcardProgressBar({
    super.key,
    required this.current,
    required this.total,
    required this.progress,
    this.learnedCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Thẻ $current/$total',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  height: 1.4,
                  letterSpacing: 0.2,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.star, size: 18, color: Colors.green.shade600),
                  const SizedBox(width: 4),
                  Text(
                    '$learnedCount',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade600,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${(progress * 100).toInt()}%',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey.shade200,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.primary,
              ),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget hiển thị flashcard có thể lật
class FlashcardWidget extends StatelessWidget {
  final Flashcard card;
  final bool isFlipped;
  final VoidCallback onTap;

  const FlashcardWidget({
    super.key,
    required this.card,
    required this.isFlipped,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 300),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: card.isLearned
              ? Border.all(color: Colors.green.shade300, width: 2)
              : null,
          boxShadow: [
            BoxShadow(
              color: card.isLearned
                  ? Colors.green.withOpacity(0.2)
                  : AppColors.primary.withOpacity(0.15),
              blurRadius: 30,
              offset: const Offset(0, 15),
              spreadRadius: -5,
            ),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!isFlipped) _buildFrontContent(),
                  if (isFlipped) _buildBackContent(),
                  const SizedBox(height: 24),
                  _buildFlipHint(isFlipped),
                ],
              ),
            ),
            // Badge cho trạng thái
            if (card.isLearned)
              Positioned(
                top: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star_rounded, color: Colors.white, size: 18),
                      SizedBox(width: 6),
                      Text(
                        'Đã nhớ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              Positioned(
                top: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: Colors.orange.shade300,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.school_outlined,
                        color: Colors.orange.shade700,
                        size: 18,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Đang học',
                        style: TextStyle(
                          color: Colors.orange.shade700,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFrontContent() {
    return Column(
      children: [
        if (card.image != null && card.image!.isNotEmpty) ...[
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              card.image!,
              height: 150,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  height: 150,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
        ],
        Text(
          card.front,
          style: const TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
            height: 1.5,
            letterSpacing: 0.3,
          ),
          textAlign: TextAlign.center,
        ),
        if (card.hint != null && card.hint!.isNotEmpty) ...[
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.amber.shade200, width: 1),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.lightbulb_outline,
                  color: Colors.amber.shade700,
                  size: 22,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    card.hint!,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.amber.shade900,
                      height: 1.5,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildBackContent() {
    return Text(
      card.back,
      style: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w600,
        color: AppColors.primary,
        height: 1.6,
        letterSpacing: 0.3,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildFlipHint(bool isFlipped) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isFlipped ? Icons.check_circle_outline : Icons.flip,
            size: 20,
            color: Colors.grey.shade600,
          ),
          const SizedBox(width: 10),
          Text(
            isFlipped ? 'Bạn có nhớ từ này không?' : 'Nhấn để xem đáp án',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade700,
              height: 1.4,
              letterSpacing: 0.2,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget hiển thị các nút đánh giá (Chưa nhớ / Nhớ)
class FlashcardAnswerButtons extends StatelessWidget {
  final String flashcardId;

  const FlashcardAnswerButtons({super.key, required this.flashcardId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: _buildButton(
              context: context,
              label: 'Chưa nhớ',
              isRemembered: false,
              color: Colors.orange,
              icon: Icons.close_rounded,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildButton(
              context: context,
              label: 'Nhớ rồi',
              isRemembered: true,
              color: Colors.green,
              icon: Icons.star_rounded,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required BuildContext context,
    required String label,
    required bool isRemembered,
    required Color color,
    required IconData icon,
  }) {
    return ElevatedButton(
      onPressed: () {
        context.read<FlashcardBloc>().add(
          AnswerCardEvent(flashcardId: flashcardId, isRemembered: isRemembered),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 2,
        shadowColor: color.withOpacity(0.4),
      ),
      child: Column(
        children: [
          Icon(icon, size: 34),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              height: 1.3,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget màn hình study - đang học flashcard
class FlashcardStudyView extends StatelessWidget {
  final FlashcardStudying state;

  const FlashcardStudyView({super.key, required this.state});

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
            FlashcardProgressBar(
              current: state.currentIndex + 1,
              total: state.totalCards,
              progress: state.progress,
              learnedCount: state.correctCount,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Expanded(
                      child: FlashcardWidget(
                        card: state.currentCard,
                        isFlipped: state.isFlipped,
                        onTap: () {
                          context.read<FlashcardBloc>().add(
                            const FlipCardEvent(),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    if (state.isFlipped)
                      FlashcardAnswerButtons(flashcardId: state.currentCard.id),
                    const SizedBox(height: 24),
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
                height: 1.4,
                letterSpacing: 0.2,
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
}
