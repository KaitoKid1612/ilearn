import 'package:equatable/equatable.dart';
import 'package:ilearn/domain/entities/flashcard.dart';

/// Base state cho Flashcard
abstract class FlashcardState extends Equatable {
  const FlashcardState();

  @override
  List<Object?> get props => [];
}

/// State khởi tạo
class FlashcardInitial extends FlashcardState {
  const FlashcardInitial();
}

/// State đang load
class FlashcardLoading extends FlashcardState {
  const FlashcardLoading();
}

/// State load flashcard set thành công
class FlashcardLoaded extends FlashcardState {
  final FlashcardSet flashcardSet;

  const FlashcardLoaded(this.flashcardSet);

  @override
  List<Object> get props => [flashcardSet];
}

/// State đang trong quá trình học
class FlashcardStudying extends FlashcardState {
  final FlashcardSet flashcardSet;
  final int currentIndex;
  final bool isFlipped;
  final List<Flashcard> studiedCards;
  final int correctCount;
  final int incorrectCount;

  const FlashcardStudying({
    required this.flashcardSet,
    required this.currentIndex,
    required this.isFlipped,
    required this.studiedCards,
    required this.correctCount,
    required this.incorrectCount,
  });

  Flashcard get currentCard => flashcardSet.flashcards[currentIndex];

  bool get isLastCard => currentIndex >= flashcardSet.flashcards.length - 1;

  int get totalCards => flashcardSet.flashcards.length;

  double get progress => (currentIndex + 1) / totalCards;

  @override
  List<Object> get props => [
    flashcardSet,
    currentIndex,
    isFlipped,
    studiedCards,
    correctCount,
    incorrectCount,
  ];

  FlashcardStudying copyWith({
    FlashcardSet? flashcardSet,
    int? currentIndex,
    bool? isFlipped,
    List<Flashcard>? studiedCards,
    int? correctCount,
    int? incorrectCount,
  }) {
    return FlashcardStudying(
      flashcardSet: flashcardSet ?? this.flashcardSet,
      currentIndex: currentIndex ?? this.currentIndex,
      isFlipped: isFlipped ?? this.isFlipped,
      studiedCards: studiedCards ?? this.studiedCards,
      correctCount: correctCount ?? this.correctCount,
      incorrectCount: incorrectCount ?? this.incorrectCount,
    );
  }
}

/// State hoàn thành học
class FlashcardCompleted extends FlashcardState {
  final FlashcardSet flashcardSet;
  final int correctCount;
  final int incorrectCount;
  final int totalCards;

  const FlashcardCompleted({
    required this.flashcardSet,
    required this.correctCount,
    required this.incorrectCount,
    required this.totalCards,
  });

  double get accuracy => totalCards > 0 ? correctCount / totalCards : 0.0;

  @override
  List<Object> get props => [
    flashcardSet,
    correctCount,
    incorrectCount,
    totalCards,
  ];
}

/// State lỗi
class FlashcardError extends FlashcardState {
  final String message;

  const FlashcardError(this.message);

  @override
  List<Object> get props => [message];
}
