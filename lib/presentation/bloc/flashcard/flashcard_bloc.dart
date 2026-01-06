import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilearn/domain/usecases/answer_flashcard.dart';
import 'package:ilearn/domain/usecases/get_flashcards_by_lesson.dart';
import 'package:ilearn/domain/usecases/start_study_session.dart';
import 'package:ilearn/presentation/bloc/flashcard/flashcard_event.dart';
import 'package:ilearn/presentation/bloc/flashcard/flashcard_state.dart';

/// BLoC quản lý state của Flashcard
class FlashcardBloc extends Bloc<FlashcardEvent, FlashcardState> {
  final GetFlashcardsByLessonUseCase getFlashcardsByLesson;
  final StartStudySessionUseCase startStudySession;
  final AnswerFlashcardUseCase answerFlashcard;

  FlashcardBloc({
    required this.getFlashcardsByLesson,
    required this.startStudySession,
    required this.answerFlashcard,
  }) : super(const FlashcardInitial()) {
    on<LoadFlashcardsEvent>(_onLoadFlashcards);
    on<StartStudyEvent>(_onStartStudy);
    on<FlipCardEvent>(_onFlipCard);
    on<AnswerCardEvent>(_onAnswerCard);
    on<NextCardEvent>(_onNextCard);
    on<ResetStudyEvent>(_onResetStudy);
  }

  Future<void> _onLoadFlashcards(
    LoadFlashcardsEvent event,
    Emitter<FlashcardState> emit,
  ) async {
    emit(const FlashcardLoading());

    final result = await getFlashcardsByLesson(event.lessonId);

    result.fold(
      (failure) => emit(FlashcardError(failure.message)),
      (flashcardSet) => emit(FlashcardLoaded(flashcardSet)),
    );
  }

  Future<void> _onStartStudy(
    StartStudyEvent event,
    Emitter<FlashcardState> emit,
  ) async {
    emit(const FlashcardLoading());

    // Start study session on backend
    await startStudySession(event.lessonId);

    // Load flashcards
    final result = await getFlashcardsByLesson(event.lessonId);

    result.fold((failure) => emit(FlashcardError(failure.message)), (
      flashcardSet,
    ) {
      if (flashcardSet.flashcards.isEmpty) {
        emit(const FlashcardError('Không có flashcard nào để học'));
        return;
      }
      emit(
        FlashcardStudying(
          flashcardSet: flashcardSet,
          currentIndex: 0,
          isFlipped: false,
          studiedCards: [],
          correctCount: 0,
          incorrectCount: 0,
        ),
      );
    });
  }

  void _onFlipCard(FlipCardEvent event, Emitter<FlashcardState> emit) {
    if (state is FlashcardStudying) {
      final currentState = state as FlashcardStudying;
      emit(currentState.copyWith(isFlipped: !currentState.isFlipped));
    }
  }

  Future<void> _onAnswerCard(
    AnswerCardEvent event,
    Emitter<FlashcardState> emit,
  ) async {
    if (state is! FlashcardStudying) return;

    final currentState = state as FlashcardStudying;

    // Submit answer to backend
    final result = await answerFlashcard(
      flashcardId: event.flashcardId,
      isRemembered: event.isRemembered,
    );

    // Update local state
    final newStudiedCards = List<dynamic>.from(currentState.studiedCards)
      ..add(currentState.currentCard);

    final newCorrectCount =
        currentState.correctCount + (event.isRemembered ? 1 : 0);
    final newIncorrectCount =
        currentState.incorrectCount + (event.isRemembered ? 0 : 1);

    // Show feedback message if available
    result.fold((_) {}, (response) {
      // Optional: You can emit a message state here if needed
      // For now, we'll just continue
    });

    // Check if this was the last card
    if (currentState.isLastCard) {
      emit(
        FlashcardCompleted(
          flashcardSet: currentState.flashcardSet,
          correctCount: newCorrectCount,
          incorrectCount: newIncorrectCount,
          totalCards: currentState.totalCards,
        ),
      );
    } else {
      // Move to next card
      emit(
        currentState.copyWith(
          currentIndex: currentState.currentIndex + 1,
          isFlipped: false,
          studiedCards: newStudiedCards.cast(),
          correctCount: newCorrectCount,
          incorrectCount: newIncorrectCount,
        ),
      );
    }
  }

  void _onNextCard(NextCardEvent event, Emitter<FlashcardState> emit) {
    if (state is FlashcardStudying) {
      final currentState = state as FlashcardStudying;

      if (!currentState.isLastCard) {
        emit(
          currentState.copyWith(
            currentIndex: currentState.currentIndex + 1,
            isFlipped: false,
          ),
        );
      }
    }
  }

  void _onResetStudy(ResetStudyEvent event, Emitter<FlashcardState> emit) {
    emit(const FlashcardInitial());
  }
}
