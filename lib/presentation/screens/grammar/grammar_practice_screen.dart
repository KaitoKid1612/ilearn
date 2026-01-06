import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ilearn/core/theme/app_colors.dart';
import 'package:ilearn/data/models/grammar_practice_model.dart';
import 'package:ilearn/presentation/bloc/grammar_practice/grammar_practice_bloc.dart';
import 'package:ilearn/presentation/bloc/grammar_practice/grammar_practice_event.dart';

class GrammarPracticeScreen extends StatefulWidget {
  final String grammarId;
  final String lessonId;
  final String grammarTitle;

  const GrammarPracticeScreen({
    Key? key,
    required this.grammarId,
    required this.lessonId,
    required this.grammarTitle,
  }) : super(key: key);

  @override
  State<GrammarPracticeScreen> createState() => _GrammarPracticeScreenState();
}

class _GrammarPracticeScreenState extends State<GrammarPracticeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GrammarPracticeBloc>().add(
      StartGrammarPractice(widget.grammarId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Practice: ${widget.grammarTitle}',
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
      body: BlocConsumer<GrammarPracticeBloc, GrammarPracticeState>(
        listener: (context, state) {
          if (state is GrammarPracticeError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
          if (state is GrammarPracticeCompleted) {
            _showResultDialog(context, state.result);
          }
        },
        builder: (context, state) {
          if (state is GrammarPracticeLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is GrammarPracticeLoaded) {
            return _buildPracticeContent(context, state);
          }

          if (state is GrammarPracticeSubmitting) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Đang chấm bài...'),
                ],
              ),
            );
          }

          return const Center(child: Text('No practice available'));
        },
      ),
    );
  }

  Widget _buildPracticeContent(
    BuildContext context,
    GrammarPracticeLoaded state,
  ) {
    final exercise = state.practiceData.exercises[state.currentQuestionIndex];
    final progress =
        (state.currentQuestionIndex + 1) / state.practiceData.exercises.length;

    return Column(
      children: [
        // Progress bar
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey[300],
          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
        ),
        // Question counter
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Question ${state.currentQuestionIndex + 1}/${state.practiceData.exercises.length}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${state.userAnswers.length}/${state.practiceData.exercises.length} answered',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
        // Exercise content
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: _buildExerciseWidget(context, exercise, state),
          ),
        ),
        // Navigation buttons
        _buildNavigationButtons(context, state),
      ],
    );
  }

  Widget _buildExerciseWidget(
    BuildContext context,
    GrammarExerciseModel exercise,
    GrammarPracticeLoaded state,
  ) {
    switch (exercise.type) {
      case ExerciseType.FILL_BLANK:
        return _buildFillInBlank(context, exercise, state);
      case ExerciseType.MULTIPLE_CHOICE:
        return _buildMultipleChoice(context, exercise, state);
      case ExerciseType.SENTENCE_BUILD:
        return _buildSentenceBuild(context, exercise, state);
      case ExerciseType.TRANSFORM:
        return _buildTransform(context, exercise, state);
    }
  }

  Widget _buildFillInBlank(
    BuildContext context,
    GrammarExerciseModel exercise,
    GrammarPracticeLoaded state,
  ) {
    final selectedAnswer = state.userAnswers[state.currentQuestionIndex];
    // For FILL_BLANK type without options, use text input
    final controller = TextEditingController(text: selectedAnswer ?? '');

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.edit, color: AppColors.primary),
                SizedBox(width: 8),
                Text(
                  'Fill in the Blank',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              exercise.question,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            if (exercise.hint != null) ...<Widget>[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.lightbulb_outline,
                      color: Colors.blue,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        exercise.hint!,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 24),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Type your answer here...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[50],
              ),
              style: const TextStyle(fontSize: 18),
              onChanged: (value) => _selectAnswer(context, state, value),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMultipleChoice(
    BuildContext context,
    GrammarExerciseModel exercise,
    GrammarPracticeLoaded state,
  ) {
    final options = exercise.optionsMap ?? {};
    final selectedAnswer = state.userAnswers[state.currentQuestionIndex];

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.radio_button_checked, color: AppColors.primary),
                SizedBox(width: 8),
                Text(
                  'Multiple Choice',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              exercise.question,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            if (exercise.hint != null) ...<Widget>[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.lightbulb_outline,
                      color: Colors.blue,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        exercise.hint!,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 24),
            ...options.entries.map(
              (entry) => _buildMultipleChoiceOption(
                context,
                entry.key,
                entry.value,
                selectedAnswer == entry.key,
                () => _selectAnswer(context, state, entry.key),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSentenceBuild(
    BuildContext context,
    GrammarExerciseModel exercise,
    GrammarPracticeLoaded state,
  ) {
    final words = exercise.wordsList ?? [];
    final selectedAnswer = state.userAnswers[state.currentQuestionIndex];
    final currentWords = selectedAnswer?.split('') ?? [];

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.build, color: AppColors.primary),
                SizedBox(width: 8),
                Text(
                  'Sentence Building',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              exercise.question,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 24),
            // Answer area
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              constraints: const BoxConstraints(minHeight: 80),
              width: double.infinity,
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: currentWords.isEmpty
                    ? [
                        Text(
                          'Tap words below to build the sentence',
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                      ]
                    : currentWords
                          .map(
                            (word) => Chip(
                              label: Text(word),
                              onDeleted: () {
                                final newWords = List<String>.from(currentWords)
                                  ..remove(word);
                                _selectAnswer(
                                  context,
                                  state,
                                  newWords.join(''),
                                );
                              },
                            ),
                          )
                          .toList(),
              ),
            ),
            const SizedBox(height: 16),
            // Word options
            const Text(
              'Available words:',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: words
                  .map(
                    (word) => ActionChip(
                      label: Text(word),
                      backgroundColor: currentWords.contains(word)
                          ? Colors.grey[300]
                          : AppColors.primary.withOpacity(0.1),
                      onPressed: currentWords.contains(word)
                          ? null
                          : () {
                              final newWords = List<String>.from(currentWords)
                                ..add(word);
                              _selectAnswer(context, state, newWords.join(''));
                            },
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransform(
    BuildContext context,
    GrammarExerciseModel exercise,
    GrammarPracticeLoaded state,
  ) {
    final controller = TextEditingController(
      text: state.userAnswers[state.currentQuestionIndex] ?? '',
    );

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.transform, color: AppColors.primary),
                SizedBox(width: 8),
                Text(
                  'Transform',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              exercise.question,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Type your answer here...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[50],
              ),
              style: const TextStyle(fontSize: 16),
              onChanged: (value) => _selectAnswer(context, state, value),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton(
    BuildContext context,
    String option,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withOpacity(0.1) : Colors.white,
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.check_circle : Icons.circle_outlined,
              color: isSelected ? AppColors.primary : Colors.grey,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                option,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: isSelected ? AppColors.primary : Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMultipleChoiceOption(
    BuildContext context,
    String key,
    String value,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withOpacity(0.1) : Colors.white,
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                key,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : Colors.black87,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: isSelected ? AppColors.primary : Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButtons(
    BuildContext context,
    GrammarPracticeLoaded state,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        children: [
          if (state.currentQuestionIndex > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  context.read<GrammarPracticeBloc>().add(PreviousQuestion());
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Previous'),
              ),
            ),
          if (state.currentQuestionIndex > 0) const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: state.hasAnsweredCurrent
                  ? () {
                      if (state.isLastQuestion) {
                        _submitPractice(context, state);
                      } else {
                        context.read<GrammarPracticeBloc>().add(NextQuestion());
                      }
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                state.isLastQuestion ? 'Submit' : 'Next',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _selectAnswer(
    BuildContext context,
    GrammarPracticeLoaded state,
    String answer,
  ) {
    context.read<GrammarPracticeBloc>().add(
      AnswerQuestion(state.currentQuestionIndex, answer),
    );
  }

  void _submitPractice(BuildContext context, GrammarPracticeLoaded state) {
    // Convert Map<int, String> to Map<String, dynamic>
    final answersMap = state.userAnswers.map(
      (key, value) => MapEntry(key.toString(), value),
    );

    context.read<GrammarPracticeBloc>().add(
      SubmitPractice(state.practiceData.exerciseId, answersMap),
    );
  }

  void _showResultDialog(
    BuildContext context,
    SubmitGrammarPracticeResponseModel result,
  ) {
    final percentage = result.accuracy;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(
              percentage >= 80
                  ? Icons.emoji_events
                  : percentage >= 60
                  ? Icons.thumb_up
                  : Icons.refresh,
              color: percentage >= 80
                  ? Colors.amber
                  : percentage >= 60
                  ? Colors.green
                  : Colors.orange,
              size: 32,
            ),
            const SizedBox(width: 12),
            const Text('Practice Complete!'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${percentage.toStringAsFixed(1)}%',
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '${result.correctAnswers}/${result.totalQuestions} correct',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              '+${result.pointsEarned} Points',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.pop();
            },
            child: const Text('Done'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<GrammarPracticeBloc>().add(
                StartGrammarPractice(widget.grammarId),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            child: const Text(
              'Practice Again',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
