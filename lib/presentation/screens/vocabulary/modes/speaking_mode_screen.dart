import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilearn/data/models/lesson_vocabulary_model.dart';
import 'package:ilearn/domain/entities/vocabulary_progress.dart';
import 'package:ilearn/presentation/bloc/vocabulary/vocabulary_bloc.dart';

class SpeakingModeScreen extends StatefulWidget {
  final String lessonId;
  final List<VocabularyItemModel> vocabulary;
  final VocabularyProgress? progress;

  const SpeakingModeScreen({
    Key? key,
    required this.lessonId,
    required this.vocabulary,
    this.progress,
  }) : super(key: key);

  @override
  State<SpeakingModeScreen> createState() => _SpeakingModeScreenState();
}

class _SpeakingModeScreenState extends State<SpeakingModeScreen> {
  int _currentIndex = 0;
  bool _isRecording = false;
  bool _hasRecorded = false;
  int _completedCount = 0;

  void _startRecording() {
    setState(() {
      _isRecording = true;
    });

    // Simulate recording - In real app, integrate with speech recognition API
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isRecording = false;
          _hasRecorded = true;
        });
      }
    });
  }

  void _nextWord() {
    if (_hasRecorded) {
      _completedCount++;
    }

    if (_currentIndex < widget.vocabulary.length - 1) {
      setState(() {
        _currentIndex++;
        _hasRecorded = false;
      });
    } else {
      _completeSpeakingMode();
    }
  }

  void _previousWord() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _hasRecorded = false;
      });
    }
  }

  void _completeSpeakingMode() {
    context.read<VocabularyBloc>().add(
      SubmitProgress(widget.lessonId, {
        'mode': 'SPEAKING',
        'completed': _completedCount,
        'total': widget.vocabulary.length,
        'timestamp': DateTime.now().toIso8601String(),
      }),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Great job on your pronunciation practice!'),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.vocabulary.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Speaking Mode')),
        body: const Center(child: Text('No vocabulary items available')),
      );
    }

    final vocab = widget.vocabulary[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('🎤 Speaking Mode - Pronunciation'),
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
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Instructions
                  Card(
                    color: Colors.orange.shade50,
                    child: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline, color: Colors.orange),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Tap the microphone and pronounce the word',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Word card
                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        children: [
                          Text(
                            vocab.word,
                            style: const TextStyle(
                              fontSize: 56,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            vocab.reading,
                            style: const TextStyle(
                              fontSize: 28,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade100,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              vocab.reading,
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            vocab.meaning,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 48),

                  // Recording button
                  GestureDetector(
                    onTap: _isRecording ? null : _startRecording,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _isRecording
                            ? Colors.red
                            : _hasRecorded
                            ? Colors.green
                            : Colors.orange,
                        boxShadow: [
                          BoxShadow(
                            color:
                                (_isRecording
                                        ? Colors.red
                                        : _hasRecorded
                                        ? Colors.green
                                        : Colors.orange)
                                    .withOpacity(0.4),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Icon(
                        _isRecording
                            ? Icons.mic
                            : _hasRecorded
                            ? Icons.check
                            : Icons.mic_none,
                        size: 64,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    _isRecording
                        ? 'Recording...'
                        : _hasRecorded
                        ? 'Good job! 👍'
                        : 'Tap to record',
                    style: TextStyle(
                      fontSize: 18,
                      color: _isRecording
                          ? Colors.red
                          : _hasRecorded
                          ? Colors.green
                          : Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Example sentences
                  if (vocab.example != null && vocab.example!.isNotEmpty) ...[
                    const Divider(),
                    const SizedBox(height: 16),
                    const Text(
                      'Example Usage:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Card(
                        color: Colors.grey.shade50,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              Text(
                                vocab.example!,
                                style: const TextStyle(fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                              if (vocab.exampleMeaning != null) ...[
                                const SizedBox(height: 4),
                                Text(
                                  vocab.exampleMeaning!,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),

          // Navigation
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _currentIndex > 0 ? _previousWord : null,
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Previous'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                ),
                ElevatedButton(
                  onPressed: _nextWord,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                  ),
                  child: Text(
                    _currentIndex < widget.vocabulary.length - 1
                        ? 'Next'
                        : 'Complete',
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
