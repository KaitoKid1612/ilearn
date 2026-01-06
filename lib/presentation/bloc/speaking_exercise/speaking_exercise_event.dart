import 'dart:io';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/speaking_exercise.dart';

// Events
abstract class SpeakingExerciseEvent extends Equatable {
  const SpeakingExerciseEvent();

  @override
  List<Object?> get props => [];
}

class LoadSpeakingExercise extends SpeakingExerciseEvent {
  final String lessonId;

  const LoadSpeakingExercise(this.lessonId);

  @override
  List<Object?> get props => [lessonId];
}

class RecordAudio extends SpeakingExerciseEvent {
  final String questionId;

  const RecordAudio(this.questionId);

  @override
  List<Object?> get props => [questionId];
}

class StopRecording extends SpeakingExerciseEvent {
  final String questionId;

  const StopRecording(this.questionId);

  @override
  List<Object?> get props => [questionId];
}

class TranscribeRecording extends SpeakingExerciseEvent {
  final String questionId;
  final File audioFile;

  const TranscribeRecording(this.questionId, this.audioFile);

  @override
  List<Object?> get props => [questionId, audioFile];
}

class UpdateQuestionTranscription extends SpeakingExerciseEvent {
  final String questionId;
  final String transcription;
  final double confidence;

  const UpdateQuestionTranscription(
    this.questionId,
    this.transcription,
    this.confidence,
  );

  @override
  List<Object?> get props => [questionId, transcription, confidence];
}

class SubmitSpeakingExerciseEvent extends SpeakingExerciseEvent {
  const SubmitSpeakingExerciseEvent();
}

class PlayQuestionAudio extends SpeakingExerciseEvent {
  final String audioUrl;

  const PlayQuestionAudio(this.audioUrl);

  @override
  List<Object?> get props => [audioUrl];
}

class ResetSpeakingExercise extends SpeakingExerciseEvent {
  const ResetSpeakingExercise();
}

// States
abstract class SpeakingExerciseState extends Equatable {
  const SpeakingExerciseState();

  @override
  List<Object?> get props => [];
}

class SpeakingExerciseInitial extends SpeakingExerciseState {}

class SpeakingExerciseLoading extends SpeakingExerciseState {}

class SpeakingExerciseLoaded extends SpeakingExerciseState {
  final SpeakingExercise exercise;
  final int currentQuestionIndex;
  final Map<String, String>
  recordingStates; // questionId -> 'idle'|'recording'|'processing'
  final bool isPlayingAudio;

  const SpeakingExerciseLoaded({
    required this.exercise,
    this.currentQuestionIndex = 0,
    this.recordingStates = const {},
    this.isPlayingAudio = false,
  });

  SpeakingQuestion get currentQuestion =>
      exercise.questions[currentQuestionIndex];

  bool get isLastQuestion =>
      currentQuestionIndex >= exercise.questions.length - 1;

  bool get canSubmit => exercise.questions.every(
    (q) => q.userTranscription != null && q.userTranscription!.isNotEmpty,
  );

  @override
  List<Object?> get props => [
    exercise,
    currentQuestionIndex,
    recordingStates,
    isPlayingAudio,
  ];

  SpeakingExerciseLoaded copyWith({
    SpeakingExercise? exercise,
    int? currentQuestionIndex,
    Map<String, String>? recordingStates,
    bool? isPlayingAudio,
  }) {
    return SpeakingExerciseLoaded(
      exercise: exercise ?? this.exercise,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      recordingStates: recordingStates ?? this.recordingStates,
      isPlayingAudio: isPlayingAudio ?? this.isPlayingAudio,
    );
  }
}

class SpeakingExerciseRecording extends SpeakingExerciseState {
  final SpeakingExercise exercise;
  final int currentQuestionIndex;
  final String recordingQuestionId;

  const SpeakingExerciseRecording({
    required this.exercise,
    required this.currentQuestionIndex,
    required this.recordingQuestionId,
  });

  @override
  List<Object?> get props => [
    exercise,
    currentQuestionIndex,
    recordingQuestionId,
  ];
}

class SpeakingExerciseTranscribing extends SpeakingExerciseState {
  final SpeakingExercise exercise;
  final int currentQuestionIndex;
  final String processingQuestionId;

  const SpeakingExerciseTranscribing({
    required this.exercise,
    required this.currentQuestionIndex,
    required this.processingQuestionId,
  });

  @override
  List<Object?> get props => [
    exercise,
    currentQuestionIndex,
    processingQuestionId,
  ];
}

class SpeakingExerciseSubmitting extends SpeakingExerciseState {}

class SpeakingExerciseCompleted extends SpeakingExerciseState {
  final SpeakingExerciseResult result;

  const SpeakingExerciseCompleted(this.result);

  @override
  List<Object?> get props => [result];
}

class SpeakingExerciseError extends SpeakingExerciseState {
  final String message;

  const SpeakingExerciseError(this.message);

  @override
  List<Object?> get props => [message];
}
