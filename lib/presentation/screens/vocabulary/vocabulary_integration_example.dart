import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Example integration: Adding vocabulary button to a lesson card in roadmap
///
/// This shows how to integrate the vocabulary learning feature into your existing roadmap/lesson screens

class LessonCardWithVocabulary extends StatelessWidget {
  final String lessonId;
  final String lessonTitle;
  final String lessonType; // 'VOCABULARY', 'GRAMMAR', 'KANJI', etc.
  final int? vocabularyCount;
  final int? progress; // 0-100

  const LessonCardWithVocabulary({
    Key? key,
    required this.lessonId,
    required this.lessonTitle,
    required this.lessonType,
    this.vocabularyCount,
    this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () => _navigateToLesson(context),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Lesson type icon
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _getLessonTypeColor().withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getLessonTypeIcon(),
                      color: _getLessonTypeColor(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lessonTitle,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Chip(
                              label: Text(
                                lessonType,
                                style: const TextStyle(fontSize: 11),
                              ),
                              backgroundColor: _getLessonTypeColor()
                                  .withOpacity(0.2),
                              padding: EdgeInsets.zero,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                            if (vocabularyCount != null) ...[
                              const SizedBox(width: 8),
                              Text(
                                '$vocabularyCount words',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
              if (progress != null) ...[
                const SizedBox(height: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Progress',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        Text(
                          '$progress%',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    LinearProgressIndicator(
                      value: progress! / 100,
                      backgroundColor: Colors.grey.shade300,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        _getLessonTypeColor(),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToLesson(BuildContext context) {
    if (lessonType == 'VOCABULARY') {
      // Navigate to vocabulary learning screen
      context.pushNamed(
        'vocabulary',
        pathParameters: {'lessonId': lessonId},
        queryParameters: {'title': lessonTitle},
      );
    } else if (lessonType == 'GRAMMAR') {
      // Navigate to grammar lesson
      context.pushNamed(
        'lesson',
        pathParameters: {'lessonId': lessonId},
        queryParameters: {'type': 'grammar'},
      );
    } else if (lessonType == 'KANJI') {
      // Navigate to kanji lesson
      context.pushNamed(
        'lesson',
        pathParameters: {'lessonId': lessonId},
        queryParameters: {'type': 'kanji'},
      );
    } else {
      // Default lesson navigation
      context.pushNamed('lesson', pathParameters: {'lessonId': lessonId});
    }
  }

  IconData _getLessonTypeIcon() {
    switch (lessonType) {
      case 'VOCABULARY':
        return Icons.menu_book;
      case 'GRAMMAR':
        return Icons.text_fields;
      case 'KANJI':
        return Icons.language;
      case 'READING':
        return Icons.library_books;
      case 'LISTENING':
        return Icons.headphones;
      default:
        return Icons.school;
    }
  }

  Color _getLessonTypeColor() {
    switch (lessonType) {
      case 'VOCABULARY':
        return Colors.blue;
      case 'GRAMMAR':
        return Colors.green;
      case 'KANJI':
        return Colors.red;
      case 'READING':
        return Colors.purple;
      case 'LISTENING':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}

/// Example: Roadmap screen showing how to use the lesson card
class RoadmapScreenExample extends StatelessWidget {
  final String textbookId;

  const RoadmapScreenExample({Key? key, required this.textbookId})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mock data - replace with your actual data from BLoC/API
    final lessons = [
      {
        'id': 'lesson-1',
        'title': 'Basic Greetings - Chào hỏi cơ bản',
        'type': 'VOCABULARY',
        'vocabularyCount': 20,
        'progress': 75,
      },
      {
        'id': 'lesson-2',
        'title': 'Particles は and が',
        'type': 'GRAMMAR',
        'progress': 50,
      },
      {
        'id': 'lesson-3',
        'title': 'Numbers 1-100',
        'type': 'VOCABULARY',
        'vocabularyCount': 100,
        'progress': 30,
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Minna no Nihongo 1')),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemCount: lessons.length,
        itemBuilder: (context, index) {
          final lesson = lessons[index];
          return LessonCardWithVocabulary(
            lessonId: lesson['id'] as String,
            lessonTitle: lesson['title'] as String,
            lessonType: lesson['type'] as String,
            vocabularyCount: lesson['vocabularyCount'] as int?,
            progress: lesson['progress'] as int?,
          );
        },
      ),
    );
  }
}

/// Direct navigation examples
class NavigationExamples {
  /// Example 1: Navigate from a button
  static void navigateToVocabularyFromButton(
    BuildContext context,
    String lessonId,
  ) {
    context.pushNamed(
      'vocabulary',
      pathParameters: {'lessonId': lessonId},
      queryParameters: {'title': 'Vocabulary Lesson'},
    );
  }

  /// Example 2: Navigate with lesson data
  static void navigateWithLessonData(
    BuildContext context,
    String lessonId,
    String lessonTitle,
  ) {
    context.pushNamed(
      'vocabulary',
      pathParameters: {'lessonId': lessonId},
      queryParameters: {'title': lessonTitle},
    );
  }

  /// Example 3: Check lesson type before navigating
  static void smartNavigate(
    BuildContext context,
    String lessonId,
    String lessonTitle,
    String lessonType,
  ) {
    if (lessonType == 'VOCABULARY') {
      context.pushNamed(
        'vocabulary',
        pathParameters: {'lessonId': lessonId},
        queryParameters: {'title': lessonTitle},
      );
    } else {
      // Navigate to other lesson types
      context.pushNamed('lesson', pathParameters: {'lessonId': lessonId});
    }
  }

  /// Example 4: Navigate using Navigator (without GoRouter)
  static void navigateWithNavigator(
    BuildContext context,
    String lessonId,
    String lessonTitle,
  ) {
    Navigator.pushNamed(
      context,
      '/vocabulary/$lessonId',
      arguments: {'title': lessonTitle},
    );
  }
}
