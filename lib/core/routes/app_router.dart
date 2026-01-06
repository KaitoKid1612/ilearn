import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ilearn/core/di/dependency_injection.dart';
import 'package:ilearn/data/models/lesson_vocabulary_model.dart';
import 'package:ilearn/data/repositories/learning_repository.dart';
import 'package:ilearn/domain/entities/vocabulary.dart';
import 'package:ilearn/domain/entities/vocabulary_progress.dart';
import 'package:ilearn/presentation/bloc/flashcard/flashcard_bloc.dart';
import 'package:ilearn/presentation/bloc/flashcard/flashcard_event.dart';
import 'package:ilearn/presentation/bloc/exercise/exercise_bloc.dart';
import 'package:ilearn/presentation/bloc/grammar/grammar_bloc.dart';
import 'package:ilearn/presentation/bloc/grammar/grammar_event.dart';
import 'package:ilearn/presentation/bloc/grammar_practice/grammar_practice_bloc.dart';
import 'package:ilearn/presentation/bloc/speaking_exercise/speaking_exercise_bloc.dart';
import 'package:ilearn/presentation/bloc/typing_exercise/typing_exercise_bloc.dart';
import 'package:ilearn/presentation/bloc/roadmap/roadmap_bloc.dart';
import 'package:ilearn/presentation/bloc/vocabulary/vocabulary_bloc.dart';
import 'package:ilearn/presentation/bloc/lesson_exercise/lesson_exercise_bloc.dart';
import 'package:ilearn/presentation/screens/auth/forgot_password/forgot_password_screen.dart';
import 'package:ilearn/presentation/screens/auth/login_screen.dart';
import 'package:ilearn/presentation/screens/auth/register_screen.dart';
import 'package:ilearn/presentation/screens/flashcard/flashcard_study_screen.dart';
import 'package:ilearn/presentation/screens/exercise/exercise_screen.dart';
import 'package:ilearn/presentation/screens/grammar/grammar_detail_screen.dart';
import 'package:ilearn/presentation/screens/grammar/grammar_list_screen.dart';
import 'package:ilearn/presentation/screens/grammar/grammar_practice_screen.dart';
import 'package:ilearn/presentation/screens/speaking_exercise/speaking_exercise_screen.dart';
import 'package:ilearn/presentation/screens/typing_exercise/typing_exercise_screen.dart';
import 'package:ilearn/presentation/screens/vocabulary/vocabulary_list_screen.dart';
import 'package:ilearn/presentation/screens/exercise/lesson_exercise_list_screen.dart';
import 'package:ilearn/presentation/screens/splash/splash_screen.dart';
import 'package:ilearn/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:ilearn/presentation/screens/roadmap/roadmap_screen.dart';
import 'package:ilearn/presentation/screens/home/home_screen.dart';
import 'package:ilearn/presentation/screens/debug/debug_screen.dart';
import 'package:ilearn/presentation/screens/vocabulary/vocabulary_learning_screen.dart';
import 'package:ilearn/presentation/screens/vocabulary/modes/learn_mode_screen.dart';
import 'package:ilearn/presentation/screens/vocabulary/modes/practice_mode_screen.dart';
import 'package:ilearn/presentation/screens/vocabulary/modes/speaking_mode_screen.dart';
import 'package:ilearn/presentation/screens/vocabulary/modes/writing_mode_screen.dart';
import 'package:ilearn/presentation/screens/lesson/lesson_detail_screen.dart';
import 'package:ilearn/presentation/screens/profile/profile_screen.dart';
import 'package:ilearn/presentation/screens/kanji/kanji_learning_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      // Splash Screen
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),

      // Auth Routes
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        name: 'forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),

      // Dashboard
      GoRoute(
        path: '/dashboard',
        name: 'dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),

      // Profile
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfileScreen(),
      ),

      // Roadmap
      GoRoute(
        path: '/roadmap/:textbookId',
        name: 'roadmap',
        builder: (context, state) {
          final textbookId = state.pathParameters['textbookId']!;
          final textbookTitle = state.uri.queryParameters['title'] ?? 'Roadmap';

          return BlocProvider(
            create: (context) => RoadmapBloc(getIt<LearningRepository>()),
            child: RoadmapScreen(
              textbookId: textbookId,
              textbookTitle: textbookTitle,
            ),
          );
        },
      ),

      // Main App Routes
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),

      // Debug Screen (Developer Tools)
      GoRoute(
        path: '/debug',
        name: 'debug',
        builder: (context, state) => const DebugScreen(),
      ),

      // Vocabulary Learning
      GoRoute(
        path: '/vocabulary/:lessonId',
        name: 'vocabulary',
        builder: (context, state) {
          final lessonId = state.pathParameters['lessonId']!;
          final lessonTitle =
              state.uri.queryParameters['title'] ?? 'Vocabulary';

          return BlocProvider(
            create: (context) => getIt<VocabularyBloc>(),
            child: VocabularyLearningScreen(
              lessonId: lessonId,
              lessonTitle: lessonTitle,
            ),
          );
        },
      ),

      // Vocabulary Learn Mode
      GoRoute(
        path: '/vocabulary-learn',
        name: 'vocabulary-learn',
        builder: (context, state) {
          final args = state.extra as Map<String, dynamic>?;
          return LearnModeScreen(
            lessonId: args?['lessonId'] ?? '',
            vocabulary:
                (args?['vocabulary'] as List<dynamic>?)?.cast<Vocabulary>() ??
                [],
            progress: args?['progress'] as VocabularyProgress?,
          );
        },
      ),

      // Vocabulary Practice Mode
      GoRoute(
        path: '/vocabulary-practice',
        name: 'vocabulary-practice',
        builder: (context, state) {
          final args = state.extra as Map<String, dynamic>?;
          return PracticeModeScreen(
            lessonId: args?['lessonId'] ?? '',
            vocabulary:
                (args?['vocabulary'] as List<dynamic>?)?.cast<Vocabulary>() ??
                [],
            progress: args?['progress'] as VocabularyProgress?,
          );
        },
      ),

      // Vocabulary Speaking Mode
      GoRoute(
        path: '/vocabulary-speaking',
        name: 'vocabulary-speaking',
        builder: (context, state) {
          final args = state.extra as Map<String, dynamic>?;
          return SpeakingModeScreen(
            lessonId: args?['lessonId'] ?? '',
            vocabulary:
                (args?['vocabularies'] as List<dynamic>?)
                    ?.cast<VocabularyItemModel>() ??
                [],
            progress: args?['progress'] as VocabularyProgress?,
          );
        },
      ),

      // Vocabulary Writing Mode
      GoRoute(
        path: '/vocabulary-writing',
        name: 'vocabulary-writing',
        builder: (context, state) {
          final args = state.extra as Map<String, dynamic>?;
          return WritingModeScreen(
            lessonId: args?['lessonId'] ?? '',
            vocabulary:
                (args?['vocabulary'] as List<dynamic>?)?.cast<Vocabulary>() ??
                [],
            progress: args?['progress'] as VocabularyProgress?,
          );
        },
      ),

      // Lesson Detail
      GoRoute(
        path: '/lesson/:lessonId',
        name: 'lesson',
        builder: (context, state) {
          final lessonId = state.pathParameters['lessonId']!;
          return LessonDetailScreen(lessonId: lessonId);
        },
      ),

      // Lesson Vocabulary Learning
      GoRoute(
        path: '/lesson/:lessonId/vocabulary',
        name: 'lesson-vocabulary',
        builder: (context, state) {
          final lessonId = state.pathParameters['lessonId']!;
          return BlocProvider(
            create: (context) => getIt<VocabularyBloc>(),
            child: VocabularyLearningScreen(
              lessonId: lessonId,
              lessonTitle: 'Từ vựng',
            ),
          );
        },
      ),
      // Flashcard Study
      GoRoute(
        path: '/flashcard/:lessonId',
        name: 'flashcard',
        builder: (context, state) {
          final lessonId = state.pathParameters['lessonId']!;
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    getIt<FlashcardBloc>()..add(StartStudyEvent(lessonId)),
              ),
              BlocProvider(create: (context) => getIt<VocabularyBloc>()),
            ],
            child: FlashcardStudyScreen(lessonId: lessonId),
          );
        },
      ),
      // Exercise (Multiple Choice)
      GoRoute(
        path: '/exercise/:lessonId',
        name: 'exercise',
        builder: (context, state) {
          final lessonId = state.pathParameters['lessonId']!;
          return BlocProvider(
            create: (context) => getIt<ExerciseBloc>(),
            child: ExerciseScreen(lessonId: lessonId),
          );
        },
      ),
      // Typing Exercise (Writing Mode)
      GoRoute(
        path: '/typing-exercise/:lessonId',
        name: 'typing-exercise',
        builder: (context, state) {
          final lessonId = state.pathParameters['lessonId']!;
          return BlocProvider(
            create: (context) => getIt<TypingExerciseBloc>(),
            child: TypingExerciseScreen(lessonId: lessonId),
          );
        },
      ),
      // Speaking Exercise
      GoRoute(
        path: '/speaking-exercise/:lessonId',
        name: 'speaking-exercise',
        builder: (context, state) {
          final lessonId = state.pathParameters['lessonId']!;
          return BlocProvider(
            create: (context) => getIt<SpeakingExerciseBloc>(),
            child: SpeakingExerciseScreen(lessonId: lessonId),
          );
        },
      ),

      // Grammar List
      GoRoute(
        path: '/grammar-list/:lessonId',
        name: 'grammar-list',
        builder: (context, state) {
          final lessonId = state.pathParameters['lessonId']!;
          final title = state.uri.queryParameters['title'] ?? 'Grammar';
          return BlocProvider(
            create: (context) =>
                getIt<GrammarBloc>()..add(LoadGrammarList(lessonId)),
            child: GrammarListScreen(lessonId: lessonId, lessonTitle: title),
          );
        },
      ),

      // Grammar Detail
      GoRoute(
        path: '/grammar-detail/:lessonId/:grammarId',
        name: 'grammar-detail',
        builder: (context, state) {
          final lessonId = state.pathParameters['lessonId']!;
          final grammarId = state.pathParameters['grammarId']!;
          final extra = state.extra as Map<String, dynamic>?;
          return BlocProvider(
            create: (context) =>
                getIt<GrammarBloc>()
                  ..add(LoadGrammarDetail(lessonId, grammarId)),
            child: GrammarDetailScreen(
              lessonId: lessonId,
              grammarId: grammarId,
              lessonTitle: extra?['lessonTitle'] ?? 'Grammar',
              grammarTitle: extra?['grammarTitle'] ?? 'Grammar Detail',
            ),
          );
        },
      ),

      // Grammar Practice
      GoRoute(
        path: '/grammar-practice/:lessonId/:grammarId',
        name: 'grammar-practice',
        builder: (context, state) {
          final lessonId = state.pathParameters['lessonId']!;
          final grammarId = state.pathParameters['grammarId']!;
          final extra = state.extra as Map<String, dynamic>?;
          return BlocProvider(
            create: (context) => getIt<GrammarPracticeBloc>(),
            child: GrammarPracticeScreen(
              grammarId: grammarId,
              lessonId: lessonId,
              grammarTitle: extra?['grammarTitle'] ?? 'Grammar Practice',
            ),
          );
        },
      ),

      // Vocabulary List
      GoRoute(
        path: '/vocabulary-list/:lessonId',
        name: 'vocabulary-list',
        builder: (context, state) {
          final lessonId = state.pathParameters['lessonId']!;
          final title =
              state.uri.queryParameters['title'] ?? 'Danh sách từ vựng';
          return BlocProvider(
            create: (context) => getIt<VocabularyBloc>(),
            child: VocabularyListScreen(lessonId: lessonId, lessonTitle: title),
          );
        },
      ),
      // Lesson Grammar
      GoRoute(
        path: '/lesson/:lessonId/grammar',
        name: 'lesson-grammar',
        builder: (context, state) {
          final lessonId = state.pathParameters['lessonId']!;
          return Scaffold(
            appBar: AppBar(title: const Text('Ngữ pháp')),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Grammar Screen - Coming Soon'),
                  const SizedBox(height: 16),
                  Text('Lesson ID: $lessonId'),
                ],
              ),
            ),
          );
        },
      ),

      // Lesson Kanji
      GoRoute(
        path: '/lesson/:lessonId/kanji',
        name: 'lesson-kanji',
        builder: (context, state) {
          final lessonId = state.pathParameters['lessonId']!;
          final lessonTitle = state.uri.queryParameters['title'];
          return KanjiLearningScreen(
            lessonId: lessonId,
            lessonTitle: lessonTitle,
          );
        },
      ),

      // Lesson Exercises
      GoRoute(
        path: '/lesson/:lessonId/exercises',
        name: 'lesson-exercises',
        builder: (context, state) {
          final lessonId = state.pathParameters['lessonId']!;
          final title = state.uri.queryParameters['title'] ?? 'Bài tập';
          return BlocProvider(
            create: (context) => getIt<LessonExerciseBloc>(),
            child: LessonExerciseListScreen(
              lessonId: lessonId,
              lessonTitle: title,
            ),
          );
        },
      ),

      // Lessons
      GoRoute(
        path: '/lessons',
        name: 'lessons',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Lessons Screen - Coming Soon')),
        ),
      ),

      // Flashcards
      GoRoute(
        path: '/flashcards',
        name: 'flashcards',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Flashcards Screen - Coming Soon')),
        ),
      ),

      // Quiz
      GoRoute(
        path: '/quiz',
        name: 'quiz',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Quiz Screen - Coming Soon')),
        ),
      ),

      // Games
      GoRoute(
        path: '/games',
        name: 'games',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Games Screen - Coming Soon')),
        ),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Page not found: ${state.uri.path}')),
    ),
  );
}
