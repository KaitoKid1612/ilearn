import 'dart:io';
import 'package:dio/dio.dart';
import '../../core/constants/api_endpoints.dart';
import '../../core/network/dio_client.dart';
import '../models/speaking_exercise_model.dart';

abstract class SpeakingExerciseRemoteDataSource {
  /// Create a new speaking exercise for a lesson
  Future<SpeakingExerciseModel> createSpeakingExercise(String lessonId);

  /// Transcribe audio file using Google Speech API
  Future<TranscriptionResultModel> transcribeAudio(
    String exerciseId,
    File audioFile,
  );

  /// Submit speaking exercise answers and get results
  Future<SpeakingExerciseResultModel> submitSpeakingExercise(
    String exerciseId,
    Map<String, String> answers,
  );
}

class SpeakingExerciseRemoteDataSourceImpl
    implements SpeakingExerciseRemoteDataSource {
  final DioClient _dioClient;

  SpeakingExerciseRemoteDataSourceImpl(this._dioClient);

  @override
  Future<SpeakingExerciseModel> createSpeakingExercise(String lessonId) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoints.createSpeakingExercise(lessonId),
      );

      if (response.data['success'] == true && response.data['data'] != null) {
        return SpeakingExerciseModel.fromJson(response.data['data']);
      } else {
        throw Exception(
          response.data['message'] ?? 'Failed to create speaking exercise',
        );
      }
    } catch (e) {
      throw Exception('Error creating speaking exercise: $e');
    }
  }

  @override
  Future<TranscriptionResultModel> transcribeAudio(
    String exerciseId,
    File audioFile,
  ) async {
    try {
      // Create form data with audio file
      final formData = FormData.fromMap({
        'audio': await MultipartFile.fromFile(
          audioFile.path,
          filename: 'audio.${audioFile.path.split('.').last}',
        ),
      });

      final response = await _dioClient.post(
        ApiEndpoints.transcribeAudio(exerciseId),
        data: formData,
      );

      if (response.data['success'] == true && response.data['data'] != null) {
        return TranscriptionResultModel.fromJson(response.data['data']);
      } else {
        throw Exception(
          response.data['message'] ?? 'Failed to transcribe audio',
        );
      }
    } catch (e) {
      throw Exception('Error transcribing audio: $e');
    }
  }

  @override
  Future<SpeakingExerciseResultModel> submitSpeakingExercise(
    String exerciseId,
    Map<String, String> answers,
  ) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoints.submitSpeakingExercise(exerciseId),
        data: {'answers': answers},
      );

      if (response.data['success'] == true && response.data['data'] != null) {
        return SpeakingExerciseResultModel.fromJson(response.data['data']);
      } else {
        throw Exception(
          response.data['message'] ?? 'Failed to submit speaking exercise',
        );
      }
    } catch (e) {
      throw Exception('Error submitting speaking exercise: $e');
    }
  }
}
