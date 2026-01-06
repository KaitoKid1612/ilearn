import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ilearn/core/theme/app_colors.dart';
import 'package:ilearn/data/models/lesson_exercise_model.dart';
import 'package:ilearn/data/models/exercise_session_model.dart';
import 'exercise_session_result_screen.dart';

class ExerciseDoingScreen extends StatefulWidget {
  final ExerciseSessionModel session;
  final int currentIndex;
  final Map<String, String> allAnswers;
  final int elapsedSeconds;

  const ExerciseDoingScreen({
    super.key,
    required this.session,
    required this.currentIndex,
    this.allAnswers = const {},
    this.elapsedSeconds = 0,
  });

  @override
  State<ExerciseDoingScreen> createState() => _ExerciseDoingScreenState();
}

class _ExerciseDoingScreenState extends State<ExerciseDoingScreen> {
  String? selectedAnswer;
  late Map<String, String> answers;
  Timer? _timer;
  late int totalElapsedSeconds;
  late int remainingSeconds;

  LessonExerciseItemModel get currentExercise =>
      widget.session.exercises[widget.currentIndex];
  int get totalExercises => widget.session.exercises.length;

  @override
  void initState() {
    super.initState();
    answers = Map.from(widget.allAnswers);
    totalElapsedSeconds = widget.elapsedSeconds;

    // Calculate remaining time
    final totalTimeLimit = widget.session.totalTimeLimit ?? 0;
    remainingSeconds = totalTimeLimit - totalElapsedSeconds;

    // Load previous answer if exists
    selectedAnswer = answers[currentExercise.id];

    // Start timer
    if (remainingSeconds > 0) {
      _startTimer();
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          totalElapsedSeconds++;
          remainingSeconds--;

          if (remainingSeconds <= 0) {
            _timer?.cancel();
            _handleTimeUp();
          }
        });
      }
    });
  }

  void _handleTimeUp() {
    // Auto submit when time's up
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Hết giờ! Đang nộp bài...')));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ExerciseSessionResultScreen(
          session: widget.session,
          answers: answers,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _handleNext() async {
    // Save current answer - convert option ID to text
    if (selectedAnswer != null) {
      String answerText = selectedAnswer!;

      // If this is a multiple choice with options, get the text instead of ID
      if (currentExercise.options != null &&
          currentExercise.options!.isNotEmpty) {
        final selectedOption = currentExercise.options!.firstWhere(
          (opt) => opt.id == selectedAnswer,
          orElse: () => currentExercise.options!.first,
        );
        answerText = selectedOption.text;
      }

      answers[currentExercise.id] = answerText;
    }

    if (widget.currentIndex < widget.session.exercises.length - 1) {
      // Go to next exercise
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ExerciseDoingScreen(
            session: widget.session,
            currentIndex: widget.currentIndex + 1,
            allAnswers: answers,
            elapsedSeconds: totalElapsedSeconds,
          ),
        ),
      );
    } else {
      // All exercises completed, go to result screen
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ExerciseSessionResultScreen(
            session: widget.session,
            answers: answers,
          ),
        ),
      );

      // Pop all exercise screens and return result to list screen
      if (mounted) {
        Navigator.of(context).pop(result);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Câu ${widget.currentIndex + 1}/$totalExercises'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          // Timer display
          if (widget.session.totalTimeLimit != null &&
              widget.session.totalTimeLimit! > 0)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: remainingSeconds <= 30
                        ? Colors.red.shade100
                        : Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.timer,
                        color: remainingSeconds <= 30
                            ? Colors.red.shade700
                            : Colors.white,
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${remainingSeconds ~/ 60}:${(remainingSeconds % 60).toString().padLeft(2, '0')}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: remainingSeconds <= 30
                              ? Colors.red.shade700
                              : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 20),
                const SizedBox(width: 4),
                Text(
                  '${currentExercise.points}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildProgressBar(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildCategoryBadge(),
                  const SizedBox(height: 16),
                  _buildQuestion(),
                  const SizedBox(height: 24),
                  _buildExerciseContent(),
                ],
              ),
            ),
          ),
          _buildBottomActions(),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    final progress = (widget.currentIndex + 1) / totalExercises;
    return LinearProgressIndicator(
      value: progress,
      minHeight: 6,
      backgroundColor: Colors.grey.shade300,
      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
    );
  }

  Widget _buildCategoryBadge() {
    Color categoryColor;
    IconData categoryIcon;
    String categoryLabel;

    switch (currentExercise.category) {
      case 'vocabulary':
        categoryColor = Colors.blue;
        categoryIcon = Icons.book;
        categoryLabel = 'Từ vựng';
        break;
      case 'kanji':
        categoryColor = Colors.orange;
        categoryIcon = Icons.text_fields;
        categoryLabel = 'Kanji';
        break;
      case 'grammar':
        categoryColor = Colors.green;
        categoryIcon = Icons.menu_book;
        categoryLabel = 'Ngữ pháp';
        break;
      default:
        categoryColor = Colors.purple;
        categoryIcon = Icons.quiz;
        categoryLabel = 'Tổng hợp';
    }

    // Get type label
    String typeLabel;
    switch (currentExercise.type) {
      case 'MULTIPLE_CHOICE':
        typeLabel = 'Trắc nghiệm';
        break;
      case 'FILL_IN_BLANK':
        typeLabel = 'Điền từ';
        break;
      case 'TRANSFORM':
        typeLabel = 'Chuyển đổi câu';
        break;
      case 'SENTENCE_BUILD':
        typeLabel = 'Sắp xếp câu';
        break;
      default:
        typeLabel = currentExercise.type;
    }

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: categoryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: categoryColor, width: 1.5),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(categoryIcon, size: 16, color: categoryColor),
              const SizedBox(width: 6),
              Text(
                categoryLabel,
                style: TextStyle(
                  color: categoryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            typeLabel,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuestion() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Câu hỏi',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              currentExercise.question,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                height: 1.4,
              ),
            ),
            if (currentExercise.audio != null) ...[
              const SizedBox(height: 16),
              IconButton(
                icon: const Icon(Icons.volume_up, color: AppColors.primary),
                iconSize: 32,
                onPressed: () {
                  // TODO: Play audio
                },
              ),
            ],
            if (currentExercise.image != null) ...[
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  currentExercise.image!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseContent() {
    // Check if has options
    final hasOptions =
        currentExercise.options != null && currentExercise.options!.isNotEmpty;

    switch (currentExercise.type) {
      case 'MULTIPLE_CHOICE':
        // Multiple choice always needs options
        if (hasOptions) {
          return _buildMultipleChoiceOptions();
        } else {
          return _buildNoOptionsError();
        }

      case 'FILL_IN_BLANK':
        // Fill in blank: if has options, show as choices; otherwise text input
        if (hasOptions) {
          return _buildMultipleChoiceOptions();
        } else {
          return _buildTextInputExercise('Điền vào chỗ trống:');
        }

      case 'TRANSFORM':
        // Transform always uses text input
        return _buildTextInputExercise('Nhập câu trả lời của bạn:');

      case 'SENTENCE_BUILD':
        // Sentence build needs options to arrange
        if (hasOptions) {
          return _buildSentenceBuildExercise();
        } else {
          return _buildTextInputExercise('Nhập câu hoàn chỉnh:');
        }

      default:
        return hasOptions
            ? _buildMultipleChoiceOptions()
            : _buildTextInputExercise('Nhập câu trả lời:');
    }
  }

  Widget _buildMultipleChoiceOptions() {
    if (currentExercise.options == null || currentExercise.options!.isEmpty) {
      return const Text('Không có options');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: currentExercise.options!.asMap().entries.map((entry) {
        final index = entry.key;
        final option = entry.value;
        final isSelected = selectedAnswer == option.id;

        Color borderColor = Colors.grey.shade300;
        Color bgColor = Colors.white;

        if (isSelected) {
          borderColor = AppColors.primary;
          bgColor = AppColors.primary.withOpacity(0.05);
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: InkWell(
            onTap: () {
              setState(() {
                selectedAnswer = option.id;
              });
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: bgColor,
                border: Border.all(color: borderColor, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: borderColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        String.fromCharCode(65 + index), // A, B, C, D
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : Colors.grey.shade700,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      option.text,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTextInputExercise(String label) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                hintText: 'Nhập câu trả lời...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: AppColors.primary,
                    width: 2,
                  ),
                ),
              ),
              maxLines: 3,
              style: const TextStyle(fontSize: 16),
              onChanged: (value) {
                setState(() {
                  selectedAnswer = value.trim().isNotEmpty ? value : null;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoOptionsError() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.orange.shade700),
            const SizedBox(height: 16),
            Text(
              'Bài tập này chưa có đáp án',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.orange.shade700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Vui lòng thử bài tập khác',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSentenceBuildExercise() {
    // For sentence build, show options as draggable words
    final options = currentExercise.options;
    if (options == null || options.isEmpty) {
      return _buildTextInputExercise('Nhập câu hoàn chỉnh:');
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Sắp xếp các từ sau thành câu hoàn chỉnh:',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            // Display words as chips that can be tapped
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: options.map((option) {
                final isSelected = selectedAnswer == option.id;
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedAnswer = option.id;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : Colors.grey.shade400,
                        width: 2,
                      ),
                    ),
                    child: Text(
                      option.text,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: isSelected ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const Text(
                '💡 Tip: Nhấn vào các từ để sắp xếp câu\n(Tính năng kéo thả sẽ được cập nhật sau)',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: ElevatedButton(
          onPressed: selectedAnswer == null ? null : _handleNext,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            disabledBackgroundColor: Colors.grey.shade300,
          ),
          child: Center(
            child: Text(
              widget.currentIndex < widget.session.exercises.length - 1
                  ? 'Tiếp theo'
                  : 'Hoàn thành',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
