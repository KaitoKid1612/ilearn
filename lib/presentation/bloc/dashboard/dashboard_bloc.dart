import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilearn/domain/usecases/get_dashboard_usecase.dart';
import 'package:ilearn/domain/usecases/get_textbook_roadmap_usecase.dart';
import 'package:ilearn/presentation/bloc/dashboard/dashboard_event.dart';
import 'package:ilearn/presentation/bloc/dashboard/dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetDashboardUseCase _getDashboardUseCase;
  final GetTextbookRoadmapUseCase _getTextbookRoadmapUseCase;

  DashboardBloc({
    required GetDashboardUseCase getDashboardUseCase,
    required GetTextbookRoadmapUseCase getTextbookRoadmapUseCase,
  }) : _getDashboardUseCase = getDashboardUseCase,
       _getTextbookRoadmapUseCase = getTextbookRoadmapUseCase,
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

      // Auto-load roadmap if there's a current textbook
      if (dashboard.currentTextbook != null) {
        add(LoadTextbookRoadmapEvent(dashboard.currentTextbook!.id));
      }
    });
  }

  Future<void> _onLoadTextbookRoadmap(
    LoadTextbookRoadmapEvent event,
    Emitter<DashboardState> emit,
  ) async {
    if (state is DashboardLoaded) {
      final currentState = state as DashboardLoaded;
      emit(RoadmapLoading(currentState.dashboard));

      final result = await _getTextbookRoadmapUseCase(event.textbookId);

      result.fold(
        (failure) => emit(
          RoadmapError(
            dashboard: currentState.dashboard,
            message: failure.message,
          ),
        ),
        (roadmap) => emit(
          DashboardLoaded(dashboard: currentState.dashboard, roadmap: roadmap),
        ),
      );
    }
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

        // Auto-load roadmap if there's a current textbook
        if (dashboard.currentTextbook != null) {
          add(LoadTextbookRoadmapEvent(dashboard.currentTextbook!.id));
        }
      },
    );
  }
}
