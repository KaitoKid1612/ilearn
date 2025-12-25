class ApiEndpoints {
  // Base
  static const String api = '/api/v1';

  // Authentication
  static const String login = '$api/auth/login';
  static const String register = '$api/auth/register';
  static const String logout = '$api/auth/logout';
  static const String refreshToken = '$api/auth/refresh';
  static const String forgotPassword = '$api/auth/forgot-password';
  static const String resetPassword = '$api/auth/reset-password';
  static const String verifyEmail = '$api/auth/verify-email';
  static const String resendVerification = '$api/auth/resend-verification';

  // User
  static const String profile = '$api/user/profile';
  static const String updateProfile = '$api/user/profile';
  static const String changePassword = '$api/user/change-password';
  static const String deleteAccount = '$api/user/delete';

  // Lessons
  static const String lessons = '$api/lessons';
  static String lessonDetail(String id) => '$api/lessons/$id';
  static String lessonProgress(String id) => '$api/lessons/$id/progress';
  static const String myLessons = '$api/lessons/my-lessons';

  // Flashcards
  static const String flashcards = '$api/flashcards';
  static String flashcardDetail(String id) => '$api/flashcards/$id';
  static String flashcardReview(String id) => '$api/flashcards/$id/review';
  static const String flashcardDecks = '$api/flashcards/decks';

  // Quiz
  static const String quizzes = '$api/quizzes';
  static String quizDetail(String id) => '$api/quizzes/$id';
  static String quizSubmit(String id) => '$api/quizzes/$id/submit';
  static String quizResults(String id) => '$api/quizzes/$id/results';

  // Test
  static const String tests = '$api/tests';
  static String testDetail(String id) => '$api/tests/$id';
  static String testSubmit(String id) => '$api/tests/$id/submit';
  static String testResults(String id) => '$api/tests/$id/results';

  // Games
  static const String games = '$api/games';
  static String gameDetail(String id) => '$api/games/$id';
  static String gameScore(String id) => '$api/games/$id/score';

  // AI Content Generation
  static const String aiGenerateLesson = '$api/ai/generate-lesson';
  static const String aiGenerateFlashcards = '$api/ai/generate-flashcards';
  static const String aiGenerateQuiz = '$api/ai/generate-quiz';
  static const String aiGenerateTest = '$api/ai/generate-test';

  // Analytics
  static const String analytics = '$api/analytics';
  static const String learningProgress = '$api/analytics/progress';
  static const String learningStats = '$api/analytics/stats';
}
