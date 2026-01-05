import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class CompletionBadge extends StatelessWidget {
  final bool isCompleted;
  final double size;
  final Color? completedColor;
  final Color? incompleteColor;
  final bool showAnimation;

  const CompletionBadge({
    Key? key,
    required this.isCompleted,
    this.size = 40,
    this.completedColor,
    this.incompleteColor,
    this.showAnimation = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: showAnimation
          ? const Duration(milliseconds: 300)
          : Duration.zero,
      curve: Curves.easeInOut,
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: isCompleted
            ? LinearGradient(
                colors: [
                  completedColor ?? AppColors.primary,
                  (completedColor ?? AppColors.primary).withOpacity(0.7),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: !isCompleted
            ? (incompleteColor ?? Colors.grey.withOpacity(0.2))
            : null,
        shape: BoxShape.circle,
        boxShadow: isCompleted
            ? [
                BoxShadow(
                  color: (completedColor ?? AppColors.primary).withOpacity(0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : [],
      ),
      child: Center(
        child: Icon(
          isCompleted ? Icons.check : Icons.check,
          color: isCompleted ? Colors.white : Colors.grey.withOpacity(0.5),
          size: size * 0.6,
        ),
      ),
    );
  }
}
