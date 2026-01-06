import 'package:equatable/equatable.dart';

abstract class KanjiEvent extends Equatable {
  const KanjiEvent();

  @override
  List<Object?> get props => [];
}

class LoadLessonKanji extends KanjiEvent {
  final String lessonId;

  const LoadLessonKanji(this.lessonId);

  @override
  List<Object?> get props => [lessonId];
}

class MarkKanjiLearned extends KanjiEvent {
  final String lessonId;
  final String kanjiId;

  const MarkKanjiLearned({required this.lessonId, required this.kanjiId});

  @override
  List<Object?> get props => [lessonId, kanjiId];
}

class BatchMarkKanjiLearned extends KanjiEvent {
  final String lessonId;
  final List<String> kanjiIds;

  const BatchMarkKanjiLearned({required this.lessonId, required this.kanjiIds});

  @override
  List<Object?> get props => [lessonId, kanjiIds];
}
