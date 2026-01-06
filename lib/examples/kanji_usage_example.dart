// Example: How to use the Kanji API Feature
// This example demonstrates how to fetch and display Kanji data for a lesson

import 'package:flutter/material.dart';
import 'package:ilearn/core/di/dependency_injection.dart';
import 'package:ilearn/domain/usecases/get_lesson_kanji.dart';

class KanjiUsageExample extends StatefulWidget {
  final String lessonId;

  const KanjiUsageExample({Key? key, required this.lessonId}) : super(key: key);

  @override
  State<KanjiUsageExample> createState() => _KanjiUsageExampleState();
}

class _KanjiUsageExampleState extends State<KanjiUsageExample> {
  final GetLessonKanji _getLessonKanji = getIt<GetLessonKanji>();
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchKanjiData();
  }

  Future<void> _fetchKanjiData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    final result = await _getLessonKanji(widget.lessonId);

    result.fold(
      (failure) {
        setState(() {
          _error = failure.toString();
          _isLoading = false;
        });
      },
      (kanjiData) {
        setState(() {
          _isLoading = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(child: Text('Error: $_error'));
    }

    return const Center(child: Text('Kanji loaded successfully!'));
  }
}

// Alternative: Using in a BLoC pattern
/*
class KanjiBloc extends Bloc<KanjiEvent, KanjiState> {
  final GetLessonKanji getLessonKanji;

  KanjiBloc({required this.getLessonKanji}) : super(KanjiInitial()) {
    on<FetchLessonKanji>(_onFetchLessonKanji);
  }

  Future<void> _onFetchLessonKanji(
    FetchLessonKanji event,
    Emitter<KanjiState> emit,
  ) async {
    emit(KanjiLoading());

    final result = await getLessonKanji(event.lessonId);

    result.fold(
      (failure) => emit(KanjiError(failure.toString())),
      (kanjiData) => emit(KanjiLoaded(kanjiData)),
    );
  }
}
*/

// Direct API Call Example (without using use case):
/*
import 'package:ilearn/data/datasources/kanji_remote_datasource.dart';

final kanjiDataSource = getIt<KanjiRemoteDataSource>();
final kanjiData = await kanjiDataSource.getLessonKanji('lesson-1');

// Access the data:
print('Total: ${kanjiData.progress.total}');
kanjiData.kanjis.forEach((kanji) {
  print('${kanji.character}: ${kanji.meaning}');
});
*/
