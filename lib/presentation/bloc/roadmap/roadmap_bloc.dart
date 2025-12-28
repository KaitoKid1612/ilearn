import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilearn/data/repositories/learning_repository.dart';
import 'package:ilearn/presentation/bloc/roadmap/roadmap_event.dart';
import 'package:ilearn/presentation/bloc/roadmap/roadmap_state.dart';

class RoadmapBloc extends Bloc<RoadmapEvent, RoadmapState> {
  final LearningRepository _learningRepository;

  RoadmapBloc(this._learningRepository) : super(const RoadmapInitial()) {
    on<LoadRoadmap>(_onLoadRoadmap);
  }

  Future<void> _onLoadRoadmap(
    LoadRoadmap event,
    Emitter<RoadmapState> emit,
  ) async {
    print('📚 RoadmapBloc: Loading roadmap for textbook ${event.textbookId}');
    emit(const RoadmapLoading());

    final result = await _learningRepository.getTextbookRoadmap(
      event.textbookId,
    );

    result.fold(
      (failure) {
        print('❌ RoadmapBloc: Failed to load roadmap - ${failure.message}');
        emit(RoadmapError(failure.message));
      },
      (roadmap) {
        print(
          '✅ RoadmapBloc: Roadmap loaded successfully - ${roadmap.units.length} units',
        );
        emit(RoadmapLoaded(roadmap));
      },
    );
  }
}
