import '../../domain/entities/speaking_exercise.dart';

// Speaking Exercise Model
class SpeakingExerciseModel extends SpeakingExercise {
  const SpeakingExerciseModel({
    required super.exerciseId,
    required super.lessonId,
    required super.totalQuestions,
    required super.questions,
    required super.expiresAt,
  });

  factory SpeakingExerciseModel.fromJson(Map<String, dynamic> json) {
    return SpeakingExerciseModel(
      exerciseId: json['exerciseId'] as String,
      lessonId: json['lessonId'] as String,
      totalQuestions: json['totalQuestions'] as int,
      questions: (json['questions'] as List)
          .map((q) => SpeakingQuestionModel.fromJson(q as Map<String, dynamic>))
          .toList(),
      expiresAt: DateTime.parse(json['expiresAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exerciseId': exerciseId,
      'lessonId': lessonId,
      'totalQuestions': totalQuestions,
      'questions': questions
          .map((q) => (q as SpeakingQuestionModel).toJson())
          .toList(),
      'expiresAt': expiresAt.toIso8601String(),
    };
  }
}

// Speaking Question Model
class SpeakingQuestionModel extends SpeakingQuestion {
  const SpeakingQuestionModel({
    required super.id,
    required super.japaneseText,
    required super.romaji,
    required super.vietnameseMeaning,
    required super.audioUrl,
    super.userTranscription,
    super.confidence,
  });

  factory SpeakingQuestionModel.fromJson(Map<String, dynamic> json) {
    return SpeakingQuestionModel(
      id: json['id'] as String,
      japaneseText: json['japaneseText'] as String,
      romaji: json['romaji'] as String,
      vietnameseMeaning: json['vietnameseMeaning'] as String,
      audioUrl: json['audioUrl'] as String,
      userTranscription: json['userTranscription'] as String?,
      confidence: (json['confidence'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'japaneseText': japaneseText,
      'romaji': romaji,
      'vietnameseMeaning': vietnameseMeaning,
      'audioUrl': audioUrl,
      if (userTranscription != null) 'userTranscription': userTranscription,
      if (confidence != null) 'confidence': confidence,
    };
  }
}

// Transcription Result Model
class TranscriptionResultModel extends TranscriptionResult {
  const TranscriptionResultModel({
    required super.transcribedText,
    required super.confidence,
    required super.alternatives,
  });

  factory TranscriptionResultModel.fromJson(Map<String, dynamic> json) {
    return TranscriptionResultModel(
      transcribedText: json['transcribedText'] as String,
      confidence: (json['confidence'] as num).toDouble(),
      alternatives: (json['alternatives'] as List)
          .map((alt) => alt as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transcribedText': transcribedText,
      'confidence': confidence,
      'alternatives': alternatives,
    };
  }
}

// Speaking Exercise Result Model
class SpeakingExerciseResultModel extends SpeakingExerciseResult {
  const SpeakingExerciseResultModel({
    required super.exerciseId,
    required super.totalQuestions,
    required super.correctAnswers,
    required super.score,
    required super.questionResults,
  });

  factory SpeakingExerciseResultModel.fromJson(Map<String, dynamic> json) {
    return SpeakingExerciseResultModel(
      exerciseId: json['exerciseId'] as String,
      totalQuestions: json['totalQuestions'] as int,
      correctAnswers: json['correctAnswers'] as int,
      score: (json['score'] as num).toDouble(),
      questionResults: (json['questionResults'] as List)
          .map(
            (r) =>
                SpeakingQuestionResultModel.fromJson(r as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exerciseId': exerciseId,
      'totalQuestions': totalQuestions,
      'correctAnswers': correctAnswers,
      'score': score,
      'questionResults': questionResults
          .map((r) => (r as SpeakingQuestionResultModel).toJson())
          .toList(),
    };
  }
}

// Speaking Question Result Model
class SpeakingQuestionResultModel extends SpeakingQuestionResult {
  const SpeakingQuestionResultModel({
    required super.questionId,
    required super.expectedText,
    required super.userTranscription,
    required super.isCorrect,
    required super.confidence,
    required super.similarityScore,
  });

  factory SpeakingQuestionResultModel.fromJson(Map<String, dynamic> json) {
    return SpeakingQuestionResultModel(
      questionId: json['questionId'] as String,
      expectedText: json['expectedText'] as String,
      userTranscription: json['userTranscription'] as String,
      isCorrect: json['isCorrect'] as bool,
      confidence: (json['confidence'] as num).toDouble(),
      similarityScore: (json['similarityScore'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'expectedText': expectedText,
      'userTranscription': userTranscription,
      'isCorrect': isCorrect,
      'confidence': confidence,
      'similarityScore': similarityScore,
    };
  }
}
