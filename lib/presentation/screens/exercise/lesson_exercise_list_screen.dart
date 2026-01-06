import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilearn/core/theme/app_colors.dart';
import 'package:ilearn/presentation/bloc/lesson_exercise/lesson_exercise_bloc.dart';
import 'package:ilearn/presentation/bloc/lesson_exercise/lesson_exercise_event.dart';
import 'package:ilearn/presentation/bloc/lesson_exercise/lesson_exercise_state.dart';
import 'package:ilearn/data/models/lesson_exercise_model.dart';
import 'package:ilearn/data/models/exercise_session_model.dart';
import 'package:ilearn/core/di/dependency_injection.dart';
import 'package:ilearn/domain/repositories/exercise_repository.dart';
import 'exercise_doing_screen.dart';

class LessonExerciseListScreen extends StatelessWidget {
  final String lessonId;
  final String lessonTitle;

  const LessonExerciseListScreen({
    super.key,
    required this.lessonId,
    required this.lessonTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lessonTitle),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<LessonExerciseBloc, LessonExerciseState>(
        builder: (context, state) {
          if (state is LessonExerciseInitial) {
            context.read<LessonExerciseBloc>().add(
              LoadLessonExercises(lessonId),
            );
            return const Center(child: CircularProgressIndicator());
          }

          if (state is LessonExerciseLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is LessonExerciseError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Lỗi: ${state.message}',
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<LessonExerciseBloc>().add(
                        LoadLessonExercises(lessonId),
                      );
                    },
                    child: const Text('Thử lại'),
                  ),
                ],
              ),
            );
          }

          if (state is LessonExerciseLoaded) {
            final exerciseList = state.exerciseList;
            return Column(
              children: [
                _buildProgressSection(exerciseList),
                _buildCategoryTabs(exerciseList),
                Expanded(child: _buildExerciseList(exerciseList.exercises)),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildProgressSection(LessonExerciseListModel exerciseList) {
    final progress = exerciseList.progress;
    if (progress == null) return const SizedBox();

    final percentage = progress.percentage / 100;

    return Container(
      padding: const EdgeInsets.all(16),
      color: AppColors.primary.withOpacity(0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Tiến độ bài tập',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                '${progress.completed}/${progress.total}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: percentage,
              minHeight: 8,
              backgroundColor: Colors.grey.shade300,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.primary,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${progress.percentage}% hoàn thành',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs(LessonExerciseListModel exerciseList) {
    final counts = exerciseList.categoryCounts;
    if (counts == null) return const SizedBox();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildCategoryChip('Từ vựng', counts.vocabulary, Colors.blue),
          _buildCategoryChip('Kanji', counts.kanji, Colors.orange),
          _buildCategoryChip('Ngữ pháp', counts.grammar, Colors.green),
          _buildCategoryChip('Tổng hợp', counts.general, Colors.purple),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label, int count, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color, width: 1),
          ),
          child: Text(
            count.toString(),
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
        ),
      ],
    );
  }

  Widget _buildExerciseList(List<LessonExerciseItemModel> exercises) {
    if (exercises.isEmpty) {
      return const Center(child: Text('Chưa có bài tập nào'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: exercises.length,
      itemBuilder: (context, index) {
        return _buildExerciseCard(
          context,
          exercises, // Pass full list
          index,
        );
      },
    );
  }

  Widget _buildExerciseCard(
    BuildContext context,
    List<LessonExerciseItemModel> exercises,
    int index,
  ) {
    final exercise = exercises[index];
    final number = index + 1;
    Color categoryColor;
    IconData categoryIcon;

    switch (exercise.category) {
      case 'vocabulary':
        categoryColor = Colors.blue;
        categoryIcon = Icons.book;
        break;
      case 'kanji':
        categoryColor = Colors.orange;
        categoryIcon = Icons.text_fields;
        break;
      case 'grammar':
        categoryColor = Colors.green;
        categoryIcon = Icons.menu_book;
        break;
      default:
        categoryColor = Colors.purple;
        categoryIcon = Icons.quiz;
    }

    String typeLabel;
    switch (exercise.type) {
      case 'MULTIPLE_CHOICE':
        typeLabel = 'Trắc nghiệm';
        break;
      case 'FILL_IN_BLANK':
        typeLabel = 'Điền từ';
        break;
      case 'SENTENCE_BUILD':
        typeLabel = 'Sắp xếp câu';
        break;
      default:
        typeLabel = exercise.type;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: exercise.isCompleted
            ? null
            : () async {
                // Show loading
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) =>
                      const Center(child: CircularProgressIndicator()),
                );

                // Start exercise session
                final repository = getIt<ExerciseRepository>();
                final sessionResult = await repository.startExerciseSession(
                  lessonId,
                );

                if (context.mounted) {
                  Navigator.pop(context); // Close loading

                  sessionResult.fold(
                    (error) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text('Lỗi: $error')));
                    },
                    (session) async {
                      // Filter out completed exercises
                      final incompleteExercises = session.exercises
                          .where((ex) => !ex.isCompleted)
                          .toList();

                      if (incompleteExercises.isEmpty && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Bạn đã hoàn thành tất cả bài tập!'),
                          ),
                        );
                        return;
                      }

                      // Create a new session with only incomplete exercises
                      final filteredSession = ExerciseSessionModel(
                        sessionId: session.sessionId,
                        lessonId: session.lessonId,
                        exercises: incompleteExercises,
                        totalTimeLimit: session.totalTimeLimit,
                        startedAt: session.startedAt,
                        expiresAt: session.expiresAt,
                      );

                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExerciseDoingScreen(
                            session: filteredSession,
                            currentIndex: 0,
                          ),
                        ),
                      );

                      // If completed, refresh the list
                      if (result == true && context.mounted) {
                        context.read<LessonExerciseBloc>().add(
                          LoadLessonExercises(lessonId),
                        );
                      }
                    },
                  );
                }
              },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: categoryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        '$number',
                        style: TextStyle(
                          color: categoryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          exercise.question,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(categoryIcon, size: 14, color: categoryColor),
                            const SizedBox(width: 4),
                            Text(
                              typeLabel,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (exercise.isCompleted)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 16,
                            color: Colors.green.shade700,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Hoàn thành',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.green.shade700,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildInfoChip(
                    Icons.star,
                    '${exercise.points} điểm',
                    Colors.amber,
                  ),
                  if (exercise.timeLimit != null) ...[
                    const SizedBox(width: 8),
                    _buildInfoChip(
                      Icons.timer,
                      '${exercise.timeLimit}s',
                      Colors.blue,
                    ),
                  ],
                  const SizedBox(width: 8),
                  _buildDifficultyChip(exercise.difficulty),
                  if (exercise.attempts > 0) ...[
                    const SizedBox(width: 8),
                    _buildInfoChip(
                      Icons.replay,
                      '${exercise.attempts} lần',
                      Colors.grey,
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDifficultyChip(int difficulty) {
    Color color;
    String label;

    switch (difficulty) {
      case 1:
        color = Colors.green;
        label = 'Dễ';
        break;
      case 2:
        color = Colors.orange;
        label = 'Trung bình';
        break;
      case 3:
        color = Colors.red;
        label = 'Khó';
        break;
      default:
        color = Colors.grey;
        label = 'Level $difficulty';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.signal_cellular_alt, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
