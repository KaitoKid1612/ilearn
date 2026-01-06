import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/lesson_vocabulary_model.dart';
import '../../bloc/vocabulary/vocabulary_bloc.dart';
import '../../widgets/common/animations/fade_in_animation.dart';

class VocabularyListScreen extends StatefulWidget {
  final String lessonId;
  final String lessonTitle;

  const VocabularyListScreen({
    Key? key,
    required this.lessonId,
    required this.lessonTitle,
  }) : super(key: key);

  @override
  State<VocabularyListScreen> createState() => _VocabularyListScreenState();
}

class _VocabularyListScreenState extends State<VocabularyListScreen> {
  bool _isMultiSelectMode = false;
  final Set<String> _selectedVocabIds = {};

  @override
  void initState() {
    super.initState();
    context.read<VocabularyBloc>().add(LoadVocabularyLesson(widget.lessonId));
  }

  void _toggleMultiSelectMode() {
    setState(() {
      _isMultiSelectMode = !_isMultiSelectMode;
      if (!_isMultiSelectMode) {
        _selectedVocabIds.clear();
      }
    });
  }

  void _toggleSelection(String vocabId) {
    setState(() {
      if (_selectedVocabIds.contains(vocabId)) {
        _selectedVocabIds.remove(vocabId);
      } else {
        _selectedVocabIds.add(vocabId);
      }
    });
  }

  void _batchMarkAsLearned() {
    if (_selectedVocabIds.isEmpty) return;

    context.read<VocabularyBloc>().add(
      BatchMarkVocabulariesLearned(
        lessonId: widget.lessonId,
        vocabularyIds: _selectedVocabIds.toList(),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đã đánh dấu ${_selectedVocabIds.length} từ là đã học!'),
        backgroundColor: AppColors.success,
        duration: const Duration(seconds: 2),
      ),
    );

    setState(() {
      _selectedVocabIds.clear();
      _isMultiSelectMode = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          _isMultiSelectMode
              ? '${_selectedVocabIds.length} đã chọn'
              : widget.lessonTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primary, AppColors.primaryDark],
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isMultiSelectMode ? Icons.close : Icons.checklist,
              color: Colors.white,
            ),
            onPressed: _toggleMultiSelectMode,
            tooltip: _isMultiSelectMode ? 'Hủy chọn' : 'Chọn nhiều',
          ),
        ],
      ),
      body: BlocBuilder<VocabularyBloc, VocabularyState>(
        builder: (context, state) {
          if (state is VocabularyLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is VocabularyError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: AppColors.error),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      state.message,
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      context.read<VocabularyBloc>().add(
                        LoadVocabularyLesson(widget.lessonId),
                      );
                    },
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
                    child: const Text('Thử lại'),
                  ),
                ],
              ),
            );
          }

          if (state is VocabularyLoaded) {
            return _buildVocabularyList(state);
          }

          return const Center(child: Text('Unknown state'));
        },
      ),
      floatingActionButton: _isMultiSelectMode && _selectedVocabIds.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: _batchMarkAsLearned,
              icon: const Icon(Icons.check_circle),
              label: Text('Đánh dấu ${_selectedVocabIds.length} từ'),
              backgroundColor: AppColors.success,
              foregroundColor: Colors.white,
            )
          : null,
    );
  }

  Widget _buildVocabularyList(VocabularyLoaded state) {
    final vocabularies = state.lessonData.vocabularies;

    if (vocabularies.isEmpty) {
      return const Center(
        child: Text(
          'Chưa có từ vựng nào',
          style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: vocabularies.length,
      itemBuilder: (context, index) {
        final vocab = vocabularies[index];
        return FadeInAnimation(
          delay: Duration(milliseconds: index * 50),
          child: _buildVocabularyCard(vocab),
        );
      },
    );
  }

  Widget _buildVocabularyCard(VocabularyItemModel vocab) {
    final isSelected = _selectedVocabIds.contains(vocab.id);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: isSelected ? 4 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected
              ? AppColors.primary.withOpacity(0.5)
              : vocab.isLearned
              ? AppColors.success.withOpacity(0.3)
              : Colors.transparent,
          width: isSelected ? 3 : 2,
        ),
      ),
      child: InkWell(
        onTap: _isMultiSelectMode && !vocab.isLearned
            ? () => _toggleSelection(vocab.id)
            : null,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Checkbox in multi-select mode
                  if (_isMultiSelectMode && !vocab.isLearned) ...[
                    Checkbox(
                      value: isSelected,
                      onChanged: (_) => _toggleSelection(vocab.id),
                      activeColor: AppColors.primary,
                    ),
                    const SizedBox(width: 8),
                  ],
                  // Japanese word
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          vocab.word,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          vocab.reading,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Learned status indicator
                  if (vocab.isLearned)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.success.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.success.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 16,
                            color: AppColors.success,
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            'Đã học',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.success,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              // Meaning
              Text(
                vocab.meaning,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                ),
              ),
              if (vocab.example != null) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    vocab.example!,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 12),
              // Action buttons - hide in multi-select mode
              if (!_isMultiSelectMode)
                Row(
                  children: [
                    // Audio button
                    if (vocab.audio != null)
                      OutlinedButton.icon(
                        onPressed: () {
                          // TODO: Play audio
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Phát âm...')),
                          );
                        },
                        icon: const Icon(Icons.volume_up, size: 18),
                        label: const Text('Nghe'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          side: BorderSide(color: AppColors.primary),
                          foregroundColor: AppColors.primary,
                        ),
                      ),
                    if (vocab.audio != null) const SizedBox(width: 8),
                    // Mark as learned button
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: vocab.isLearned
                            ? null
                            : () => _markAsLearned(vocab.id),
                        icon: Icon(
                          vocab.isLearned ? Icons.check_circle : Icons.check,
                          size: 18,
                        ),
                        label: Text(
                          vocab.isLearned ? 'Đã học' : 'Đánh dấu đã học',
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          backgroundColor: vocab.isLearned
                              ? Colors.grey.shade300
                              : AppColors.success,
                          foregroundColor: vocab.isLearned
                              ? Colors.grey.shade600
                              : Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _markAsLearned(String vocabularyId) {
    context.read<VocabularyBloc>().add(
      MarkVocabularyLearned(
        lessonId: widget.lessonId,
        vocabularyId: vocabularyId,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Đã đánh dấu là đã học!'),
        backgroundColor: AppColors.success,
        duration: Duration(seconds: 2),
      ),
    );
  }
}
