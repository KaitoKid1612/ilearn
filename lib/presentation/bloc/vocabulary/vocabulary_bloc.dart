import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilearn/domain/usecases/get_lesson_vocabulary.dart';
import 'package:ilearn/domain/usecases/get_vocabulary_progress.dart';
import 'package:ilearn/domain/usecases/submit_vocabulary_progress.dart';
import 'package:ilearn/presentation/bloc/vocabulary/vocabulary_event.dart';

export 'vocabulary_event.dart';

class VocabularyBloc extends Bloc<VocabularyEvent, VocabularyState> {
  final GetLessonVocabulary getLessonVocabulary;
  final GetVocabularyProgress getVocabularyProgress;
  final SubmitVocabularyProgress submitVocabularyProgress;

  VocabularyBloc({
    required this.getLessonVocabulary,
    required this.getVocabularyProgress,
    required this.submitVocabularyProgress,
  }) : super(VocabularyInitial()) {
    on<LoadVocabularyLesson>(_onLoadVocabularyLesson);
    on<LoadVocabularyProgress>(_onLoadVocabularyProgress);
    on<SubmitProgress>(_onSubmitProgress);
  }

  Future<void> _onLoadVocabularyLesson(
    LoadVocabularyLesson event,
    Emitter<VocabularyState> emit,
  ) async {
    emit(VocabularyLoading());

    final vocabularyResult = await getLessonVocabulary(event.lessonId);

    await vocabularyResult.fold(
      (failure) async {
        emit(VocabularyError(failure.message));
      },
      (lessonData) async {
        // Try to load progress
        final progressResult = await getVocabularyProgress(event.lessonId);

        progressResult.fold(
          (failure) {
            // Progress loading failed, but we still have vocabulary data
            emit(VocabularyLoaded(lessonData: lessonData, progress: null));
          },
          (progress) {
            emit(VocabularyLoaded(lessonData: lessonData, progress: progress));
          },
        );
      },
    );
  }

  Future<void> _onLoadVocabularyProgress(
    LoadVocabularyProgress event,
    Emitter<VocabularyState> emit,
  ) async {
    if (state is VocabularyLoaded) {
      final currentState = state as VocabularyLoaded;

      final progressResult = await getVocabularyProgress(event.lessonId);

      progressResult.fold(
        (failure) {
          // Keep current state if progress loading fails
        },
        (progress) {
          emit(currentState.copyWith(progress: progress));
        },
      );
    }
  }

  Future<void> _onSubmitProgress(
    SubmitProgress event,
    Emitter<VocabularyState> emit,
  ) async {
    final currentState = state;
    emit(ProgressSubmitting());

    final result = await submitVocabularyProgress(
      event.lessonId,
      event.progressData,
    );

    result.fold(
      (failure) {
        emit(ProgressSubmitError(failure.message));
        // Restore previous state after a delay
        Future.delayed(const Duration(seconds: 2), () {
          if (currentState is VocabularyLoaded) {
            emit(currentState);
          }
        });
      },
      (_) {
        emit(ProgressSubmitted());
        // Reload progress after successful submission
        add(LoadVocabularyProgress(event.lessonId));
      },
    );
  }
}
