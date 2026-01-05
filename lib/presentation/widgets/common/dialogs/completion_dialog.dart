import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../buttons/primary_button.dart';
import '../buttons/secondary_button.dart';

class CompletionDialog extends StatelessWidget {
  final String title;
  final String message;
  final int? xpEarned;
  final int? heartsEarned;
  final bool showContinueButton;
  final VoidCallback? onContinue;
  final VoidCallback? onReview;

  const CompletionDialog({
    Key? key,
    required this.title,
    required this.message,
    this.xpEarned,
    this.heartsEarned,
    this.showContinueButton = true,
    this.onContinue,
    this.onReview,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Success Icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary,
                    AppColors.primary.withOpacity(0.7),
                  ],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Icon(Icons.star, color: Colors.white, size: 48),
            ),
            const SizedBox(height: 24),

            // Title
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            // Message
            Text(
              message,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Rewards
            if (xpEarned != null || heartsEarned != null)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (xpEarned != null) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.bolt,
                              color: Colors.amber,
                              size: 20,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '+$xpEarned XP',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    if (xpEarned != null && heartsEarned != null)
                      const SizedBox(width: 16),
                    if (heartsEarned != null) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 20,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '+$heartsEarned',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            const SizedBox(height: 24),

            // Buttons
            if (showContinueButton)
              PrimaryButton(
                text: 'Continue',
                onPressed: () {
                  Navigator.of(context).pop();
                  onContinue?.call();
                },
              ),
            if (onReview != null) ...[
              const SizedBox(height: 12),
              SecondaryButton(
                text: 'Review',
                onPressed: () {
                  Navigator.of(context).pop();
                  onReview?.call();
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  static void show(
    BuildContext context, {
    required String title,
    required String message,
    int? xpEarned,
    int? heartsEarned,
    bool showContinueButton = true,
    VoidCallback? onContinue,
    VoidCallback? onReview,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CompletionDialog(
        title: title,
        message: message,
        xpEarned: xpEarned,
        heartsEarned: heartsEarned,
        showContinueButton: showContinueButton,
        onContinue: onContinue,
        onReview: onReview,
      ),
    );
  }
}
