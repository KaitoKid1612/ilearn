import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilearn/domain/usecases/get_lesson_kanji.dart';
import 'package:ilearn/data/repositories/kanji_repository_impl.dart';
import 'package:ilearn/presentation/bloc/kanji/kanji_event.dart';
import 'package:ilearn/presentation/bloc/kanji/kanji_state.dart';

export 'kanji_event.dart';
export 'kanji_state.dart';

class KanjiBloc extends Bloc<KanjiEvent, KanjiState> {
  final GetLessonKanji getLessonKanji;
  final KanjiRepository repository;

  KanjiBloc({required this.getLessonKanji, required this.repository})
    : super(KanjiInitial()) {
    on<LoadLessonKanji>(_onLoadLessonKanji);
    on<MarkKanjiLearned>(_onMarkKanjiLearned);
    on<BatchMarkKanjiLearned>(_onBatchMarkKanjiLearned);
  }

  Future<void> _onLoadLessonKanji(
    LoadLessonKanji event,
    Emitter<KanjiState> emit,
  ) async {
    emit(KanjiLoading());

    final result = await getLessonKanji(event.lessonId);

    result.fold(
      (failure) => emit(KanjiError(failure.message)),
      (kanjiData) => emit(KanjiLoaded(kanjiData: kanjiData)),
    );
  }

  Future<void> _onMarkKanjiLearned(
    MarkKanjiLearned event,
    Emitter<KanjiState> emit,
  ) async {
    try {
      final result = await repository.markKanjiLearned(
        lessonId: event.lessonId,
        kanjiId: event.kanjiId,
      );

      result.fold(
        (failure) {
          // Show error but don't change state
          print('Failed to mark kanji as learned: ${failure.message}');
        },
        (_) {
          // Success - reload data to get updated status
          add(LoadLessonKanji(event.lessonId));
        },
      );
    } catch (e) {
      print('Error marking kanji as learned: $e');
    }
  }

  Future<void> _onBatchMarkKanjiLearned(
    BatchMarkKanjiLearned event,
    Emitter<KanjiState> emit,
  ) async {
    // TODO: Implement batch mark kanji as learned
    // For now, just reload the data
    add(LoadLessonKanji(event.lessonId));
  }
}
