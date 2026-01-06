import 'package:equatable/equatable.dart';
import 'package:ilearn/data/models/grammar_model.dart';

// Events
abstract class GrammarEvent extends Equatable {
  const GrammarEvent();

  @override
  List<Object?> get props => [];
}

class LoadGrammarList extends GrammarEvent {
  final String lessonId;

  const LoadGrammarList(this.lessonId);

  @override
  List<Object?> get props => [lessonId];
}

class LoadGrammarDetail extends GrammarEvent {
  final String lessonId;
  final String grammarId;

  const LoadGrammarDetail(this.lessonId, this.grammarId);

  @override
  List<Object?> get props => [lessonId, grammarId];
}

class MarkGrammarAsLearned extends GrammarEvent {
  final String lessonId;
  final String grammarId;

  const MarkGrammarAsLearned(this.lessonId, this.grammarId);

  @override
  List<Object?> get props => [lessonId, grammarId];
}

// States
abstract class GrammarState extends Equatable {
  const GrammarState();

  @override
  List<Object?> get props => [];
}

class GrammarInitial extends GrammarState {}

class GrammarListLoading extends GrammarState {}

class GrammarListLoaded extends GrammarState {
  final GrammarListDataModel grammarList;

  const GrammarListLoaded(this.grammarList);

  @override
  List<Object?> get props => [grammarList];
}

class GrammarDetailLoading extends GrammarState {}

class GrammarDetailLoaded extends GrammarState {
  final GrammarDetailModel grammarDetail;

  const GrammarDetailLoaded(this.grammarDetail);

  @override
  List<Object?> get props => [grammarDetail];
}

class GrammarMarkingAsLearned extends GrammarState {}

class GrammarMarkedAsLearned extends GrammarState {
  final MarkLearnedDataModel response;

  const GrammarMarkedAsLearned(this.response);

  @override
  List<Object?> get props => [response];
}

class GrammarError extends GrammarState {
  final String message;

  const GrammarError(this.message);

  @override
  List<Object?> get props => [message];
}
