import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ilearn/core/di/dependency_injection.dart';
import 'package:ilearn/presentation/bloc/lesson/lesson_bloc.dart';
import 'package:ilearn/presentation/bloc/lesson/lesson_event.dart';
import 'package:ilearn/presentation/bloc/lesson/lesson_state.dart';
import 'package:ilearn/presentation/widgets/common/loading_widget.dart';
import 'package:ilearn/presentation/widgets/common/error_widget.dart' as custom;
import 'widgets/lesson_detail_app_bar.dart';
import 'widgets/lesson_progress_card.dart';
import 'widgets/lesson_components_list.dart';
import 'widgets/lesson_footer_section.dart';

/// ðŸ“– LESSON DETAIL SCREEN
/// API: GET /api/v1/lessons/:lessonId
class LessonDetailScreen extends StatelessWidget {
  final String lessonId;

  const LessonDetailScreen({super.key, required this.lessonId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<LessonBloc>()..add(LoadLessonDetailEvent(lessonId)),
      child: const LessonDetailView(),
    );
  }
}

class LessonDetailView extends StatelessWidget {
  const LessonDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: BlocBuilder<LessonBloc, LessonState>(
        builder: (context, state) {
          if (state is LessonLoading) {
            return const LoadingWidget();
          }

          if (state is LessonError) {
            return custom.ErrorWidget(
              message: state.message,
              onRetry: () => context.pop(),
            );
          }

          if (state is LessonLoaded) {
            final lesson = state.lesson;
            final components = lesson.components;

            // Calculate overall progress
            final totalItems =
                components.vocabulary.total +
                components.grammar.total +
                components.kanji.total +
                components.exercises.total;
            final completedItems =
                components.vocabulary.completed +
                components.grammar.completed +
                components.kanji.completed +
                components.exercises.completed;
            final overallProgress = totalItems > 0
                ? completedItems / totalItems
                : 0.0;

            // Count completed components
            int completedComponents = 0;
            if (components.vocabulary.percentage == 100) completedComponents++;
            if (components.grammar.percentage == 100) completedComponents++;
            if (components.kanji.percentage == 100) completedComponents++;
            if (components.exercises.percentage == 100) completedComponents++;

            return CustomScrollView(
              slivers: [
                // App Bar
                LessonDetailAppBar(lesson: lesson),

                // Overall Progress Card
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: LessonProgressCard(
                      overallProgress: overallProgress,
                      completedComponents: completedComponents,
                      completedItems: completedItems,
                      totalItems: totalItems,
                    ),
                  ),
                ),

                // Learning Components
                SliverToBoxAdapter(
                  child: LessonComponentsList(
                    lesson: lesson,
                    components: components,
                  ),
                ),

                // Tips and Continue Button
                SliverToBoxAdapter(
                  child: LessonFooterSection(
                    lesson: lesson,
                    components: components,
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
