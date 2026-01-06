import 'package:flutter/material.dart';
import 'package:ilearn/core/theme/app_colors.dart';
import 'package:ilearn/data/models/exercise_session_model.dart';
import 'package:ilearn/core/di/dependency_injection.dart';
import 'package:ilearn/domain/repositories/exercise_repository.dart';

class ExerciseSessionResultScreen extends StatefulWidget {
  final ExerciseSessionModel session;
  final Map<String, String> answers;

  const ExerciseSessionResultScreen({
    super.key,
    required this.session,
    required this.answers,
  });

  @override
  State<ExerciseSessionResultScreen> createState() =>
      _ExerciseSessionResultScreenState();
}

class _ExerciseSessionResultScreenState
    extends State<ExerciseSessionResultScreen> {
  bool isSubmitting = true;
  ExerciseSessionResultModel? result;
  String? error;

  @override
  void initState() {
    super.initState();
    _submitSession();
  }

  Future<void> _submitSession() async {
    try {
      final repository = getIt<ExerciseRepository>();
      final submitResult = await repository.submitExerciseSession(
        widget.session.lessonId,
        widget.session.sessionId,
        widget.answers,
      );

      submitResult.fold(
        (err) {
          if (mounted) {
            setState(() {
              isSubmitting = false;
              error = err;
            });
          }
        },
        (data) {
          if (mounted) {
            setState(() {
              isSubmitting = false;
              result = data;
            });
          }
        },
      );
    } catch (e) {
      if (mounted) {
        setState(() {
          isSubmitting = false;
          error = e.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: isSubmitting
            ? _buildLoadingView()
            : error != null
            ? _buildErrorView()
            : _buildResultView(),
      ),
    );
  }

  Widget _buildLoadingView() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Colors.white),
          SizedBox(height: 24),
          Text(
            'Đang chấm điểm...',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 80, color: Colors.white),
            const SizedBox(height: 24),
            const Text(
              'Có lỗi xảy ra',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              error ?? 'Unknown error',
              style: const TextStyle(color: Colors.white70, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
              child: const Text(
                'Quay lại',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultView() {
    if (result == null) return const SizedBox();

    final isPassed = result!.isPassed;
    final percentage = result!.scorePercentage;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 40),
                Icon(
                  isPassed ? Icons.check_circle : Icons.cancel,
                  size: 100,
                  color: Colors.white,
                ),
                const SizedBox(height: 24),
                Text(
                  isPassed ? 'Xuất sắc!' : 'Cần cố gắng thêm',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '$percentage%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                _buildStatCard(
                  'Điểm số',
                  '${result!.totalPoints}',
                  Icons.star,
                  Colors.amber,
                ),
                const SizedBox(height: 12),
                _buildStatCard(
                  'Đúng / Tổng',
                  '${result!.correctCount} / ${result!.totalCount}',
                  Icons.check_circle,
                  Colors.green,
                ),
                const SizedBox(height: 12),
                _buildStatCard(
                  'Thời gian',
                  '${result!.totalTimeSpent}s',
                  Icons.timer,
                  Colors.blue,
                ),
                if (result!.heartsLost > 0) ...[
                  const SizedBox(height: 12),
                  _buildStatCard(
                    'Trái tim mất',
                    '${result!.heartsLost}',
                    Icons.favorite,
                    Colors.red,
                  ),
                ],
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(24),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Center(
              child: Text(
                'Hoàn thành',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
