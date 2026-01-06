import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilearn/data/datasources/remote/learning_remote_datasource.dart';
import 'lesson_event.dart';
import 'lesson_state.dart';

class LessonBloc extends Bloc<LessonEvent, LessonState> {
  final LearningRemoteDataSource _learningDataSource;

  LessonBloc(this._learningDataSource) : super(const LessonInitial()) {
    on<LoadLessonDetailEvent>(_onLoadLessonDetail);
  }

  Future<void> _onLoadLessonDetail(
    LoadLessonDetailEvent event,
    Emitter<LessonState> emit,
  ) async {
    emit(const LessonLoading());
    try {
      final lesson = await _learningDataSource.getLessonDetail(event.lessonId);
      emit(LessonLoaded(lesson));
    } catch (e) {
      emit(LessonError(e.toString()));
    }
  }
}
