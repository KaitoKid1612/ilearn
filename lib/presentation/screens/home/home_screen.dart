import 'package:flutter/material.dart';
import 'package:ilearn/core/theme/app_colors.dart';
import 'package:ilearn/core/theme/app_text_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  // Mock data - N5 Japanese Course
  final Map<String, dynamic> _courseInfo = {
    'title': 'Tiếng Nhật N5',
    'subtitle': 'Cấp độ sơ cấp',
    'progress': 0.35,
    'totalLessons': 15,
    'completedLessons': 5,
  };

  // Lessons in learning path
  final List<Map<String, dynamic>> _lessons = [
    {
      'id': 1,
      'title': 'Bài 1: Chào hỏi',
      'subtitle': 'Hiragana & Katakana cơ bản',
      'type': 'lesson',
      'isCompleted': true,
      'isUnlocked': true,
      'stars': 3,
    },
    {
      'id': 2,
      'title': 'Luyện tập 1',
      'subtitle': 'Ôn tập Bài 1',
      'type': 'practice',
      'isCompleted': true,
      'isUnlocked': true,
      'stars': 3,
    },
    {
      'id': 3,
      'title': 'Bài 2: Giới thiệu bản thân',
      'subtitle': 'Từ vựng & Ngữ pháp',
      'type': 'lesson',
      'isCompleted': true,
      'isUnlocked': true,
      'stars': 2,
    },
    {
      'id': 4,
      'title': 'Trắc nghiệm 1',
      'subtitle': 'Kiểm tra kiến thức',
      'type': 'test',
      'isCompleted': true,
      'isUnlocked': true,
      'stars': 3,
    },
    {
      'id': 5,
      'title': 'Bài 3: Số đếm',
      'subtitle': 'Đếm số từ 1-100',
      'type': 'lesson',
      'isCompleted': true,
      'isUnlocked': true,
      'stars': 1,
    },
    {
      'id': 6,
      'title': 'Bài 4: Thời gian',
      'subtitle': 'Giờ, phút, ngày, tháng',
      'type': 'lesson',
      'isCompleted': false,
      'isUnlocked': true,
      'isCurrent': true,
      'stars': 0,
    },
    {
      'id': 7,
      'title': 'Luyện tập 2',
      'subtitle': 'Ôn tập Bài 3-4',
      'type': 'practice',
      'isCompleted': false,
      'isUnlocked': false,
      'stars': 0,
    },
    {
      'id': 8,
      'title': 'Bài 5: Mua sắm',
      'subtitle': 'Từ vựng cửa hàng',
      'type': 'lesson',
      'isCompleted': false,
      'isUnlocked': false,
      'stars': 0,
    },
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // App Bar với course info
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.primary,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primary,
                      AppColors.primary.withOpacity(0.8),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.local_fire_department,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    '7',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.diamond,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    '1250',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(
                                Icons.notifications_outlined,
                                color: Colors.white,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        const Spacer(),
                        Text(
                          _courseInfo['title'],
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _courseInfo['subtitle'],
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: LinearProgressIndicator(
                                  value: _courseInfo['progress'],
                                  minHeight: 8,
                                  backgroundColor: Colors.white.withOpacity(
                                    0.3,
                                  ),
                                  valueColor: const AlwaysStoppedAnimation(
                                    Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              '${_courseInfo['completedLessons']}/${_courseInfo['totalLessons']}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Learning Path
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final lesson = _lessons[index];
                final isLast = index == _lessons.length - 1;

                return _buildLessonNode(
                  lesson: lesson,
                  index: index,
                  showConnector: !isLast,
                );
              }, childCount: _lessons.length),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildLessonNode({
    required Map<String, dynamic> lesson,
    required int index,
    required bool showConnector,
  }) {
    final isCompleted = lesson['isCompleted'] as bool;
    final isUnlocked = lesson['isUnlocked'] as bool;
    final isCurrent = lesson['isCurrent'] ?? false;
    final type = lesson['type'] as String;

    Color getColor() {
      if (type == 'lesson') return const Color(0xFF58CC02);
      if (type == 'practice') return const Color(0xFF1CB0F6);
      if (type == 'test') return const Color(0xFFFF9600);
      return Colors.grey;
    }

    IconData getIcon() {
      if (type == 'lesson') return Icons.book_rounded;
      if (type == 'practice') return Icons.fitness_center_rounded;
      if (type == 'test') return Icons.quiz_rounded;
      return Icons.lock;
    }

    final color = getColor();
    final isEven = index.isEven;

    return Column(
      children: [
        Row(
          children: [
            if (!isEven) const Spacer(),

            // Lesson Node
            GestureDetector(
              onTap: isUnlocked
                  ? () {
                      _showLessonDetail(lesson);
                    }
                  : null,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: MediaQuery.of(context).size.width * 0.75,
                child: Card(
                  elevation: isCurrent ? 8 : (isCompleted ? 2 : 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: isCurrent
                          ? color
                          : (isCompleted
                                ? color.withOpacity(0.3)
                                : Colors.grey.shade300),
                      width: isCurrent ? 3 : 2,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: isCurrent
                          ? LinearGradient(
                              colors: [color.withOpacity(0.1), Colors.white],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                          : null,
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        // Icon
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            gradient: isUnlocked
                                ? LinearGradient(
                                    colors: [color, color.withOpacity(0.7)],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  )
                                : null,
                            color: isUnlocked ? null : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: isCompleted || isCurrent
                                ? [
                                    BoxShadow(
                                      color: color.withOpacity(0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ]
                                : null,
                          ),
                          child: Icon(
                            isUnlocked ? getIcon() : Icons.lock,
                            color: isUnlocked ? Colors.white : Colors.grey,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lesson['title'],
                                style: AppTextStyles.h6.copyWith(
                                  color: isUnlocked
                                      ? Colors.black87
                                      : Colors.grey,
                                  fontWeight: isCurrent
                                      ? FontWeight.bold
                                      : FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                lesson['subtitle'],
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: isUnlocked
                                      ? AppColors.textSecondary
                                      : Colors.grey.shade400,
                                ),
                              ),
                              if (isCompleted) ...[
                                const SizedBox(height: 8),
                                Row(
                                  children: List.generate(3, (i) {
                                    final stars = lesson['stars'] as int;
                                    return Icon(
                                      Icons.star,
                                      size: 16,
                                      color: i < stars
                                          ? Colors.amber
                                          : Colors.grey.shade300,
                                    );
                                  }),
                                ),
                              ],
                              if (isCurrent) ...[
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: color,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: const Text(
                                    'BẮT ĐẦU',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        if (isCompleted)
                          const Icon(
                            Icons.check_circle,
                            color: Color(0xFF58CC02),
                            size: 28,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            if (isEven) const Spacer(),
          ],
        ),

        // Connector
        if (showConnector)
          Container(
            height: 30,
            width: 3,
            margin: EdgeInsets.only(
              left: isEven ? 90 : MediaQuery.of(context).size.width - 110,
            ),
            decoration: BoxDecoration(
              color: isCompleted
                  ? getColor().withOpacity(0.3)
                  : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
      ],
    );
  }

  void _showLessonDetail(Map<String, dynamic> lesson) {
    final type = lesson['type'] as String;
    final color = type == 'lesson'
        ? const Color(0xFF58CC02)
        : type == 'practice'
        ? const Color(0xFF1CB0F6)
        : const Color(0xFFFF9600);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(lesson['title'], style: AppTextStyles.h4),
                    const SizedBox(height: 8),
                    Text(
                      lesson['subtitle'],
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.school,
                              size: 80,
                              color: color.withOpacity(0.5),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Nội dung bài học',
                              style: AppTextStyles.h6.copyWith(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          // Navigate to lesson content
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: color,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          lesson['isCompleted'] ? 'ÔN TẬP' : 'BẮT ĐẦU',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF58CC02),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Học'),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events_rounded),
            label: 'Xếp hạng',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_rounded),
            label: 'Bạn bè',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Hồ sơ',
          ),
        ],
      ),
    );
  }
}
