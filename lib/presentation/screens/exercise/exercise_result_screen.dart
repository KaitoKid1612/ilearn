import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/exercise.dart';

class ExerciseResultScreen extends StatelessWidget {
  final ExerciseResult result;

  const ExerciseResultScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final percentage = (result.correctAnswers / result.totalQuestions * 100)
        .round();
    final isPassed = percentage >= 70;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kết quả'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildScoreCard(percentage, isPassed),
            const SizedBox(height: 24),
            _buildStatistics(),
            const SizedBox(height: 24),
            _buildDetailedResults(),
            const SizedBox(height: 24),
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreCard(int percentage, bool isPassed) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isPassed
              ? [Colors.green.shade400, Colors.green.shade600]
              : [Colors.orange.shade400, Colors.orange.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: (isPassed ? Colors.green : Colors.orange).withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            result.message,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            '$percentage%',
            style: const TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${result.correctAnswers}/${result.totalQuestions} câu đúng',
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 20),
                const SizedBox(width: 8),
                Text(
                  '+${result.pointsEarned} điểm',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatistics() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            icon: Icons.check_circle,
            iconColor: Colors.green,
            label: 'Đúng',
            value: '${result.correctAnswers}',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            icon: Icons.cancel,
            iconColor: Colors.red,
            label: 'Sai',
            value: '${result.incorrectAnswers}',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            icon: Icons.assessment,
            iconColor: AppColors.primary,
            label: 'Điểm',
            value: '${result.score}',
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 32),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedResults() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Chi tiết kết quả',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const Divider(height: 1),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: result.results.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final questionResult = result.results[index];
              return _buildResultItem(index + 1, questionResult);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildResultItem(int questionNumber, QuestionResult result) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: result.isCorrect
                  ? Colors.green.withOpacity(0.1)
                  : Colors.red.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$questionNumber',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: result.isCorrect ? Colors.green : Colors.red,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      result.isCorrect ? Icons.check_circle : Icons.cancel,
                      size: 18,
                      color: result.isCorrect ? Colors.green : Colors.red,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      result.isCorrect ? 'Đúng' : 'Sai',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: result.isCorrect ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
                if (!result.isCorrect) ...[
                  const SizedBox(height: 4),
                  Text(
                    'Bạn chọn: ${result.userAnswer}',
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                  Text(
                    'Đáp án đúng: ${result.correctAnswer}',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
          ),
          child: const Text(
            'Hoàn thành',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
