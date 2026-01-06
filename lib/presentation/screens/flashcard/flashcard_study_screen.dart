import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilearn/core/theme/app_colors.dart';
import 'package:ilearn/presentation/bloc/flashcard/flashcard_bloc.dart';
import 'package:ilearn/presentation/bloc/flashcard/flashcard_state.dart';
import 'package:ilearn/presentation/screens/flashcard/widgets/flashcard_completed_view.dart';
import 'package:ilearn/presentation/screens/flashcard/widgets/flashcard_start_view.dart';
import 'package:ilearn/presentation/screens/flashcard/widgets/flashcard_study_view.dart';

/// Màn hình học flashcard - Clean Architecture & Senior Level
///
/// Features:
/// - Load flashcards from API
/// - Start study session
/// - Flip cards to see answer
/// - Rate difficulty (Wrong, Hard, Good, Easy)
/// - Track progress and accuracy
/// - Show completion results
///
/// Architecture:
/// - Separated widgets for each view state
/// - BLoC pattern for state management
/// - Clean separation of concerns
/// - Reusable components
class FlashcardStudyScreen extends StatelessWidget {
  final String lessonId;

  const FlashcardStudyScreen({super.key, required this.lessonId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocConsumer<FlashcardBloc, FlashcardState>(
        listener: _handleStateChanges,
        builder: (context, state) => _buildContent(context, state),
      ),
    );
  }

  /// Handle side effects from state changes
  void _handleStateChanges(BuildContext context, FlashcardState state) {
    if (state is FlashcardError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  state.message,
                  style: const TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.red.shade600,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  /// Build content based on current state
  Widget _buildContent(BuildContext context, FlashcardState state) {
    if (state is FlashcardInitial || state is FlashcardLoading) {
      return _buildLoadingView();
    } else if (state is FlashcardLoaded) {
      return FlashcardStartView(state: state, lessonId: lessonId);
    } else if (state is FlashcardStudying) {
      return FlashcardStudyView(state: state);
    } else if (state is FlashcardCompleted) {
      return FlashcardCompletedView(state: state, lessonId: lessonId);
    } else if (state is FlashcardError) {
      return _buildErrorView(context, state);
    }
    return _buildLoadingView();
  }

  /// Build loading view with elegant spinner
  Widget _buildLoadingView() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withOpacity(0.05),
            AppColors.primaryLight.withOpacity(0.02),
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Đang tải flashcards...',
              style: TextStyle(
                fontSize: 17,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
                height: 1.4,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build error view with retry option
  Widget _buildErrorView(BuildContext context, FlashcardError state) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.red.withOpacity(0.05), Colors.red.withOpacity(0.02)],
        ),
      ),
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red.shade400,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Oops! Có lỗi xảy ra',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  state.message,
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Quay lại'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
