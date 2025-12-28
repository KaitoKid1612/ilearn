import 'package:equatable/equatable.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

class LoadDashboardEvent extends DashboardEvent {
  const LoadDashboardEvent();
}

class LoadTextbookRoadmapEvent extends DashboardEvent {
  final String textbookId;

  const LoadTextbookRoadmapEvent(this.textbookId);

  @override
  List<Object?> get props => [textbookId];
}

class RefreshDashboardEvent extends DashboardEvent {
  const RefreshDashboardEvent();
}
