import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilearn/data/repositories/grammar_repository.dart';
import 'package:ilearn/presentation/bloc/grammar/grammar_event.dart';

class GrammarBloc extends Bloc<GrammarEvent, GrammarState> {
  final GrammarRepository repository;

  GrammarBloc({required this.repository}) : super(GrammarInitial()) {
    on<LoadGrammarList>(_onLoadGrammarList);
    on<LoadGrammarDetail>(_onLoadGrammarDetail);
    on<MarkGrammarAsLearned>(_onMarkGrammarAsLearned);
  }

  Future<void> _onLoadGrammarList(
    LoadGrammarList event,
    Emitter<GrammarState> emit,
  ) async {
    emit(GrammarListLoading());
    try {
      final response = await repository.getGrammarList(event.lessonId);
      emit(GrammarListLoaded(response.data));
    } catch (e) {
      emit(GrammarError(e.toString()));
    }
  }

  Future<void> _onLoadGrammarDetail(
    LoadGrammarDetail event,
    Emitter<GrammarState> emit,
  ) async {
    emit(GrammarDetailLoading());
    try {
      final response = await repository.getGrammarDetail(
        event.lessonId,
        event.grammarId,
      );
      emit(GrammarDetailLoaded(response.data));
    } catch (e) {
      emit(GrammarError(e.toString()));
    }
  }

  Future<void> _onMarkGrammarAsLearned(
    MarkGrammarAsLearned event,
    Emitter<GrammarState> emit,
  ) async {
    emit(GrammarMarkingAsLearned());
    try {
      final response = await repository.markAsLearned(
        event.lessonId,
        event.grammarId,
        'GRAMMAR',
      );
      emit(GrammarMarkedAsLearned(response.data));

      // Reload the detail to update isLearned status
      add(LoadGrammarDetail(event.lessonId, event.grammarId));
    } catch (e) {
      emit(GrammarError(e.toString()));
    }
  }
}
