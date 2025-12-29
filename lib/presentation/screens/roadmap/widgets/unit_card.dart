import 'package:flutter/material.dart';
import 'package:ilearn/core/theme/app_colors.dart';
import 'package:ilearn/data/models/roadmap_model.dart';
import 'package:ilearn/presentation/screens/roadmap/widgets/lesson_node.dart';

class UnitCard extends StatefulWidget {
  final UnitModel unit;
  final Function(LessonModel) onLessonTap;

  const UnitCard({super.key, required this.unit, required this.onLessonTap});

  @override
  State<UnitCard> createState() => _UnitCardState();
}

class _UnitCardState extends State<UnitCard> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Unit Header
        Material(
          color: widget.unit.isLocked ? AppColors.greyLight : Colors.white,
          borderRadius: BorderRadius.circular(16),
          elevation: widget.unit.isLocked ? 0 : 2,
          shadowColor: Colors.black.withOpacity(0.1),
          child: InkWell(
            onTap: widget.unit.isLocked
                ? null
                : () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: widget.unit.isLocked
                    ? Border.all(color: AppColors.border, width: 1)
                    : null,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Unit number
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: widget.unit.isLocked
                              ? AppColors.grey.withOpacity(0.3)
                              : AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: widget.unit.isLocked
                              ? const Icon(
                                  Icons.lock,
                                  color: AppColors.textSecondary,
                                  size: 20,
                                )
                              : Text(
                                  '${widget.unit.order}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Title
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.unit.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: widget.unit.isLocked
                                    ? AppColors.textSecondary
                                    : AppColors.textPrimary,
                              ),
                            ),
                            if (widget.unit.isLocked) ...[
                              const SizedBox(height: 4),
                              Text(
                                widget.unit.unlockRequirement ?? 'Đã khóa',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),

                      // Expand icon
                      if (!widget.unit.isLocked)
                        Icon(
                          _isExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: AppColors.textSecondary,
                        ),
                    ],
                  ),

                  // Progress
                  if (!widget.unit.isLocked) ...[
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: widget.unit.progress.percentage / 100,
                              backgroundColor: AppColors.greyLight,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                AppColors.secondary,
                              ),
                              minHeight: 6,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '${widget.unit.progress.completed}/${widget.unit.progress.total}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),

        // Lessons (Duolingo-style nodes)
        if (_isExpanded &&
            !widget.unit.isLocked &&
            widget.unit.lessons.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              children: [
                for (int i = 0; i < widget.unit.lessons.length; i++) ...[
                  LessonNode(
                    lesson: widget.unit.lessons[i],
                    onTap: widget.unit.lessons[i].isLocked
                        ? null
                        : () => widget.onLessonTap(widget.unit.lessons[i]),
                    alignment: i % 2 == 0
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                  ),
                  if (i < widget.unit.lessons.length - 1)
                    _buildPath(i % 2 == 0),
                ],
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildPath(bool toRight) {
    return CustomPaint(
      size: const Size(double.infinity, 30),
      painter: _PathPainter(toRight: toRight),
    );
  }
}

class _PathPainter extends CustomPainter {
  final bool toRight;

  _PathPainter({required this.toRight});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.greyLight
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final path = Path();

    if (toRight) {
      // Curve from left to right
      path.moveTo(size.width * 0.2, 0);
      path.quadraticBezierTo(
        size.width * 0.5,
        size.height / 2,
        size.width * 0.8,
        size.height,
      );
    } else {
      // Curve from right to left
      path.moveTo(size.width * 0.8, 0);
      path.quadraticBezierTo(
        size.width * 0.5,
        size.height / 2,
        size.width * 0.2,
        size.height,
      );
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
