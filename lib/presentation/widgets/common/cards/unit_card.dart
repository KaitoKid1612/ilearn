import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../progress/custom_progress_bar.dart';

class UnitCard extends StatefulWidget {
  final String unitId;
  final String title;
  final String? description;
  final int order;
  final bool isLocked;
  final bool isCompleted;
  final double progress;
  final int totalLessons;
  final int completedLessons;
  final Widget? child;
  final bool initiallyExpanded;
  final VoidCallback? onTap;

  const UnitCard({
    Key? key,
    required this.unitId,
    required this.title,
    this.description,
    required this.order,
    required this.isLocked,
    required this.isCompleted,
    required this.progress,
    required this.totalLessons,
    required this.completedLessons,
    this.child,
    this.initiallyExpanded = false,
    this.onTap,
  }) : super(key: key);

  @override
  State<UnitCard> createState() => _UnitCardState();
}

class _UnitCardState extends State<UnitCard> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          InkWell(
            onTap: widget.isLocked
                ? null
                : () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                    widget.onTap?.call();
                  },
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: widget.isLocked
                    ? LinearGradient(
                        colors: [Colors.grey.shade300, Colors.grey.shade400],
                      )
                    : widget.isCompleted
                    ? LinearGradient(
                        colors: [
                          AppColors.primary.withOpacity(0.8),
                          AppColors.primary,
                        ],
                      )
                    : LinearGradient(
                        colors: [
                          AppColors.primary.withOpacity(0.5),
                          AppColors.primary.withOpacity(0.7),
                        ],
                      ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Unit badge
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: widget.isLocked
                              ? const Icon(Icons.lock, color: Colors.grey)
                              : widget.isCompleted
                              ? const Icon(
                                  Icons.star,
                                  color: AppColors.primary,
                                  size: 28,
                                )
                              : Text(
                                  '${widget.order}',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${widget.completedLessons}/${widget.totalLessons} lessons completed',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (!widget.isLocked)
                        Icon(
                          _isExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: Colors.white,
                          size: 28,
                        ),
                    ],
                  ),
                  if (widget.description != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      widget.description!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.9),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  if (!widget.isLocked) ...[
                    const SizedBox(height: 16),
                    CustomProgressBar(
                      progress: widget.progress,
                      height: 8,
                      backgroundColor: Colors.white.withOpacity(0.3),
                      progressColor: Colors.white,
                      showPercentage: true,
                    ),
                  ],
                  if (widget.isLocked) ...[
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(
                          Icons.lock_outline,
                          size: 16,
                          color: Colors.white.withOpacity(0.9),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Complete previous unit to unlock',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white.withOpacity(0.9),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
          if (_isExpanded && widget.child != null && !widget.isLocked)
            Container(padding: const EdgeInsets.all(16), child: widget.child),
        ],
      ),
    );
  }
}
