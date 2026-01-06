import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../domain/entities/exercise.dart';
import '../../bloc/exercise/exercise_bloc.dart';
import '../../bloc/exercise/exercise_event.dart';
import '../../bloc/exercise/exercise_state.dart';
import 'exercise_result_screen.dart';

class ExerciseScreen extends StatelessWidget {
  final String lessonId;

  const ExerciseScreen({super.key, required this.lessonId});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExerciseBloc, ExerciseState>(
      listener: (context, state) {
        if (state is ExerciseCompleted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => ExerciseResultScreen(result: state.result),
            ),
          );
        } else if (state is ExerciseError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        if (state is ExerciseInitial) {
          context.read<ExerciseBloc>().add(LoadExerciseEvent(lessonId));
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is ExerciseLoading || state is ExerciseSubmitting) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(
                    state is ExerciseSubmitting
                        ? 'Đang chấm bài...'
                        : 'Đang tải bài tập...',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        }

        if (state is ExerciseInProgress) {
          return Scaffold(
            appBar: AppBar(
              title: Text(state.exercise.title),
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            body: Column(
              children: [
                _buildProgressBar(state),
                Expanded(child: _buildQuestionContent(context, state)),
                _buildActionButtons(context, state),
              ],
            ),
          );
        }

        return const Scaffold(body: Center(child: Text('Đã xảy ra lỗi')));
      },
    );
  }

  Widget _buildProgressBar(ExerciseInProgress state) {
    final progress = (state.currentQuestionIndex + 1) / state.totalQuestions;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Câu ${state.currentQuestionIndex + 1}/${state.totalQuestions}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                '${state.userAnswers.length}/${state.totalQuestions} đã trả lời',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
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

  Widget _buildQuestionContent(BuildContext context, ExerciseInProgress state) {
    final question = state.currentQuestion;
    final selectedAnswer = state.currentAnswer;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Question text
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  question.question,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                if (question.audio != null) ...[
                  const SizedBox(height: 12),
                  IconButton(
                    onPressed: () {
                      // TODO: Play audio
                    },
                    icon: const Icon(Icons.volume_up),
                    color: AppColors.primary,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Options
          ...question.options.asMap().entries.map((entry) {
            final option = entry.value;
            final isSelected = selectedAnswer == option.id;

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildOptionCard(context, option, isSelected, () {
                context.read<ExerciseBloc>().add(
                  SelectAnswerEvent(
                    questionId: question.id,
                    selectedOption: option.id,
                  ),
                );
              }),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildOptionCard(
    BuildContext context,
    QuestionOption option,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withOpacity(0.1) : Colors.white,
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: AppColors.primary.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.primary : Colors.grey.shade400,
                  width: 2,
                ),
                color: isSelected ? AppColors.primary : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                option.text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: isSelected ? AppColors.primary : AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, ExerciseInProgress state) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          if (!state.isFirstQuestion)
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  context.read<ExerciseBloc>().add(
                    const PreviousQuestionEvent(),
                  );
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: AppColors.primary),
                ),
                child: const Text('Quay lại'),
              ),
            ),
          if (!state.isFirstQuestion) const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: state.currentAnswer != null
                  ? () {
                      if (state.isLastQuestion) {
                        // Show confirm dialog before submit
                        _showSubmitConfirmation(context, state);
                      } else {
                        context.read<ExerciseBloc>().add(
                          const NextQuestionEvent(),
                        );
                      }
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
              child: Text(
                state.isLastQuestion ? 'Nộp bài' : 'Tiếp theo',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSubmitConfirmation(BuildContext context, ExerciseInProgress state) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Nộp bài'),
        content: Text(
          state.canSubmit
              ? 'Bạn đã trả lời tất cả ${state.totalQuestions} câu hỏi.\nBạn có chắc muốn nộp bài?'
              : 'Bạn còn ${state.totalQuestions - state.userAnswers.length} câu chưa trả lời.\nBạn có muốn nộp bài?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<ExerciseBloc>().add(const SubmitExerciseEvent());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            child: const Text('Nộp bài'),
          ),
        ],
      ),
    );
  }
}
