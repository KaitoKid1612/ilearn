import 'package:equatable/equatable.dart';

class GrammarItem extends Equatable {
  final String id;
  final String title;
  final String pattern;
  final String meaning;
  final bool isLearned;

  const GrammarItem({
    required this.id,
    required this.title,
    required this.pattern,
    required this.meaning,
    required this.isLearned,
  });

  @override
  List<Object?> get props => [id, title, pattern, meaning, isLearned];
}

class GrammarProgress extends Equatable {
  final int total;
  final int learned;
  final double percentage;

  const GrammarProgress({
    required this.total,
    required this.learned,
    required this.percentage,
  });

  @override
  List<Object?> get props => [total, learned, percentage];
}

class GrammarDetail extends Equatable {
  final String id;
  final String title;
  final String pattern;
  final String meaning;
  final String explanation;
  final String usage;
  final String formality;
  final List<GrammarExample> examples;
  final List<RelatedGrammar> relatedGrammar;
  final bool isLearned;

  const GrammarDetail({
    required this.id,
    required this.title,
    required this.pattern,
    required this.meaning,
    required this.explanation,
    required this.usage,
    required this.formality,
    required this.examples,
    required this.relatedGrammar,
    required this.isLearned,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    pattern,
    meaning,
    explanation,
    usage,
    formality,
    examples,
    relatedGrammar,
    isLearned,
  ];
}

class GrammarExample extends Equatable {
  final String sentence;
  final String meaning;
  final String breakdown;
  final String? audio;

  const GrammarExample({
    required this.sentence,
    required this.meaning,
    required this.breakdown,
    this.audio,
  });

  @override
  List<Object?> get props => [sentence, meaning, breakdown, audio];
}

class RelatedGrammar extends Equatable {
  final String id;
  final String title;
  final String pattern;
  final String meaning;

  const RelatedGrammar({
    required this.id,
    required this.title,
    required this.pattern,
    required this.meaning,
  });

  @override
  List<Object?> get props => [id, title, pattern, meaning];
}
