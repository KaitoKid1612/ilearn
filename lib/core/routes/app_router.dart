import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ilearn/presentation/screens/auth/forgot_password/forgot_password_screen.dart';
import 'package:ilearn/presentation/screens/auth/login/login_screen.dart';
import 'package:ilearn/presentation/screens/auth/register/register_screen.dart';
import 'package:ilearn/presentation/screens/home/home_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: [
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

      // Main App Routes
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
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
