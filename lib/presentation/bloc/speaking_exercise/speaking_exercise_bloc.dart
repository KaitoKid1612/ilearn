import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/create_speaking_exercise.dart';
import '../../../domain/usecases/transcribe_audio.dart';
import '../../../domain/usecases/submit_speaking_exercise.dart';
import 'speaking_exercise_event.dart';

export 'speaking_exercise_event.dart';

class SpeakingExerciseBloc
    extends Bloc<SpeakingExerciseEvent, SpeakingExerciseState> {
  final CreateSpeakingExercise createSpeakingExercise;
  final TranscribeAudio transcribeAudio;
  final SubmitSpeakingExercise submitSpeakingExercise;

  SpeakingExerciseBloc({
    required this.createSpeakingExercise,
    required this.transcribeAudio,
    required this.submitSpeakingExercise,
  }) : super(SpeakingExerciseInitial()) {
    on<LoadSpeakingExercise>(_onLoadSpeakingExercise);
    on<RecordAudio>(_onRecordAudio);
    on<StopRecording>(_onStopRecording);
    on<TranscribeRecording>(_onTranscribeRecording);
    on<UpdateQuestionTranscription>(_onUpdateQuestionTranscription);
    on<SubmitSpeakingExerciseEvent>(_onSubmitSpeakingExercise);
    on<PlayQuestionAudio>(_onPlayQuestionAudio);
    on<ResetSpeakingExercise>(_onResetSpeakingExercise);
  }

  Future<void> _onLoadSpeakingExercise(
    LoadSpeakingExercise event,
    Emitter<SpeakingExerciseState> emit,
  ) async {
    emit(SpeakingExerciseLoading());

    final result = await createSpeakingExercise(event.lessonId);

    result.fold(
      (failure) => emit(SpeakingExerciseError(failure.message)),
      (exercise) => emit(
        SpeakingExerciseLoaded(
          exercise: exercise,
          currentQuestionIndex: 0,
          recordingStates: {},
        ),
      ),
    );
  }

  Future<void> _onRecordAudio(
    RecordAudio event,
    Emitter<SpeakingExerciseState> emit,
  ) async {
    if (state is SpeakingExerciseLoaded) {
      final currentState = state as SpeakingExerciseLoaded;

      // Update recording state for this question
      final newRecordingStates = Map<String, String>.from(
        currentState.recordingStates,
      );
      newRecordingStates[event.questionId] = 'recording';

      emit(currentState.copyWith(recordingStates: newRecordingStates));
    }
  }

  Future<void> _onStopRecording(
    StopRecording event,
    Emitter<SpeakingExerciseState> emit,
  ) async {
    if (state is SpeakingExerciseLoaded) {
      final currentState = state as SpeakingExerciseLoaded;

      // Update recording state for this question
      final newRecordingStates = Map<String, String>.from(
        currentState.recordingStates,
      );
      newRecordingStates[event.questionId] = 'idle';

      emit(currentState.copyWith(recordingStates: newRecordingStates));
    }
  }

  Future<void> _onTranscribeRecording(
    TranscribeRecording event,
    Emitter<SpeakingExerciseState> emit,
  ) async {
    if (state is SpeakingExerciseLoaded) {
      final currentState = state as SpeakingExerciseLoaded;

      // Update state to show processing
      final newRecordingStates = Map<String, String>.from(
        currentState.recordingStates,
      );
      newRecordingStates[event.questionId] = 'processing';
      emit(currentState.copyWith(recordingStates: newRecordingStates));

      // Call transcription API
      final result = await transcribeAudio(
        currentState.exercise.exerciseId,
        event.audioFile,
      );

      result.fold(
        (failure) {
          // Reset to idle state on error
          newRecordingStates[event.questionId] = 'idle';
          emit(currentState.copyWith(recordingStates: newRecordingStates));
          emit(SpeakingExerciseError(failure.message));
          // Restore the loaded state
          emit(currentState.copyWith(recordingStates: newRecordingStates));
        },
        (transcription) {
          // Update question with transcription
          add(
            UpdateQuestionTranscription(
              event.questionId,
              transcription.transcribedText,
              transcription.confidence,
            ),
          );
        },
      );
    }
  }

  Future<void> _onUpdateQuestionTranscription(
    UpdateQuestionTranscription event,
    Emitter<SpeakingExerciseState> emit,
  ) async {
    if (state is SpeakingExerciseLoaded) {
      final currentState = state as SpeakingExerciseLoaded;

      // Update the question with transcription
      final updatedQuestions = currentState.exercise.questions.map((q) {
        if (q.id == event.questionId) {
          return q.copyWith(
            userTranscription: event.transcription,
            confidence: event.confidence,
          );
        }
        return q;
      }).toList();

      final updatedExercise = currentState.exercise.copyWith(
        questions: updatedQuestions,
      );

      // Reset recording state to idle
      final newRecordingStates = Map<String, String>.from(
        currentState.recordingStates,
      );
      newRecordingStates[event.questionId] = 'idle';

      emit(
        currentState.copyWith(
          exercise: updatedExercise,
          recordingStates: newRecordingStates,
        ),
      );
    }
  }

  Future<void> _onSubmitSpeakingExercise(
    SubmitSpeakingExerciseEvent event,
    Emitter<SpeakingExerciseState> emit,
  ) async {
    if (state is SpeakingExerciseLoaded) {
      final currentState = state as SpeakingExerciseLoaded;

      emit(SpeakingExerciseSubmitting());

      // Prepare answers map
      final answers = <String, String>{};
      for (var question in currentState.exercise.questions) {
        if (question.userTranscription != null) {
          answers[question.id] = question.userTranscription!;
        }
      }

      final result = await submitSpeakingExercise(
        currentState.exercise.exerciseId,
        answers,
      );

      result.fold(
        (failure) => emit(SpeakingExerciseError(failure.message)),
        (exerciseResult) => emit(SpeakingExerciseCompleted(exerciseResult)),
      );
    }
  }

  Future<void> _onPlayQuestionAudio(
    PlayQuestionAudio event,
    Emitter<SpeakingExerciseState> emit,
  ) async {
    if (state is SpeakingExerciseLoaded) {
      final currentState = state as SpeakingExerciseLoaded;

      // Toggle audio playing state
      emit(currentState.copyWith(isPlayingAudio: true));

      // Audio player will handle the actual playback
      // After audio finishes, we should reset the state
      await Future.delayed(const Duration(milliseconds: 100));

      emit(currentState.copyWith(isPlayingAudio: false));
    }
  }

  Future<void> _onResetSpeakingExercise(
    ResetSpeakingExercise event,
    Emitter<SpeakingExerciseState> emit,
  ) async {
    emit(SpeakingExerciseInitial());
  }
}
