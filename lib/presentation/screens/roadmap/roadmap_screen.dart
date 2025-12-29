import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ilearn/presentation/bloc/roadmap/roadmap_bloc.dart';
import 'package:ilearn/presentation/bloc/roadmap/roadmap_event.dart';
import 'package:ilearn/presentation/bloc/roadmap/roadmap_state.dart';
import 'package:ilearn/presentation/screens/roadmap/widgets/roadmap_header.dart';
import 'package:ilearn/presentation/screens/roadmap/widgets/unit_card.dart';
import 'package:ilearn/presentation/widgets/common/loading_widget.dart';
import 'package:ilearn/presentation/widgets/common/error_widget.dart' as custom;

class RoadmapScreen extends StatefulWidget {
  final String textbookId;
  final String textbookTitle;

  const RoadmapScreen({
    super.key,
    required this.textbookId,
    required this.textbookTitle,
  });

  @override
  State<RoadmapScreen> createState() => _RoadmapScreenState();
}

class _RoadmapScreenState extends State<RoadmapScreen> {
  @override
  void initState() {
    super.initState();
    // Load roadmap when screen is created
    context.read<RoadmapBloc>().add(LoadRoadmap(widget.textbookId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RoadmapBloc, RoadmapState>(
        builder: (context, state) {
          if (state is RoadmapLoading) {
            return const LoadingWidget();
          }

          if (state is RoadmapError) {
            return custom.ErrorWidget(
              message: state.message,
              onRetry: () {
                context.read<RoadmapBloc>().add(LoadRoadmap(widget.textbookId));
              },
            );
          }

          if (state is RoadmapLoaded) {
            final roadmap = state.roadmap;

            return CustomScrollView(
              slivers: [
                // Header with textbook info
                SliverToBoxAdapter(
                  child: RoadmapHeader(textbook: roadmap.textbook),
                ),

                // Units list (Duolingo style path)
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final unit = roadmap.units[index];
                      final isOddIndex = index % 2 != 0;

                      return Padding(
                        padding: EdgeInsets.only(
                          left: isOddIndex ? 40 : 0,
                          right: isOddIndex ? 0 : 40,
                          bottom: 24,
                        ),
                        child: UnitCard(
                          unit: unit,
                          onLessonTap: (lesson) {
                            _navigateToLesson(context, lesson);
                          },
                        ),
                      );
                    }, childCount: roadmap.units.length),
                  ),
                ),

                // Bottom padding
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
              ],
            );
          }

          return const Center(child: Text('Không có dữ liệu'));
        },
      ),
    );
  }

  void _navigateToLesson(BuildContext context, lesson) {
    // Navigate to appropriate screen based on lesson type
    print(
      '📖 RoadmapScreen: Navigating to lesson ${lesson.id} (type: ${lesson.type})',
    );

    if (lesson.type == 'VOCABULARY') {
      // Navigate to vocabulary learning screen
      context.pushNamed(
        'vocabulary',
        pathParameters: {'lessonId': lesson.id},
        queryParameters: {'title': lesson.title},
      );
    } else {
      // Navigate to other lesson types
      context.push('/lesson/${lesson.id}');
    }
  }
}
