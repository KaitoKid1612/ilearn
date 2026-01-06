import 'package:equatable/equatable.dart';
import 'package:ilearn/domain/entities/kanji.dart';

abstract class KanjiState extends Equatable {
  const KanjiState();

  @override
  List<Object?> get props => [];
}

class KanjiInitial extends KanjiState {}

class KanjiLoading extends KanjiState {}

class KanjiLoaded extends KanjiState {
  final KanjiLessonData kanjiData;

  const KanjiLoaded({required this.kanjiData});

  @override
  List<Object?> get props => [kanjiData];
}

class KanjiError extends KanjiState {
  final String message;

  const KanjiError(this.message);

  @override
  List<Object?> get props => [message];
}
