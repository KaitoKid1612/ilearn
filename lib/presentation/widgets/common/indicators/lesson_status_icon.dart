import 'package:flutter/material.dart';
import '../../../../core/enums/lesson_status.dart';

class LessonStatusIcon extends StatelessWidget {
  final LessonStatus status;
  final double size;

  const LessonStatusIcon({super.key, required this.status, this.size = 48});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _getBackgroundColor(),
        boxShadow: status != LessonStatus.locked
            ? [
                BoxShadow(
                  color: _getBackgroundColor().withOpacity(0.3),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ]
            : null,
      ),
      child: Icon(_getIcon(), color: _getIconColor(), size: size * 0.5),
    );
  }

  IconData _getIcon() {
    switch (status) {
      case LessonStatus.locked:
        return Icons.lock;
      case LessonStatus.unlocked:
        return Icons.play_arrow;
      case LessonStatus.inProgress:
        return Icons.auto_awesome;
      case LessonStatus.completed:
        return Icons.check_circle;
    }
  }

  Color _getBackgroundColor() {
    switch (status) {
      case LessonStatus.locked:
        return Colors.grey[300]!;
      case LessonStatus.unlocked:
        return const Color(0xFF2196F3); // Blue
      case LessonStatus.inProgress:
        return const Color(0xFFFFA726); // Orange
      case LessonStatus.completed:
        return const Color(0xFF66BB6A); // Green
    }
  }

  Color _getIconColor() {
    return status == LessonStatus.locked ? Colors.grey[600]! : Colors.white;
  }
}

// Helper extension to convert from model
extension LessonStatusExtension on bool {
  LessonStatus toLessonStatus({
    required bool isLocked,
    required bool isCompleted,
    required bool isCurrent,
  }) {
    if (isLocked) return LessonStatus.locked;
    if (isCompleted) return LessonStatus.completed;
    if (isCurrent) return LessonStatus.inProgress;
    return LessonStatus.unlocked;
  }
}
