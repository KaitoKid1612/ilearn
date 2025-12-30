import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ilearn/core/di/dependency_injection.dart';
import 'package:ilearn/data/repositories/learning_repository.dart';
import 'package:ilearn/domain/entities/vocabulary.dart';
import 'package:ilearn/domain/entities/vocabulary_progress.dart';
import 'package:ilearn/presentation/bloc/roadmap/roadmap_bloc.dart';
import 'package:ilearn/presentation/bloc/vocabulary/vocabulary_bloc.dart';
import 'package:ilearn/presentation/screens/auth/forgot_password/forgot_password_screen.dart';
import 'package:ilearn/presentation/screens/auth/login_screen.dart';
import 'package:ilearn/presentation/screens/auth/register_screen.dart';
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
          final args = state.extra as Map<String, dynamic>;
          return LearnModeScreen(
            lessonId: args['lessonId'],
            vocabulary: args['vocabulary'] as List<Vocabulary>,
            progress: args['progress'] as VocabularyProgress?,
          );
        },
      ),

      // Vocabulary Practice Mode
      GoRoute(
        path: '/vocabulary-practice',
        name: 'vocabulary-practice',
        builder: (context, state) {
          final args = state.extra as Map<String, dynamic>;
          return PracticeModeScreen(
            lessonId: args['lessonId'],
            vocabulary: args['vocabulary'] as List<Vocabulary>,
            progress: args['progress'] as VocabularyProgress?,
          );
        },
      ),

      // Vocabulary Speaking Mode
      GoRoute(
        path: '/vocabulary-speaking',
        name: 'vocabulary-speaking',
        builder: (context, state) {
          final args = state.extra as Map<String, dynamic>;
          return SpeakingModeScreen(
            lessonId: args['lessonId'],
            vocabulary: args['vocabulary'] as List<Vocabulary>,
            progress: args['progress'] as VocabularyProgress?,
          );
        },
      ),

      // Vocabulary Writing Mode
      GoRoute(
        path: '/vocabulary-writing',
        name: 'vocabulary-writing',
        builder: (context, state) {
          final args = state.extra as Map<String, dynamic>;
          return WritingModeScreen(
            lessonId: args['lessonId'],
            vocabulary: args['vocabulary'] as List<Vocabulary>,
            progress: args['progress'] as VocabularyProgress?,
          );
        },
      ),

      // Lesson Detail
      GoRoute(
        path: '/lesson/:lessonId',
        name: 'lesson',
        builder: (context, state) {
          final lessonId = state.pathParameters['lessonId']!;
          return Scaffold(
            appBar: AppBar(title: const Text('Bài học')),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Lesson Screen - Coming Soon'),
                  const SizedBox(height: 16),
                  Text('Lesson ID: $lessonId'),
                ],
              ),
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
