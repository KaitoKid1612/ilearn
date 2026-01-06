import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../data/models/lesson_detail_model.dart';
import '../../../widgets/common/animations/slide_animation.dart';
import 'lesson_component_card.dart';

class LessonComponentsList extends StatelessWidget {
  final LessonDetailModel lesson;
  final ComponentsModel components;

  const LessonComponentsList({
    super.key,
    required this.lesson,
    required this.components,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Section Title
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.auto_stories,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Nội dung học',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),

        // Learning Components
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              // 1. Vocabulary Component
              SlideAnimation(
                direction: SlideDirection.left,
                delay: const Duration(milliseconds: 100),
                child: LessonComponentCard(
                  component: components.vocabulary,
                  title: 'Từ vựng',
                  subtitle:
                      '${components.vocabulary.completed}/${components.vocabulary.total} từ đã học',
                  icon: Icons.book,
                  iconColor: AppColors.primary,
                  route: '/lesson/${lesson.id}/vocabulary',
                ),
              ),
              const SizedBox(height: 12),

              // 2. Grammar Component
              SlideAnimation(
                direction: SlideDirection.right,
                delay: const Duration(milliseconds: 150),
                child: LessonComponentCard(
                  component: components.grammar,
                  title: 'Ngữ pháp',
                  subtitle:
                      '${components.grammar.completed}/${components.grammar.total} mẫu câu',
                  icon: Icons.menu_book,
                  iconColor: AppColors.secondary,
                  route:
                      '/grammar-list/${lesson.id}?title=${Uri.encodeComponent(lesson.title)}',
                ),
              ),
              const SizedBox(height: 12),

              // 3. Kanji Component
              SlideAnimation(
                direction: SlideDirection.left,
                delay: const Duration(milliseconds: 200),
                child: LessonComponentCard(
                  component: components.kanji,
                  title: 'Chữ Hán',
                  subtitle:
                      '${components.kanji.completed}/${components.kanji.total} chữ hán',
                  icon: Icons.translate,
                  iconColor: components.kanji.isUnlocked
                      ? AppColors.info
                      : AppColors.textSecondary,
                  route: '/lesson/${lesson.id}/kanji',
                  lockMessage: components.kanji.isUnlocked
                      ? null
                      : 'Hoàn thành 80% từ vựng để mở khóa',
                ),
              ),
              const SizedBox(height: 12),

              // 4. Exercises Component
              SlideAnimation(
                direction: SlideDirection.right,
                delay: const Duration(milliseconds: 400),
                child: LessonComponentCard(
                  component: components.exercises,
                  title: 'Bài tập',
                  subtitle:
                      '${components.exercises.completed}/${components.exercises.total} bài',
                  icon: Icons.quiz,
                  iconColor: components.exercises.isUnlocked
                      ? AppColors.accent
                      : AppColors.textSecondary,
                  route: '/lesson/${lesson.id}/exercises',
                  lockMessage: components.exercises.isUnlocked
                      ? null
                      : 'Hoàn thành 70% từ vựng + ngữ pháp',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
