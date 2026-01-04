import 'package:ilearn/domain/entities/flashcard.dart';

/// Model cho Flashcard từ API
class FlashcardModel extends Flashcard {
  const FlashcardModel({
    required super.id,
    required super.vocabularyId,
    required super.front,
    required super.back,
    super.frontAudio,
    super.image,
    super.hint,
    required super.isLearned,
    required super.level,
    super.nextReview,
  });

  factory FlashcardModel.fromJson(Map<String, dynamic> json) {
    return FlashcardModel(
      id: (json['id'] ?? json['_id'] ?? json['flashcardId'] ?? '') as String,
      vocabularyId:
          (json['vocabularyId'] ??
                  json['vocabulary_id'] ??
                  json['vocabId'] ??
                  '')
              as String,
      front: (json['front'] ?? json['question'] ?? '') as String,
      back: (json['back'] ?? json['answer'] ?? '') as String,
      frontAudio:
          json['frontAudio'] as String? ?? json['front_audio'] as String?,
      image: json['image'] as String?,
      hint: json['hint'] as String?,
      isLearned:
          json['isLearned'] as bool? ?? json['is_learned'] as bool? ?? false,
      level: (json['level'] as num?)?.toInt() ?? 0,
      nextReview: json['nextReview'] != null
          ? DateTime.parse(json['nextReview'] as String)
          : (json['next_review'] != null
                ? DateTime.parse(json['next_review'] as String)
                : null),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vocabularyId': vocabularyId,
      'front': front,
      'back': back,
      'frontAudio': frontAudio,
      'image': image,
      'hint': hint,
      'isLearned': isLearned,
      'level': level,
      'nextReview': nextReview?.toIso8601String(),
    };
  }
}

/// Model cho FlashcardProgress từ API
class FlashcardProgressModel extends FlashcardProgress {
  const FlashcardProgressModel({
    required super.total,
    required super.newCards,
    required super.learning,
    required super.review,
    required super.mastered,
  });

  factory FlashcardProgressModel.fromJson(Map<String, dynamic> json) {
    return FlashcardProgressModel(
      total: json['total'] as int? ?? 0,
      newCards: json['new'] as int? ?? 0,
      learning: json['learning'] as int? ?? 0,
      review: json['review'] as int? ?? 0,
      mastered: json['mastered'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'new': newCards,
      'learning': learning,
      'review': review,
      'mastered': mastered,
    };
  }
}

/// Model cho FlashcardSet từ API
class FlashcardSetModel extends FlashcardSet {
  const FlashcardSetModel({
    required super.lessonId,
    required super.setId,
    required super.setTitle,
    required super.flashcards,
    required super.progress,
  });

  factory FlashcardSetModel.fromJson(Map<String, dynamic> json) {
    // Handle nested data structure (e.g., {success: true, data: {...}})
    final data = json['data'] as Map<String, dynamic>? ?? json;

    return FlashcardSetModel(
      lessonId: (data['lessonId'] ?? data['lesson_id'] ?? '') as String,
      setId: (data['setId'] ?? data['set_id'] ?? data['id'] ?? '') as String,
      setTitle:
          (data['setTitle'] ??
                  data['set_title'] ??
                  data['title'] ??
                  'Flashcards')
              as String,
      flashcards:
          (data['flashcards'] as List<dynamic>?)
              ?.map(
                (card) => FlashcardModel.fromJson(card as Map<String, dynamic>),
              )
              .toList() ??
          [],
      progress: FlashcardProgressModel.fromJson(
        data['progress'] as Map<String, dynamic>? ?? {},
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lessonId': lessonId,
      'setId': setId,
      'setTitle': setTitle,
      'flashcards': flashcards
          .map((card) => (card as FlashcardModel).toJson())
          .toList(),
      'progress': (progress as FlashcardProgressModel).toJson(),
    };
  }
}

/// Model cho response khi trả lời flashcard
class FlashcardAnswerResponse {
  final bool success;
  final String message;
  final bool isRemembered;
  final DateTime? nextReview;
  final int pointsEarned;

  const FlashcardAnswerResponse({
    required this.success,
    required this.message,
    required this.isRemembered,
    this.nextReview,
    required this.pointsEarned,
  });

  factory FlashcardAnswerResponse.fromJson(Map<String, dynamic> json) {
    return FlashcardAnswerResponse(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      isRemembered: json['isRemembered'] as bool? ?? false,
      nextReview: json['nextReview'] != null
          ? DateTime.parse(json['nextReview'] as String)
          : null,
      pointsEarned: json['pointsEarned'] as int? ?? 0,
    );
  }
}
