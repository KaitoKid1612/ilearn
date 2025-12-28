import 'package:equatable/equatable.dart';
import 'package:ilearn/data/models/dashboard_model.dart';
import 'package:ilearn/data/models/roadmap_model.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {
  const DashboardInitial();
}

class DashboardLoading extends DashboardState {
  const DashboardLoading();
}

class DashboardLoaded extends DashboardState {
  final DashboardDataModel dashboard;
  final RoadmapDataModel? roadmap;

  const DashboardLoaded({required this.dashboard, this.roadmap});

  @override
  List<Object?> get props => [dashboard, roadmap];

  DashboardLoaded copyWith({
    DashboardDataModel? dashboard,
    RoadmapDataModel? roadmap,
  }) {
    return DashboardLoaded(
      dashboard: dashboard ?? this.dashboard,
      roadmap: roadmap ?? this.roadmap,
    );
  }
}

class DashboardError extends DashboardState {
  final String message;

  const DashboardError(this.message);

  @override
  List<Object?> get props => [message];
}

class RoadmapLoading extends DashboardState {
  final DashboardDataModel dashboard;

  const RoadmapLoading(this.dashboard);

  @override
  List<Object?> get props => [dashboard];
}

class RoadmapError extends DashboardState {
  final DashboardDataModel dashboard;
  final String message;

  const RoadmapError({required this.dashboard, required this.message});

  @override
  List<Object?> get props => [dashboard, message];
}
