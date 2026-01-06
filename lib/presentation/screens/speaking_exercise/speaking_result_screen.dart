import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/speaking_exercise.dart';

class SpeakingResultScreen extends StatelessWidget {
  final SpeakingExerciseResult result;

  const SpeakingResultScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final percentage = (result.score * 100).toStringAsFixed(0);
    final isPassed = result.score >= 0.7;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Kết quả'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Score card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Icon(
                      isPassed ? Icons.celebration : Icons.refresh,
                      size: 80,
                      color: isPassed ? AppColors.accent : Colors.orange,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      isPassed ? 'Xuất sắc!' : 'Cần cải thiện',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Điểm số: $percentage%',
                      style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem(
                          icon: Icons.quiz,
                          label: 'Tổng số câu',
                          value: result.totalQuestions.toString(),
                        ),
                        _buildStatItem(
                          icon: Icons.check_circle,
                          label: 'Đúng',
                          value: result.correctAnswers.toString(),
                          color: AppColors.accent,
                        ),
                        _buildStatItem(
                          icon: Icons.cancel,
                          label: 'Sai',
                          value: (result.totalQuestions - result.correctAnswers)
                              .toString(),
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Question results
            const Text(
              'Chi tiết từng câu:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            ...result.questionResults.asMap().entries.map((entry) {
              final index = entry.key;
              final questionResult = entry.value;

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: questionResult.isCorrect
                        ? AppColors.accent.withOpacity(0.3)
                        : Colors.red.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: questionResult.isCorrect
                                  ? AppColors.accent
                                  : Colors.red,
                            ),
                            child: Center(
                              child: Text(
                                '${index + 1}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Icon(
                            questionResult.isCorrect
                                ? Icons.check_circle
                                : Icons.cancel,
                            color: questionResult.isCorrect
                                ? AppColors.accent
                                : Colors.red,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            questionResult.isCorrect ? 'Đúng' : 'Sai',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: questionResult.isCorrect
                                  ? AppColors.accent
                                  : Colors.red,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${(questionResult.confidence * 100).toStringAsFixed(0)}%',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Expected text
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.lightbulb_outline,
                              size: 16,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Đáp án đúng: ',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                questionResult.expectedText,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),

                      // User transcription
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: questionResult.isCorrect
                              ? AppColors.accent.withOpacity(0.1)
                              : Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.mic,
                              size: 16,
                              color: questionResult.isCorrect
                                  ? AppColors.accent
                                  : Colors.red,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Bạn đã đọc: ',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                questionResult.userTranscription,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Similarity score
                      if (!questionResult.isCorrect) ...[
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: questionResult.similarityScore,
                          backgroundColor: Colors.grey[200],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            questionResult.similarityScore >= 0.7
                                ? Colors.orange
                                : Colors.red,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Độ tương đồng: ${(questionResult.similarityScore * 100).toStringAsFixed(0)}%',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 24),

            // Action buttons
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Hoàn thành',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            if (!isPassed)
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Could trigger reload of the exercise
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Làm lại',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    Color? color,
  }) {
    return Column(
      children: [
        Icon(icon, size: 32, color: color ?? Colors.grey[700]),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color ?? Colors.grey[800],
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }
}
