import 'package:equatable/equatable.dart';
import 'package:ilearn/domain/entities/vocabulary.dart';
import 'package:ilearn/domain/entities/vocabulary_progress.dart';

abstract class VocabularyEvent extends Equatable {
  const VocabularyEvent();

  @override
  List<Object?> get props => [];
}

class LoadVocabularyLesson extends VocabularyEvent {
  final String lessonId;

  const LoadVocabularyLesson(this.lessonId);

  @override
  List<Object?> get props => [lessonId];
}

class LoadVocabularyProgress extends VocabularyEvent {
  final String lessonId;

  const LoadVocabularyProgress(this.lessonId);

  @override
  List<Object?> get props => [lessonId];
}

class SubmitProgress extends VocabularyEvent {
  final String lessonId;
  final Map<String, dynamic> progressData;

  const SubmitProgress(this.lessonId, this.progressData);

  @override
  List<Object?> get props => [lessonId, progressData];
}

abstract class VocabularyState extends Equatable {
  const VocabularyState();

  @override
  List<Object?> get props => [];
}

class VocabularyInitial extends VocabularyState {}

class VocabularyLoading extends VocabularyState {}

class VocabularyLoaded extends VocabularyState {
  final VocabularyLessonData lessonData;
  final VocabularyProgress? progress;

  const VocabularyLoaded({required this.lessonData, this.progress});

  @override
  List<Object?> get props => [lessonData, progress];

  VocabularyLoaded copyWith({
    VocabularyLessonData? lessonData,
    VocabularyProgress? progress,
  }) {
    return VocabularyLoaded(
      lessonData: lessonData ?? this.lessonData,
      progress: progress ?? this.progress,
    );
  }
}

class VocabularyError extends VocabularyState {
  final String message;

  const VocabularyError(this.message);

  @override
  List<Object?> get props => [message];
}

class ProgressSubmitting extends VocabularyState {}

class ProgressSubmitted extends VocabularyState {}

class ProgressSubmitError extends VocabularyState {
  final String message;

  const ProgressSubmitError(this.message);

  @override
  List<Object?> get props => [message];
}
