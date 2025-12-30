import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilearn/domain/entities/vocabulary.dart';
import 'package:ilearn/domain/entities/vocabulary_progress.dart';
import 'package:ilearn/presentation/bloc/vocabulary/vocabulary_bloc.dart';

class WritingModeScreen extends StatefulWidget {
  final String lessonId;
  final List<Vocabulary> vocabulary;
  final VocabularyProgress? progress;

  const WritingModeScreen({
    Key? key,
    required this.lessonId,
    required this.vocabulary,
    this.progress,
  }) : super(key: key);

  @override
  State<WritingModeScreen> createState() => _WritingModeScreenState();
}

class _WritingModeScreenState extends State<WritingModeScreen> {
  int _currentIndex = 0;
  int _correctCount = 0;
  final TextEditingController _controller = TextEditingController();
  bool _showResult = false;
  bool? _isCorrect;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _checkAnswer() {
    final vocab = widget.vocabulary[_currentIndex];
    final userAnswer = _controller.text.trim().toLowerCase();
    final correctAnswer = vocab.word.toLowerCase();

    setState(() {
      _showResult = true;
      _isCorrect = userAnswer == correctAnswer;
      if (_isCorrect!) {
        _correctCount++;
      }
    });
  }

  void _nextWord() {
    if (_currentIndex < widget.vocabulary.length - 1) {
      setState(() {
        _currentIndex++;
        _controller.clear();
        _showResult = false;
        _isCorrect = null;
      });
    } else {
      _completeWritingMode();
    }
  }

  void _completeWritingMode() {
    final percentage = (_correctCount / widget.vocabulary.length * 100).round();

    context.read<VocabularyBloc>().add(
      SubmitProgress(widget.lessonId, {
        'mode': 'WRITING',
        'correctCount': _correctCount,
        'total': widget.vocabulary.length,
        'percentage': percentage,
        'timestamp': DateTime.now().toIso8601String(),
      }),
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Writing Practice Completed! ✍️'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$percentage%',
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'You got $_correctCount out of ${widget.vocabulary.length} correct!',
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
                _currentIndex = 0;
                _correctCount = 0;
                _controller.clear();
                _showResult = false;
                _isCorrect = null;
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
    if (widget.vocabulary.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Writing Mode')),
        body: const Center(child: Text('No vocabulary items available')),
      );
    }

    final vocab = widget.vocabulary[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('✍️ Writing Mode - Practice'),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '${_currentIndex + 1}/${widget.vocabulary.length}',
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
          LinearProgressIndicator(
            value: (_currentIndex + 1) / widget.vocabulary.length,
            backgroundColor: Colors.grey.shade300,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.purple),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Score: $_correctCount/${_currentIndex + (_showResult ? 1 : 0)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Instructions
                  Card(
                    color: Colors.purple.shade50,
                    child: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline, color: Colors.purple),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Write the word in Japanese',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Question card
                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        children: [
                          const Text(
                            'Write this word:',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            vocab.meaning,
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.purple.shade100,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              vocab.romaji,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.purple,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Chip(
                            label: Text(vocab.partOfSpeech),
                            backgroundColor: Colors.grey.shade200,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Input field
                  TextField(
                    controller: _controller,
                    enabled: !_showResult,
                    style: const TextStyle(fontSize: 32),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Type here...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: _showResult
                              ? (_isCorrect! ? Colors.green : Colors.red)
                              : Colors.grey,
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.purple,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.purple,
                          width: 3,
                        ),
                      ),
                      filled: true,
                      fillColor: _showResult
                          ? (_isCorrect!
                                ? Colors.green.shade50
                                : Colors.red.shade50)
                          : Colors.white,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Result
                  if (_showResult) ...[
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _isCorrect!
                            ? Colors.green.shade100
                            : Colors.red.shade100,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _isCorrect! ? Colors.green : Colors.red,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                _isCorrect! ? Icons.check_circle : Icons.cancel,
                                color: _isCorrect! ? Colors.green : Colors.red,
                                size: 32,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _isCorrect! ? 'Correct!' : 'Incorrect',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: _isCorrect!
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                            ],
                          ),
                          if (!_isCorrect!) ...[
                            const SizedBox(height: 12),
                            const Text(
                              'Correct answer:',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              vocab.word,
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Examples
                    if (vocab.examples.isNotEmpty) ...[
                      const Divider(),
                      const SizedBox(height: 16),
                      const Text(
                        'Examples:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...vocab.examples.map(
                        (example) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Card(
                            color: Colors.grey.shade50,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                children: [
                                  Text(
                                    example.example,
                                    style: const TextStyle(fontSize: 16),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    example.translation,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ],
              ),
            ),
          ),

          // Action button
          Padding(
            padding: const EdgeInsets.all(16),
            child: _showResult
                ? ElevatedButton(
                    onPressed: _nextWord,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 48,
                        vertical: 16,
                      ),
                    ),
                    child: Text(
                      _currentIndex < widget.vocabulary.length - 1
                          ? 'Next'
                          : 'Finish',
                      style: const TextStyle(fontSize: 18),
                    ),
                  )
                : ElevatedButton(
                    onPressed: _controller.text.trim().isEmpty
                        ? null
                        : _checkAnswer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 48,
                        vertical: 16,
                      ),
                    ),
                    child: const Text('Check', style: TextStyle(fontSize: 18)),
                  ),
          ),
        ],
      ),
    );
  }
}
