import 'package:equatable/equatable.dart';
import 'package:ilearn/data/models/roadmap_model.dart';

abstract class RoadmapState extends Equatable {
  const RoadmapState();

  @override
  List<Object?> get props => [];
}

class RoadmapInitial extends RoadmapState {
  const RoadmapInitial();
}

class RoadmapLoading extends RoadmapState {
  const RoadmapLoading();
}

class RoadmapLoaded extends RoadmapState {
  final RoadmapDataModel roadmap;

  const RoadmapLoaded(this.roadmap);

  @override
  List<Object?> get props => [roadmap];
}

class RoadmapError extends RoadmapState {
  final String message;

  const RoadmapError(this.message);

  @override
  List<Object?> get props => [message];
}
