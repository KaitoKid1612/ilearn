import '../../domain/entities/exercise.dart';

/// Model cho option của câu hỏi
class QuestionOptionModel extends QuestionOption {
  const QuestionOptionModel({
    required super.id,
    required super.text,
    required super.isCorrect,
  });

  factory QuestionOptionModel.fromJson(Map<String, dynamic> json) {
    return QuestionOptionModel(
      id: json['id'] as String,
      text: json['text'] as String,
      isCorrect: json['isCorrect'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'text': text, 'isCorrect': isCorrect};
  }
}

/// Model cho câu hỏi trắc nghiệm
class QuestionModel extends Question {
  const QuestionModel({
    required super.id,
    required super.vocabularyId,
    required super.question,
    required super.questionText,
    super.audio,
    required super.options,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'] as String,
      vocabularyId: json['vocabularyId'] as String,
      question: json['question'] as String,
      questionText: json['questionText'] as String,
      audio: json['audio'] as String?,
      options: (json['options'] as List<dynamic>)
          .map(
            (option) =>
                QuestionOptionModel.fromJson(option as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vocabularyId': vocabularyId,
      'question': question,
      'questionText': questionText,
      'audio': audio,
      'options': options
          .map((option) => (option as QuestionOptionModel).toJson())
          .toList(),
    };
  }
}

/// Model cho bài tập trắc nghiệm
class ExerciseModel extends Exercise {
  const ExerciseModel({
    required super.exerciseId,
    required super.lessonId,
    required super.title,
    required super.totalQuestions,
    required super.questions,
  });

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
      exerciseId: json['exerciseId'] as String,
      lessonId: json['lessonId'] as String,
      title: json['title'] as String,
      totalQuestions: json['totalQuestions'] as int,
      questions: (json['questions'] as List<dynamic>)
          .map(
            (question) =>
                QuestionModel.fromJson(question as Map<String, dynamic>),
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
          .map((question) => (question as QuestionModel).toJson())
          .toList(),
    };
  }
}

/// Model cho kết quả câu hỏi
class QuestionResultModel extends QuestionResult {
  const QuestionResultModel({
    required super.questionId,
    required super.userAnswer,
    required super.correctAnswer,
    required super.isCorrect,
  });

  factory QuestionResultModel.fromJson(Map<String, dynamic> json) {
    return QuestionResultModel(
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

/// Model cho kết quả bài tập
class ExerciseResultModel extends ExerciseResult {
  const ExerciseResultModel({
    required super.exerciseId,
    required super.totalQuestions,
    required super.correctAnswers,
    required super.incorrectAnswers,
    required super.score,
    required super.pointsEarned,
    required super.results,
    required super.message,
  });

  factory ExerciseResultModel.fromJson(Map<String, dynamic> json) {
    return ExerciseResultModel(
      exerciseId: json['exerciseId'] as String,
      totalQuestions: json['totalQuestions'] as int,
      correctAnswers: json['correctAnswers'] as int,
      incorrectAnswers: json['incorrectAnswers'] as int,
      score: json['score'] as int,
      pointsEarned: json['pointsEarned'] as int,
      results: (json['results'] as List<dynamic>)
          .map(
            (result) =>
                QuestionResultModel.fromJson(result as Map<String, dynamic>),
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
          .map((result) => (result as QuestionResultModel).toJson())
          .toList(),
      'message': message,
    };
  }
}
