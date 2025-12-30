import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilearn/domain/entities/vocabulary.dart';
import 'package:ilearn/domain/entities/vocabulary_progress.dart';
import 'package:ilearn/presentation/bloc/vocabulary/vocabulary_bloc.dart';

class LearnModeScreen extends StatefulWidget {
  final String lessonId;
  final List<Vocabulary> vocabulary;
  final VocabularyProgress? progress;

  const LearnModeScreen({
    Key? key,
    required this.lessonId,
    required this.vocabulary,
    this.progress,
  }) : super(key: key);

  @override
  State<LearnModeScreen> createState() => _LearnModeScreenState();
}

class _LearnModeScreenState extends State<LearnModeScreen> {
  int _currentIndex = 0;
  bool _showMeaning = false;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextCard() {
    if (_currentIndex < widget.vocabulary.length - 1) {
      setState(() {
        _currentIndex++;
        _showMeaning = false;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeLearnMode();
    }
  }

  void _previousCard() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _showMeaning = false;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _completeLearnMode() {
    // Submit progress
    context.read<VocabularyBloc>().add(
      SubmitProgress(widget.lessonId, {
        'mode': 'LEARN',
        'completed': widget.vocabulary.length,
        'timestamp': DateTime.now().toIso8601String(),
      }),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Great job! You completed all flashcards!'),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.vocabulary.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Learn Mode')),
        body: const Center(child: Text('No vocabulary items available')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('📚 Learn Mode - Flashcards'),
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
          // Progress bar
          LinearProgressIndicator(
            value: (_currentIndex + 1) / widget.vocabulary.length,
            backgroundColor: Colors.grey.shade300,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          const SizedBox(height: 20),

          // Flashcard
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.vocabulary.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                  _showMeaning = false;
                });
              },
              itemBuilder: (context, index) {
                return _buildFlashcard(widget.vocabulary[index]);
              },
            ),
          ),

          // Navigation buttons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _currentIndex > 0 ? _previousCard : null,
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Previous'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                ),
                ElevatedButton(
                  onPressed: _nextCard,
                  child: Text(
                    _currentIndex < widget.vocabulary.length - 1
                        ? 'Next'
                        : 'Complete',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFlashcard(Vocabulary vocab) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: GestureDetector(
          onTap: () {
            setState(() {
              _showMeaning = !_showMeaning;
            });
          },
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _showMeaning
                ? _buildMeaningSide(vocab)
                : _buildWordSide(vocab),
          ),
        ),
      ),
    );
  }

  Widget _buildWordSide(Vocabulary vocab) {
    return Card(
      key: const ValueKey('word'),
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              vocab.word,
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            if (vocab.hiragana != null)
              Text(
                vocab.hiragana!,
                style: const TextStyle(fontSize: 24, color: Colors.grey),
              ),
            const SizedBox(height: 8),
            Text(
              vocab.romaji,
              style: const TextStyle(fontSize: 20, color: Colors.blue),
            ),
            const SizedBox(height: 32),
            const Icon(Icons.touch_app, size: 32, color: Colors.grey),
            const Text(
              'Tap to reveal meaning',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMeaningSide(Vocabulary vocab) {
    return Card(
      key: const ValueKey('meaning'),
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.blue.shade50,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(32),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.lightbulb, size: 48, color: Colors.orange),
              const SizedBox(height: 16),
              Text(
                vocab.meaning,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Chip(
                label: Text(vocab.partOfSpeech),
                backgroundColor: Colors.blue.shade100,
              ),
              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 16),
              const Text(
                'Examples:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ...vocab.examples.map(
                (example) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
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
            ],
          ),
        ),
      ),
    );
  }
}
