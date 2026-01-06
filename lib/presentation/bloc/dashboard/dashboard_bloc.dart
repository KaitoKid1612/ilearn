import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilearn/domain/usecases/get_dashboard_usecase.dart';
import 'package:ilearn/presentation/bloc/dashboard/dashboard_event.dart';
import 'package:ilearn/presentation/bloc/dashboard/dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetDashboardUseCase _getDashboardUseCase;

  DashboardBloc({required GetDashboardUseCase getDashboardUseCase})
    : _getDashboardUseCase = getDashboardUseCase,
      super(const DashboardInitial()) {
    on<LoadDashboardEvent>(_onLoadDashboard);
    on<LoadTextbookRoadmapEvent>(_onLoadTextbookRoadmap);
    on<RefreshDashboardEvent>(_onRefreshDashboard);
  }

  Future<void> _onLoadDashboard(
    LoadDashboardEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(const DashboardLoading());

    final result = await _getDashboardUseCase();

    result.fold((failure) => emit(DashboardError(failure.message)), (
      dashboard,
    ) {
      emit(DashboardLoaded(dashboard: dashboard));
    });
  }

  Future<void> _onLoadTextbookRoadmap(
    LoadTextbookRoadmapEvent event,
    Emitter<DashboardState> emit,
  ) async {
    // Roadmap is now part of dashboard response, no need for separate call
    // This method can be kept for future use or removed
  }

  Future<void> _onRefreshDashboard(
    RefreshDashboardEvent event,
    Emitter<DashboardState> emit,
  ) async {
    // Keep the current state while refreshing
    final result = await _getDashboardUseCase();

    result.fold(
      (failure) {
        if (state is DashboardLoaded) {
          // Keep the old data if refresh fails
          return;
        } else {
          emit(DashboardError(failure.message));
        }
      },
      (dashboard) {
        emit(DashboardLoaded(dashboard: dashboard));
      },
    );
  }
}
