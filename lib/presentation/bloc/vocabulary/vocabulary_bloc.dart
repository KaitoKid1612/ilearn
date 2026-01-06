import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilearn/data/datasources/remote/learning_remote_datasource.dart';
import 'package:ilearn/data/repositories/vocabulary_repository_impl.dart';
import 'package:ilearn/presentation/bloc/vocabulary/vocabulary_event.dart';

export 'vocabulary_event.dart';

class VocabularyBloc extends Bloc<VocabularyEvent, VocabularyState> {
  final LearningRemoteDataSource dataSource;
  final VocabularyRepository? repository;

  VocabularyBloc({required this.dataSource, this.repository})
    : super(VocabularyInitial()) {
    on<LoadVocabularyLesson>(_onLoadVocabularyLesson);
    on<LoadVocabularyProgress>(_onLoadVocabularyProgress);
    on<SubmitProgress>(_onSubmitProgress);
    on<MarkVocabularyLearned>(_onMarkVocabularyLearned);
    on<BatchMarkVocabulariesLearned>(_onBatchMarkVocabulariesLearned);
  }

  Future<void> _onLoadVocabularyLesson(
    LoadVocabularyLesson event,
    Emitter<VocabularyState> emit,
  ) async {
    emit(VocabularyLoading());

    try {
      final lessonData = await dataSource.getLessonVocabulary(event.lessonId);
      emit(VocabularyLoaded(lessonData: lessonData));
    } catch (e) {
      emit(VocabularyError(e.toString()));
    }
  }

  Future<void> _onLoadVocabularyProgress(
    LoadVocabularyProgress event,
    Emitter<VocabularyState> emit,
  ) async {
    // TODO: Implement progress tracking
  }

  Future<void> _onSubmitProgress(
    SubmitProgress event,
    Emitter<VocabularyState> emit,
  ) async {
    // TODO: Implement progress submission
  }

  Future<void> _onMarkVocabularyLearned(
    MarkVocabularyLearned event,
    Emitter<VocabularyState> emit,
  ) async {
    if (repository == null) return;

    try {
      final result = await repository!.markItemLearned(
        lessonId: event.lessonId,
        itemId: event.vocabularyId,
        itemType: 'VOCABULARY',
      );

      result.fold(
        (failure) {
          // Failure - show error but don't change state dramatically
          print('Failed to mark vocabulary as learned: ${failure.message}');
        },
        (_) {
          // Success - reload lesson to get updated status
          add(LoadVocabularyLesson(event.lessonId));
        },
      );
    } catch (e) {
      print('Error marking vocabulary as learned: $e');
    }
  }

  Future<void> _onBatchMarkVocabulariesLearned(
    BatchMarkVocabulariesLearned event,
    Emitter<VocabularyState> emit,
  ) async {
    if (repository == null) return;

    try {
      final result = await repository!.batchMarkLearned(
        lessonId: event.lessonId,
        itemType: 'vocabulary',
        itemIds: event.vocabularyIds,
      );

      result.fold(
        (failure) {
          print('Failed to batch mark vocabularies: ${failure.message}');
        },
        (_) {
          // Success - reload lesson
          add(LoadVocabularyLesson(event.lessonId));
        },
      );
    } catch (e) {
      print('Error batch marking vocabularies: $e');
    }
  }
}
