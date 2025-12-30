import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ilearn/presentation/bloc/vocabulary/vocabulary_bloc.dart';

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
      appBar: AppBar(title: Text(widget.lessonTitle), elevation: 0),
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
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${state.message}',
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<VocabularyBloc>().add(
                        LoadVocabularyLesson(widget.lessonId),
                      );
                    },
                    child: const Text('Retry'),
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
    );
  }

  Widget _buildProgressOverview(VocabularyLoaded state) {
    final progress = state.progress;

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Learning Progress',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          if (progress != null) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(
                  'Total',
                  progress.totalVocabulary.toString(),
                  Colors.blue,
                ),
                _buildStatItem(
                  'Learned',
                  progress.learned.toString(),
                  Colors.green,
                ),
                _buildStatItem(
                  'Mastered',
                  progress.mastered.toString(),
                  Colors.purple,
                ),
                _buildStatItem(
                  'New',
                  progress.notStarted.toString(),
                  Colors.orange,
                ),
              ],
            ),
          ] else ...[
            const Text('Start learning to track your progress!'),
          ],
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _buildLearningModes(BuildContext context, VocabularyLoaded state) {
    final progress = state.progress?.progressByMode;

    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(16),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: [
        _buildModeCard(
          context: context,
          icon: Icons.menu_book,
          title: 'Learn',
          subtitle: 'Flashcards',
          color: Colors.blue,
          progress: progress?.learn,
          onTap: () => _navigateToLearnMode(context, state),
        ),
        _buildModeCard(
          context: context,
          icon: Icons.quiz,
          title: 'Practice',
          subtitle: 'Quiz',
          color: Colors.green,
          progress: progress?.practice,
          onTap: () => _navigateToPracticeMode(context, state),
        ),
        _buildModeCard(
          context: context,
          icon: Icons.mic,
          title: 'Speaking',
          subtitle: 'Pronunciation',
          color: Colors.orange,
          progress: progress?.speaking,
          onTap: () => _navigateToSpeakingMode(context, state),
        ),
        _buildModeCard(
          context: context,
          icon: Icons.edit,
          title: 'Writing',
          subtitle: 'Practice',
          color: Colors.purple,
          progress: progress?.writing,
          onTap: () => _navigateToWritingMode(context, state),
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: color),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              if (progress != null) ...[
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: progress.percentage / 100,
                  backgroundColor: Colors.grey.shade300,
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
                const SizedBox(height: 4),
                Text(
                  '${progress.completed}/${progress.total}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
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
      'vocabulary-learn',
      extra: {
        'lessonId': widget.lessonId,
        'vocabulary': state.lessonData.vocabulary,
        'progress': state.progress,
      },
    );
  }

  void _navigateToPracticeMode(BuildContext context, VocabularyLoaded state) {
    context.pushNamed(
      'vocabulary-practice',
      extra: {
        'lessonId': widget.lessonId,
        'vocabulary': state.lessonData.vocabulary,
        'progress': state.progress,
      },
    );
  }

  void _navigateToSpeakingMode(BuildContext context, VocabularyLoaded state) {
    context.pushNamed(
      'vocabulary-speaking',
      extra: {
        'lessonId': widget.lessonId,
        'vocabulary': state.lessonData.vocabulary,
        'progress': state.progress,
      },
    );
  }

  void _navigateToWritingMode(BuildContext context, VocabularyLoaded state) {
    context.pushNamed(
      'vocabulary-writing',
      extra: {
        'lessonId': widget.lessonId,
        'vocabulary': state.lessonData.vocabulary,
        'progress': state.progress,
      },
    );
  }
}
