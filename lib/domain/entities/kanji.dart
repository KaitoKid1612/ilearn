import 'package:equatable/equatable.dart';

class Kanji extends Equatable {
  final String id;
  final String character;
  final String meaning;
  final String onyomi;
  final String kunyomi;
  final int strokeCount;
  final String? strokeOrderVideo;
  final String mnemonic;
  final List<String> examples;
  final String? image;
  final bool isLearned;
  final int writingLevel;
  final int readingLevel;

  const Kanji({
    required this.id,
    required this.character,
    required this.meaning,
    this.onyomi = '',
    this.kunyomi = '',
    required this.strokeCount,
    this.strokeOrderVideo,
    this.mnemonic = '',
    this.examples = const [],
    this.image,
    required this.isLearned,
    required this.writingLevel,
    required this.readingLevel,
  });

  @override
  List<Object?> get props => [
    id,
    character,
    meaning,
    onyomi,
    kunyomi,
    strokeCount,
    strokeOrderVideo,
    mnemonic,
    examples,
    image,
    isLearned,
    writingLevel,
    readingLevel,
  ];
}

class KanjiProgress extends Equatable {
  final int total;
  final int learned;
  final int percentage;

  const KanjiProgress({
    required this.total,
    required this.learned,
    required this.percentage,
  });

  @override
  List<Object?> get props => [total, learned, percentage];
}

class KanjiLessonData extends Equatable {
  final String lessonId;
  final List<Kanji> kanjis;
  final KanjiProgress progress;

  const KanjiLessonData({
    required this.lessonId,
    required this.kanjis,
    required this.progress,
  });

  @override
  List<Object?> get props => [lessonId, kanjis, progress];
}
