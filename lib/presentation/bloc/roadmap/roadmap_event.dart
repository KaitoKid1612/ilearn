import 'package:equatable/equatable.dart';

abstract class RoadmapEvent extends Equatable {
  const RoadmapEvent();

  @override
  List<Object?> get props => [];
}

class LoadRoadmap extends RoadmapEvent {
  final String textbookId;

  const LoadRoadmap(this.textbookId);

  @override
  List<Object?> get props => [textbookId];
}
