import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../../core/theme/app_colors.dart';
import '../../bloc/speaking_exercise/speaking_exercise_bloc.dart';
import '../../widgets/common/loading_widget.dart';
import 'speaking_result_screen.dart';

class SpeakingExerciseScreen extends StatefulWidget {
  final String lessonId;

  const SpeakingExerciseScreen({super.key, required this.lessonId});

  @override
  State<SpeakingExerciseScreen> createState() => _SpeakingExerciseScreenState();
}

class _SpeakingExerciseScreenState extends State<SpeakingExerciseScreen> {
  final AudioRecorder _audioRecorder = AudioRecorder();
  final AudioPlayer _audioPlayer = AudioPlayer();
  int _currentQuestionIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<SpeakingExerciseBloc>().add(
      LoadSpeakingExercise(widget.lessonId),
    );
  }

  @override
  void dispose() {
    _audioRecorder.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _startRecording(String questionId) async {
    try {
      if (await _audioRecorder.hasPermission()) {
        final directory = await getTemporaryDirectory();
        final path =
            '${directory.path}/recording_${DateTime.now().millisecondsSinceEpoch}.m4a';

        await _audioRecorder.start(
          const RecordConfig(
            encoder: AudioEncoder.aacLc,
            bitRate: 128000,
            sampleRate: 44100,
          ),
          path: path,
        );

        context.read<SpeakingExerciseBloc>().add(RecordAudio(questionId));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Lỗi khi bắt đầu ghi âm: $e')));
    }
  }

  Future<void> _stopRecording(String questionId) async {
    try {
      final path = await _audioRecorder.stop();

      if (path != null && path.isNotEmpty) {
        // Transcribe the recorded audio
        context.read<SpeakingExerciseBloc>().add(
          TranscribeRecording(questionId, File(path)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Lỗi khi dừng ghi âm: $e')));
    }
  }

  Future<void> _playAudio(String audioUrl) async {
    try {
      await _audioPlayer.play(UrlSource(audioUrl));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Lỗi khi phát âm thanh: $e')));
    }
  }

  void _nextQuestion() {
    setState(() {
      _currentQuestionIndex++;
    });
  }

  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Bài tập phát âm'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: BlocConsumer<SpeakingExerciseBloc, SpeakingExerciseState>(
        listener: (context, state) {
          if (state is SpeakingExerciseError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }

          if (state is SpeakingExerciseCompleted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => SpeakingResultScreen(result: state.result),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is SpeakingExerciseLoading) {
            return const LoadingWidget();
          }

          if (state is SpeakingExerciseLoaded) {
            final exercise = state.exercise;

            // Use the state's current question index instead of local state
            if (_currentQuestionIndex >= exercise.questions.length) {
              _currentQuestionIndex = exercise.questions.length - 1;
            }

            final question = exercise.questions[_currentQuestionIndex];
            final recordingState = state.recordingStates[question.id] ?? 'idle';
            final hasTranscription =
                question.userTranscription != null &&
                question.userTranscription!.isNotEmpty;

            return Column(
              children: [
                // Progress bar
                LinearProgressIndicator(
                  value: (_currentQuestionIndex + 1) / exercise.totalQuestions,
                  backgroundColor: Colors.grey[200],
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.primary,
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Question counter
                        Text(
                          'Câu ${_currentQuestionIndex + 1}/${exercise.totalQuestions}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),

                        // Japanese text card
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              children: [
                                // Play audio button
                                IconButton(
                                  onPressed: () =>
                                      _playAudio(question.audioUrl),
                                  icon: const Icon(Icons.volume_up, size: 48),
                                  color: AppColors.primary,
                                ),
                                const SizedBox(height: 16),

                                // Japanese text
                                Text(
                                  question.japaneseText,
                                  style: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 12),

                                // Romaji
                                Text(
                                  question.romaji,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey[700],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 8),

                                // Vietnamese meaning
                                Text(
                                  question.vietnameseMeaning,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[600],
                                    fontStyle: FontStyle.italic,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Recording section
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              children: [
                                Text(
                                  recordingState == 'recording'
                                      ? 'Đang ghi âm...'
                                      : recordingState == 'processing'
                                      ? 'Đang xử lý...'
                                      : 'Nhấn để bắt đầu ghi âm',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 16),

                                // Record button
                                GestureDetector(
                                  onTap: recordingState == 'processing'
                                      ? null
                                      : () {
                                          if (recordingState == 'recording') {
                                            _stopRecording(question.id);
                                          } else {
                                            _startRecording(question.id);
                                          }
                                        },
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: recordingState == 'recording'
                                          ? Colors.red
                                          : recordingState == 'processing'
                                          ? Colors.grey
                                          : AppColors.primary,
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              (recordingState == 'recording'
                                                      ? Colors.red
                                                      : AppColors.primary)
                                                  .withOpacity(0.3),
                                          blurRadius: 12,
                                          spreadRadius: 4,
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      recordingState == 'recording'
                                          ? Icons.stop
                                          : recordingState == 'processing'
                                          ? Icons.hourglass_empty
                                          : Icons.mic,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 24),

                                // Transcription result
                                if (hasTranscription) ...[
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: AppColors.accent.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: AppColors.accent.withOpacity(
                                          0.3,
                                        ),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.check_circle,
                                              color: AppColors.accent,
                                              size: 20,
                                            ),
                                            const SizedBox(width: 8),
                                            const Text(
                                              'Kết quả nhận diện:',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          question.userTranscription!,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        if (question.confidence != null) ...[
                                          const SizedBox(height: 8),
                                          Text(
                                            'Độ chính xác: ${(question.confidence! * 100).toStringAsFixed(0)}%',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Bottom navigation
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(color: Colors.grey.shade200),
                    ),
                  ),
                  child: Row(
                    children: [
                      if (_currentQuestionIndex > 0)
                        Expanded(
                          child: OutlinedButton(
                            onPressed: _previousQuestion,
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: const Text('Câu trước'),
                          ),
                        ),
                      if (_currentQuestionIndex > 0) const SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed:
                              _currentQuestionIndex <
                                  exercise.totalQuestions - 1
                              ? _nextQuestion
                              : state.canSubmit
                              ? () {
                                  context.read<SpeakingExerciseBloc>().add(
                                    const SubmitSpeakingExerciseEvent(),
                                  );
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            disabledBackgroundColor: Colors.grey[300],
                          ),
                          child: Text(
                            _currentQuestionIndex < exercise.totalQuestions - 1
                                ? 'Câu tiếp theo'
                                : 'Nộp bài',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          if (state is SpeakingExerciseSubmitting) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Đang nộp bài...'),
                ],
              ),
            );
          }

          return const Center(child: Text('Đã xảy ra lỗi'));
        },
      ),
    );
  }
}
