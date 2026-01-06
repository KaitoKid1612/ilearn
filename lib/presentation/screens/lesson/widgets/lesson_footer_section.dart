import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../data/models/lesson_detail_model.dart';
import '../../../widgets/common/animations/slide_animation.dart';

class LessonFooterSection extends StatelessWidget {
  final LessonDetailModel lesson;
  final ComponentsModel components;

  const LessonFooterSection({
    super.key,
    required this.lesson,
    required this.components,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Tips Section
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: SlideAnimation(
            direction: SlideDirection.up,
            delay: const Duration(milliseconds: 500),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.info.withOpacity(0.12),
                    AppColors.info.withOpacity(0.06),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.info.withOpacity(0.3),
                  width: 1.5,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.info.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.lightbulb,
                      color: AppColors.info,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '💡 Mẹo học tập',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.info,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Học lần lượt: Từ vựng → Ngữ pháp → Chữ Hán → Bài tập để đạt hiệu quả cao nhất!',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Continue Button
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          child: SlideAnimation(
            direction: SlideDirection.up,
            delay: const Duration(milliseconds: 600),
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.secondary],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => _navigateToNextSection(context),
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 26,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _getContinueButtonText(),
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _navigateToNextSection(BuildContext context) {
    // Navigate to the first incomplete/unlocked component
    if (components.vocabulary.percentage < 100 &&
        components.vocabulary.isUnlocked) {
      context.push('/lesson/${lesson.id}/vocabulary');
    } else if (components.grammar.percentage < 100 &&
        components.grammar.isUnlocked) {
      context.push('/lesson/${lesson.id}/grammar');
    } else if (components.kanji.percentage < 100 &&
        components.kanji.isUnlocked) {
      context.push('/lesson/${lesson.id}/kanji');
    } else if (components.exercises.percentage < 100 &&
        components.exercises.isUnlocked) {
      context.push('/lesson/${lesson.id}/exercises');
    } else {
      // All completed or all locked
      context.push('/lesson/${lesson.id}/vocabulary');
    }
  }

  String _getContinueButtonText() {
    if (components.vocabulary.percentage < 100 &&
        components.vocabulary.isUnlocked) {
      return 'Bắt đầu học từ vựng';
    } else if (components.grammar.percentage < 100 &&
        components.grammar.isUnlocked) {
      return 'Tiếp tục học ngữ pháp';
    } else if (components.kanji.percentage < 100 &&
        components.kanji.isUnlocked) {
      return 'Tiếp tục học chữ Hán';
    } else if (components.exercises.percentage < 100 &&
        components.exercises.isUnlocked) {
      return 'Làm bài tập';
    } else {
      return 'Bắt đầu học';
    }
  }
}
