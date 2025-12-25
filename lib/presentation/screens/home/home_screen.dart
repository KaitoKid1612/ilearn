import 'package:flutter/material.dart';
import 'package:ilearn/core/theme/app_colors.dart';
import 'package:ilearn/core/theme/app_text_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('iLearn'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Chào mừng trở lại! 👋', style: AppTextStyles.h4),
              const SizedBox(height: 8),
              Text(
                'Bạn muốn học gì hôm nay?',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 24),

              // Learning Categories Grid
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children: [
                    _buildCategoryCard(
                      context,
                      icon: Icons.book,
                      title: 'Bài học',
                      color: AppColors.primary,
                      onTap: () {},
                    ),
                    _buildCategoryCard(
                      context,
                      icon: Icons.style,
                      title: 'Flashcard',
                      color: AppColors.secondary,
                      onTap: () {},
                    ),
                    _buildCategoryCard(
                      context,
                      icon: Icons.quiz,
                      title: 'Trắc nghiệm',
                      color: AppColors.accent,
                      onTap: () {},
                    ),
                    _buildCategoryCard(
                      context,
                      icon: Icons.games,
                      title: 'Trò chơi',
                      color: AppColors.info,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.auto_awesome),
        label: const Text('Tạo với AI'),
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 32, color: color),
              ),
              const SizedBox(height: 12),
              Text(title, style: AppTextStyles.h6, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
