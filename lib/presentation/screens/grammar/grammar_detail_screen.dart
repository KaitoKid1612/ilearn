import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilearn/core/theme/app_colors.dart';
import 'package:ilearn/presentation/bloc/grammar/grammar_bloc.dart';
import 'package:ilearn/presentation/bloc/grammar/grammar_event.dart';
import 'package:ilearn/presentation/widgets/common/animations/fade_in_animation.dart';
import 'package:go_router/go_router.dart';

class GrammarDetailScreen extends StatefulWidget {
  final String lessonId;
  final String grammarId;
  final String lessonTitle;
  final String grammarTitle;

  const GrammarDetailScreen({
    Key? key,
    required this.lessonId,
    required this.grammarId,
    required this.lessonTitle,
    required this.grammarTitle,
  }) : super(key: key);

  @override
  State<GrammarDetailScreen> createState() => _GrammarDetailScreenState();
}

class _GrammarDetailScreenState extends State<GrammarDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GrammarBloc>().add(
      LoadGrammarDetail(widget.lessonId, widget.grammarId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          widget.grammarTitle,
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
      ),
      body: BlocConsumer<GrammarBloc, GrammarState>(
        listener: (context, state) {
          if (state is GrammarError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
          if (state is GrammarMarkedAsLearned) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  '${state.response.message} (+${state.response.xpEarned} XP)',
                ),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is GrammarDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is GrammarDetailLoaded) {
            final grammar = state.grammarDetail;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Pattern & Meaning Section
                  FadeInAnimation(child: _buildPatternSection(grammar)),

                  // Explanation Section
                  FadeInAnimation(
                    delay: const Duration(milliseconds: 100),
                    child: _buildExplanationSection(grammar),
                  ),

                  // Examples Section
                  FadeInAnimation(
                    delay: const Duration(milliseconds: 200),
                    child: _buildExamplesSection(grammar),
                  ),

                  // Related Grammar Section
                  if (grammar.relatedGrammar != null &&
                      grammar.relatedGrammar!.isNotEmpty)
                    FadeInAnimation(
                      delay: const Duration(milliseconds: 300),
                      child: _buildRelatedGrammarSection(grammar),
                    ),

                  const SizedBox(height: 80),
                ],
              ),
            );
          }

          return const Center(child: Text('No grammar detail available'));
        },
      ),
      bottomNavigationBar: BlocBuilder<GrammarBloc, GrammarState>(
        builder: (context, state) {
          if (state is GrammarDetailLoaded) {
            return _buildBottomActions(context, state.grammarDetail);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildPatternSection(grammar) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (grammar.formality != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    grammar.formality!.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              const Spacer(),
              if (grammar.isLearned)
                const Icon(Icons.check_circle, color: Colors.white),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Pattern:',
            style: TextStyle(fontSize: 14, color: Colors.white70),
          ),
          const SizedBox(height: 8),
          Text(
            grammar.pattern,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              grammar.meaning,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExplanationSection(grammar) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.info_outline, color: AppColors.primary),
              SizedBox(width: 8),
              Text(
                'Explanation',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            grammar.explanation ?? 'No explanation available',
            style: const TextStyle(fontSize: 15, height: 1.5),
          ),
          if (grammar.usage != null) ...<Widget>[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.lightbulb_outline,
                    color: Colors.blue,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Usage: ${grammar.usage}',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildExamplesSection(grammar) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            child: Text(
              '📝 Examples',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ...grammar.examples.map((example) => _buildExampleCard(example)),
        ],
      ),
    );
  }

  Widget _buildExampleCard(example) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    example.sentence,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (example.audio != null)
                  IconButton(
                    icon: const Icon(Icons.volume_up, color: AppColors.primary),
                    onPressed: () {
                      // TODO: Play audio
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Audio playback coming soon!'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              example.meaning,
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            if (example.breakdown != null) ...<Widget>[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  example.breakdown!,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildRelatedGrammarSection(grammar) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            child: Text(
              '🔗 Related Grammar',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ...grammar.relatedGrammar.map(
            (related) => _buildRelatedGrammarCard(related),
          ),
        ],
      ),
    );
  }

  Widget _buildRelatedGrammarCard(related) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const Icon(Icons.link, color: AppColors.primary),
        title: Text(
          related.title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              related.pattern,
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
            Text(related.meaning),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          context.pushNamed(
            'grammar-detail',
            pathParameters: {
              'lessonId': widget.lessonId,
              'grammarId': related.id,
            },
            extra: {
              'lessonTitle': widget.lessonTitle,
              'grammarTitle': related.title,
            },
          );
        },
      ),
    );
  }

  Widget _buildBottomActions(BuildContext context, grammar) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: grammar.isLearned
                    ? null
                    : () {
                        context.read<GrammarBloc>().add(
                          MarkGrammarAsLearned(
                            widget.lessonId,
                            widget.grammarId,
                          ),
                        );
                      },
                icon: Icon(
                  grammar.isLearned
                      ? Icons.check_circle
                      : Icons.check_circle_outline,
                ),
                label: Text(
                  grammar.isLearned ? 'Đã học rồi' : 'Đánh dấu đã học',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: grammar.isLearned
                      ? Colors.grey.shade300
                      : Colors.green,
                  foregroundColor: grammar.isLearned
                      ? Colors.grey.shade600
                      : Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  disabledBackgroundColor: Colors.grey.shade300,
                  disabledForegroundColor: Colors.grey.shade600,
                ),
              ),
            ),
            if (!grammar.isLearned) const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  context.pushNamed(
                    'grammar-practice',
                    pathParameters: {
                      'grammarId': widget.grammarId,
                      'lessonId': widget.lessonId,
                    },
                    extra: {'grammarTitle': widget.grammarTitle},
                  );
                },
                icon: const Icon(Icons.edit),
                label: const Text('Practice'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
