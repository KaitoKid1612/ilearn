import 'package:flutter/material.dart';

class LockIndicator extends StatelessWidget {
  final bool isLocked;
  final double size;
  final Color? lockedColor;
  final Color? unlockedColor;
  final String? lockedMessage;

  const LockIndicator({
    Key? key,
    required this.isLocked,
    this.size = 32,
    this.lockedColor,
    this.unlockedColor,
    this.lockedMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isLocked) {
      return const SizedBox.shrink();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: (lockedColor ?? Colors.grey).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.lock,
            color: lockedColor ?? Colors.grey,
            size: size * 0.6,
          ),
        ),
        if (lockedMessage != null) ...[
          const SizedBox(height: 8),
          Text(
            lockedMessage!,
            style: TextStyle(
              fontSize: 12,
              color: lockedColor ?? Colors.grey,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}
