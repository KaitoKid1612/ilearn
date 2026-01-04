import '../../domain/entities/typing_exercise.dart';

/// Model cho câu hỏi typing
class TypingQuestionModel extends TypingQuestion {
  const TypingQuestionModel({
    required super.id,
    required super.vocabularyId,
    required super.question,
    required super.hint,
    required super.hintType,
    required super.answerType,
    super.audio,
  });

  factory TypingQuestionModel.fromJson(Map<String, dynamic> json) {
    return TypingQuestionModel(
      id: json['id'] as String,
      vocabularyId: json['vocabularyId'] as String,
      question: json['question'] as String,
      hint: json['hint'] as String,
      hintType: json['hintType'] as String,
      answerType: json['answerType'] as String,
      audio: json['audio'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vocabularyId': vocabularyId,
      'question': question,
      'hint': hint,
      'hintType': hintType,
      'answerType': answerType,
      'audio': audio,
    };
  }
}

/// Model cho bài tập typing
class TypingExerciseModel extends TypingExercise {
  const TypingExerciseModel({
    required super.exerciseId,
    required super.lessonId,
    required super.title,
    required super.totalQuestions,
    required super.questions,
  });

  factory TypingExerciseModel.fromJson(Map<String, dynamic> json) {
    return TypingExerciseModel(
      exerciseId: json['exerciseId'] as String,
      lessonId: json['lessonId'] as String,
      title: json['title'] as String,
      totalQuestions: json['totalQuestions'] as int,
      questions: (json['questions'] as List<dynamic>)
          .map(
            (question) =>
                TypingQuestionModel.fromJson(question as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exerciseId': exerciseId,
      'lessonId': lessonId,
      'title': title,
      'totalQuestions': totalQuestions,
      'questions': questions
          .map((question) => (question as TypingQuestionModel).toJson())
          .toList(),
    };
  }
}

/// Model cho kết quả câu hỏi typing
class TypingQuestionResultModel extends TypingQuestionResult {
  const TypingQuestionResultModel({
    required super.questionId,
    required super.userAnswer,
    required super.correctAnswer,
    required super.isCorrect,
  });

  factory TypingQuestionResultModel.fromJson(Map<String, dynamic> json) {
    return TypingQuestionResultModel(
      questionId: json['questionId'] as String,
      userAnswer: json['userAnswer'] as String,
      correctAnswer: json['correctAnswer'] as String,
      isCorrect: json['isCorrect'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'userAnswer': userAnswer,
      'correctAnswer': correctAnswer,
      'isCorrect': isCorrect,
    };
  }
}

/// Model cho kết quả bài tập typing
class TypingExerciseResultModel extends TypingExerciseResult {
  const TypingExerciseResultModel({
    required super.exerciseId,
    required super.totalQuestions,
    required super.correctAnswers,
    required super.incorrectAnswers,
    required super.score,
    required super.pointsEarned,
    required super.results,
    required super.message,
  });

  factory TypingExerciseResultModel.fromJson(Map<String, dynamic> json) {
    return TypingExerciseResultModel(
      exerciseId: json['exerciseId'] as String,
      totalQuestions: json['totalQuestions'] as int,
      correctAnswers: json['correctAnswers'] as int,
      incorrectAnswers: json['incorrectAnswers'] as int,
      score: json['score'] as int,
      pointsEarned: json['pointsEarned'] as int,
      results: (json['results'] as List<dynamic>)
          .map(
            (result) => TypingQuestionResultModel.fromJson(
              result as Map<String, dynamic>,
            ),
          )
          .toList(),
      message: json['message'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exerciseId': exerciseId,
      'totalQuestions': totalQuestions,
      'correctAnswers': correctAnswers,
      'incorrectAnswers': incorrectAnswers,
      'score': score,
      'pointsEarned': pointsEarned,
      'results': results
          .map((result) => (result as TypingQuestionResultModel).toJson())
          .toList(),
      'message': message,
    };
  }
}
