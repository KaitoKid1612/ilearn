import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../bloc/typing_exercise/typing_exercise_bloc.dart';
import '../../bloc/typing_exercise/typing_exercise_event.dart';
import '../../bloc/typing_exercise/typing_exercise_state.dart';
import 'typing_exercise_result_screen.dart';

class TypingExerciseScreen extends StatelessWidget {
  final String lessonId;

  const TypingExerciseScreen({super.key, required this.lessonId});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TypingExerciseBloc, TypingExerciseState>(
      listener: (context, state) {
        if (state is TypingExerciseCompleted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => TypingExerciseResultScreen(result: state.result),
            ),
          );
        } else if (state is TypingExerciseError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        if (state is TypingExerciseInitial) {
          context.read<TypingExerciseBloc>().add(
            LoadTypingExerciseEvent(lessonId),
          );
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is TypingExerciseLoading ||
            state is TypingExerciseSubmitting) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(
                    state is TypingExerciseSubmitting
                        ? 'Đang chấm bài...'
                        : 'Đang tải bài tập...',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        }

        if (state is TypingExerciseInProgress) {
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

  Widget _buildProgressBar(TypingExerciseInProgress state) {
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

  Widget _buildQuestionContent(
    BuildContext context,
    TypingExerciseInProgress state,
  ) {
    final question = state.currentQuestion;
    final currentAnswer = state.currentAnswer ?? '';
    final textController = TextEditingController(text: currentAnswer);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Question
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
                const SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.lightbulb_outline,
                            size: 16,
                            color: Colors.blue.shade700,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Gợi ý: ${question.hint}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Viết bằng ${question.answerType}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.orange.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
                if (question.audio != null) ...[
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Play audio
                    },
                    icon: const Icon(Icons.volume_up),
                    label: const Text('Nghe phát âm'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Input field
          TextField(
            controller: textController,
            onChanged: (value) {
              context.read<TypingExerciseBloc>().add(
                TypeAnswerEvent(questionId: question.id, answer: value),
              );
            },
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
            decoration: InputDecoration(
              hintText: 'Nhập câu trả lời...',
              hintStyle: TextStyle(fontSize: 24, color: Colors.grey.shade400),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 2,
                ),
              ),
              contentPadding: const EdgeInsets.all(20),
            ),
            autofocus: true,
            enableIMEPersonalizedLearning: true,
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 16),
          // Answer status - chỉ hiển thị khi có ít nhất 2 ký tự
          if (currentAnswer.trim().length >= 2)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green.shade700),
                  const SizedBox(width: 8),
                  Text(
                    'Đã trả lời',
                    style: TextStyle(
                      color: Colors.green.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    TypingExerciseInProgress state,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200, width: 1)),
      ),
      child: Row(
        children: [
          if (!state.isFirstQuestion)
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  context.read<TypingExerciseBloc>().add(
                    const PreviousTypingQuestionEvent(),
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
              onPressed: () {
                if (state.isLastQuestion) {
                  _showSubmitConfirmation(context, state);
                } else {
                  context.read<TypingExerciseBloc>().add(
                    const NextTypingQuestionEvent(),
                  );
                }
              },
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

  void _showSubmitConfirmation(
    BuildContext context,
    TypingExerciseInProgress state,
  ) {
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
              context.read<TypingExerciseBloc>().add(
                const SubmitTypingExerciseEvent(),
              );
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
