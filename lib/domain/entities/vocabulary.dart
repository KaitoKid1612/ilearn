import 'package:equatable/equatable.dart';

class Vocabulary extends Equatable {
  final String id;
  final String word;
  final String? hiragana;
  final String? katakana;
  final String romaji;
  final String meaning;
  final String level;
  final String partOfSpeech;
  final bool isPublished;
  final List<VocabularyExample> examples;

  const Vocabulary({
    required this.id,
    required this.word,
    this.hiragana,
    this.katakana,
    required this.romaji,
    required this.meaning,
    required this.level,
    required this.partOfSpeech,
    required this.isPublished,
    required this.examples,
  });

  @override
  List<Object?> get props => [
    id,
    word,
    hiragana,
    katakana,
    romaji,
    meaning,
    level,
    partOfSpeech,
    isPublished,
    examples,
  ];
}

class VocabularyExample extends Equatable {
  final String id;
  final String example;
  final String translation;
  final int order;

  const VocabularyExample({
    required this.id,
    required this.example,
    required this.translation,
    required this.order,
  });

  @override
  List<Object?> get props => [id, example, translation, order];
}

class VocabularyLesson extends Equatable {
  final String id;
  final String title;
  final String type;

  const VocabularyLesson({
    required this.id,
    required this.title,
    required this.type,
  });

  @override
  List<Object?> get props => [id, title, type];
}

class VocabularyLessonData extends Equatable {
  final VocabularyLesson lesson;
  final List<Vocabulary> vocabulary;

  const VocabularyLessonData({required this.lesson, required this.vocabulary});

  @override
  List<Object?> get props => [lesson, vocabulary];
}
