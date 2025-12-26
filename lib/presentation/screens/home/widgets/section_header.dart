import 'package:flutter/material.dart';
import 'package:ilearn/core/theme/app_colors.dart';
import 'package:ilearn/core/theme/app_text_styles.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;

  const SectionHeader({super.key, required this.title, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.h5),
        if (onSeeAll != null)
          TextButton(
            onPressed: onSeeAll,
            child: Text(
              'Xem tất cả',
              style: TextStyle(color: AppColors.primary),
            ),
          ),
      ],
    );
  }
}
