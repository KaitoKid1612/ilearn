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
  static const String dashboard = '$api/users/me/dashboard';

  // Courses
  static const String courses = '$api/courses';
  static String courseDetail(String id) => '$api/courses/$id';
  static String courseEnroll(String id) => '$api/courses/$id/enroll';
  static String courseProgress(String id) => '$api/courses/$id/progress';
  static String courseLessons(String courseId) =>
      '$api/courses/$courseId/lessons';
  static const String myCourses = '$api/courses/my-courses';

  // Textbooks & Roadmap
  static String textbookRoadmap(String textbookId) =>
      '$api/textbooks/$textbookId/roadmap';

  // Lessons
  static const String lessons = '$api/lessons';
  static String lessonDetail(String id) => '$api/lessons/$id';
  static String lessonProgress(String id) => '$api/lessons/$id/progress';
  static String lessonVocabulary(String id) => '$api/lessons/$id/vocabulary';
  static const String myLessons = '$api/lessons/my-lessons';
  static String markItemLearned(String lessonId) =>
      '$api/lessons/$lessonId/mark-learned';
  static String batchMarkLearned(String lessonId) =>
      '$api/lessons/$lessonId/batch-mark-learned';

  // Kanji
  static String lessonKanji(String lessonId) => '$api/lessons/$lessonId/kanji';

  // Flashcards
  static String flashcardsByLesson(String lessonId) =>
      '$api/flashcards/lessons/$lessonId';
  static String flashcardStartStudy(String lessonId) =>
      '$api/flashcards/lessons/$lessonId/study';
  static String flashcardAnswer(String flashcardId) =>
      '$api/flashcards/$flashcardId/answer';
  static const String flashcardDailyReview = '$api/flashcards/daily-review';

  // Exercises
  static String lessonExercises(String lessonId) =>
      '$api/lessons/$lessonId/exercises';
  static String createMultipleChoiceExercise(String lessonId) =>
      '$api/exercises/lessons/$lessonId/multiple-choice';
  static String submitExercise(String exerciseId) =>
      '$api/exercises/$exerciseId/submit';

  // Exercise Session
  static String startExerciseSession(String lessonId) =>
      '$api/lessons/$lessonId/exercises/start-session';
  static String submitExerciseSession(String lessonId, String sessionId) =>
      '$api/lessons/$lessonId/exercises/sessions/$sessionId/submit';

  // Typing Exercises
  static String createTypingExercise(String lessonId, {int limit = 10}) =>
      '$api/exercises/lessons/$lessonId/typing?limit=$limit';
  static String submitTypingExercise(String exerciseId) =>
      '$api/exercises/$exerciseId/submit-typing';

  // Speaking Exercises
  static String createSpeakingExercise(String lessonId) =>
      '$api/exercises/lessons/$lessonId/speaking';
  static String transcribeAudio(String exerciseId) =>
      '$api/exercises/$exerciseId/transcribe-audio';
  static String submitSpeakingExercise(String exerciseId) =>
      '$api/exercises/$exerciseId/submit-speaking';

  // Analytics
  static const String analytics = '$api/analytics';
  static const String learningProgress = '$api/analytics/progress';
  static const String learningStats = '$api/analytics/stats';
}
