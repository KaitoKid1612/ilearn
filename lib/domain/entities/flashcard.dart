import 'package:equatable/equatable.dart';

/// Entity đại diện cho một flashcard
class Flashcard extends Equatable {
  final String id;
  final String vocabularyId;
  final String front;
  final String back;
  final String? frontAudio;
  final String? image;
  final String? hint;
  final bool isLearned;
  final int level;
  final DateTime? nextReview;

  const Flashcard({
    required this.id,
    required this.vocabularyId,
    required this.front,
    required this.back,
    this.frontAudio,
    this.image,
    this.hint,
    required this.isLearned,
    required this.level,
    this.nextReview,
  });

  @override
  List<Object?> get props => [
    id,
    vocabularyId,
    front,
    back,
    frontAudio,
    image,
    hint,
    isLearned,
    level,
    nextReview,
  ];

  Flashcard copyWith({
    String? id,
    String? vocabularyId,
    String? front,
    String? back,
    String? frontAudio,
    String? image,
    String? hint,
    bool? isLearned,
    int? level,
    DateTime? nextReview,
  }) {
    return Flashcard(
      id: id ?? this.id,
      vocabularyId: vocabularyId ?? this.vocabularyId,
      front: front ?? this.front,
      back: back ?? this.back,
      frontAudio: frontAudio ?? this.frontAudio,
      image: image ?? this.image,
      hint: hint ?? this.hint,
      isLearned: isLearned ?? this.isLearned,
      level: level ?? this.level,
      nextReview: nextReview ?? this.nextReview,
    );
  }
}

/// Entity đại diện cho tiến độ học flashcard
class FlashcardProgress extends Equatable {
  final int total;
  final int newCards;
  final int learning;
  final int review;
  final int mastered;

  const FlashcardProgress({
    required this.total,
    required this.newCards,
    required this.learning,
    required this.review,
    required this.mastered,
  });

  @override
  List<Object> get props => [total, newCards, learning, review, mastered];
}

/// Entity đại diện cho một set flashcard của lesson
class FlashcardSet extends Equatable {
  final String lessonId;
  final String setId;
  final String setTitle;
  final List<Flashcard> flashcards;
  final FlashcardProgress progress;

  const FlashcardSet({
    required this.lessonId,
    required this.setId,
    required this.setTitle,
    required this.flashcards,
    required this.progress,
  });

  @override
  List<Object> get props => [lessonId, setId, setTitle, flashcards, progress];
}
