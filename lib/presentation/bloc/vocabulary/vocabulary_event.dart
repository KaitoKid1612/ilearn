import 'package:equatable/equatable.dart';
import 'package:ilearn/data/models/lesson_vocabulary_model.dart';

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

class MarkVocabularyLearned extends VocabularyEvent {
  final String lessonId;
  final String vocabularyId;

  const MarkVocabularyLearned({
    required this.lessonId,
    required this.vocabularyId,
  });

  @override
  List<Object?> get props => [lessonId, vocabularyId];
}

class BatchMarkVocabulariesLearned extends VocabularyEvent {
  final String lessonId;
  final List<String> vocabularyIds;

  const BatchMarkVocabulariesLearned({
    required this.lessonId,
    required this.vocabularyIds,
  });

  @override
  List<Object?> get props => [lessonId, vocabularyIds];
}

abstract class VocabularyState extends Equatable {
  const VocabularyState();

  @override
  List<Object?> get props => [];
}

class VocabularyInitial extends VocabularyState {}

class VocabularyLoading extends VocabularyState {}

class VocabularyLoaded extends VocabularyState {
  final LessonVocabularyDataModel lessonData;

  const VocabularyLoaded({required this.lessonData});

  @override
  List<Object?> get props => [lessonData];

  VocabularyLoaded copyWith({LessonVocabularyDataModel? lessonData}) {
    return VocabularyLoaded(lessonData: lessonData ?? this.lessonData);
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
