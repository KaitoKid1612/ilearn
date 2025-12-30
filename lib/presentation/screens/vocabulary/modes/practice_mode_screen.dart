import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilearn/domain/entities/vocabulary.dart';
import 'package:ilearn/domain/entities/vocabulary_progress.dart';
import 'package:ilearn/presentation/bloc/vocabulary/vocabulary_bloc.dart';
import 'dart:math';

class PracticeModeScreen extends StatefulWidget {
  final String lessonId;
  final List<Vocabulary> vocabulary;
  final VocabularyProgress? progress;

  const PracticeModeScreen({
    Key? key,
    required this.lessonId,
    required this.vocabulary,
    this.progress,
  }) : super(key: key);

  @override
  State<PracticeModeScreen> createState() => _PracticeModeScreenState();
}

class _PracticeModeScreenState extends State<PracticeModeScreen> {
  int _currentQuestionIndex = 0;
  int _correctAnswers = 0;
  String? _selectedAnswer;
  bool _showResult = false;
  List<QuizQuestion> _questions = [];

  @override
  void initState() {
    super.initState();
    _generateQuestions();
  }

  void _generateQuestions() {
    final random = Random();
    _questions = [];

    for (var vocab in widget.vocabulary) {
      // Create multiple choice question
      final wrongAnswers =
          widget.vocabulary
              .where((v) => v.id != vocab.id)
              .map((v) => v.meaning)
              .toList()
            ..shuffle(random);

      final options = [vocab.meaning, ...wrongAnswers.take(3)]..shuffle(random);

      _questions.add(
        QuizQuestion(
          word: vocab.word,
          romaji: vocab.romaji,
          correctAnswer: vocab.meaning,
          options: options,
        ),
      );
    }

    _questions.shuffle(random);
  }

  void _selectAnswer(String answer) {
    if (_showResult) return;

    setState(() {
      _selectedAnswer = answer;
      _showResult = true;

      if (answer == _questions[_currentQuestionIndex].correctAnswer) {
        _correctAnswers++;
      }
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedAnswer = null;
        _showResult = false;
      });
    } else {
      _completeQuiz();
    }
  }

  void _completeQuiz() {
    final percentage = (_correctAnswers / _questions.length * 100).round();

    context.read<VocabularyBloc>().add(
      SubmitProgress(widget.lessonId, {
        'mode': 'PRACTICE',
        'correctAnswers': _correctAnswers,
        'totalQuestions': _questions.length,
        'percentage': percentage,
        'timestamp': DateTime.now().toIso8601String(),
      }),
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Quiz Completed! 🎉'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$percentage%',
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'You got $_correctAnswers out of ${_questions.length} correct!',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Done'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _currentQuestionIndex = 0;
                _correctAnswers = 0;
                _selectedAnswer = null;
                _showResult = false;
                _generateQuestions();
              });
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Practice Mode')),
        body: const Center(child: Text('Not enough vocabulary for quiz')),
      );
    }

    final question = _questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('✏️ Practice Mode - Quiz'),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '${_currentQuestionIndex + 1}/${_questions.length}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress bar
          LinearProgressIndicator(
            value: (_currentQuestionIndex + 1) / _questions.length,
            backgroundColor: Colors.grey.shade300,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
          ),

          // Score
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Score: $_correctAnswers/${_currentQuestionIndex + (_showResult ? 1 : 0)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (_showResult)
                  Icon(
                    _selectedAnswer == question.correctAnswer
                        ? Icons.check_circle
                        : Icons.cancel,
                    color: _selectedAnswer == question.correctAnswer
                        ? Colors.green
                        : Colors.red,
                    size: 32,
                  ),
              ],
            ),
          ),

          // Question
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          const Text(
                            'What does this mean?',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            question.word,
                            style: const TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            question.romaji,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Options
                  ...question.options.map((option) {
                    final isSelected = _selectedAnswer == option;
                    final isCorrect = option == question.correctAnswer;
                    final showCorrect = _showResult && isCorrect;
                    final showWrong = _showResult && isSelected && !isCorrect;

                    Color? backgroundColor;
                    if (showCorrect) {
                      backgroundColor = Colors.green.shade100;
                    } else if (showWrong) {
                      backgroundColor = Colors.red.shade100;
                    } else if (isSelected) {
                      backgroundColor = Colors.blue.shade100;
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: InkWell(
                        onTap: () => _selectAnswer(option),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            border: Border.all(
                              color: showCorrect
                                  ? Colors.green
                                  : showWrong
                                  ? Colors.red
                                  : isSelected
                                  ? Colors.blue
                                  : Colors.grey.shade300,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  option,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              if (showCorrect)
                                const Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                ),
                              if (showWrong)
                                const Icon(Icons.cancel, color: Colors.red),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),

          // Next button
          if (_showResult)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _nextQuestion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 48,
                    vertical: 16,
                  ),
                ),
                child: Text(
                  _currentQuestionIndex < _questions.length - 1
                      ? 'Next'
                      : 'Finish',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class QuizQuestion {
  final String word;
  final String romaji;
  final String correctAnswer;
  final List<String> options;

  QuizQuestion({
    required this.word,
    required this.romaji,
    required this.correctAnswer,
    required this.options,
  });
}
