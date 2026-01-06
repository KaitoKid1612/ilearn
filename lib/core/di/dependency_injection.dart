import 'package:get_it/get_it.dart';
import 'package:ilearn/core/network/dio_client.dart';
import 'package:ilearn/data/datasources/exercise_remote_datasource.dart';
import 'package:ilearn/data/datasources/flashcard_remote_datasource.dart';
import 'package:ilearn/data/datasources/speaking_exercise_remote_datasource.dart';
import 'package:ilearn/data/datasources/typing_exercise_remote_datasource.dart';
import 'package:ilearn/data/datasources/remote/auth_remote_datasource.dart';
import 'package:ilearn/data/datasources/remote/course_remote_datasource.dart';
import 'package:ilearn/data/datasources/remote/learning_remote_datasource.dart';
import 'package:ilearn/data/datasources/vocabulary_remote_datasource.dart';
import 'package:ilearn/data/datasources/kanji_remote_datasource.dart';
import 'package:ilearn/data/repositories/course_repository.dart';
import 'package:ilearn/data/repositories/exercise_repository_impl.dart';
import 'package:ilearn/data/repositories/flashcard_repository.dart';
import 'package:ilearn/data/repositories/grammar_repository.dart';
import 'package:ilearn/data/repositories/grammar_practice_repository.dart';
import 'package:ilearn/data/repositories/learning_repository.dart';
import 'package:ilearn/data/repositories/speaking_exercise_repository_impl.dart';
import 'package:ilearn/data/repositories/typing_exercise_repository_impl.dart';
import 'package:ilearn/data/repositories/vocabulary_repository_impl.dart';
import 'package:ilearn/data/repositories/kanji_repository_impl.dart';
import 'package:ilearn/domain/repositories/exercise_repository.dart';
import 'package:ilearn/domain/repositories/typing_exercise_repository.dart';
import 'package:ilearn/domain/usecases/answer_flashcard.dart';
import 'package:ilearn/domain/usecases/create_multiple_choice_exercise.dart';
import 'package:ilearn/domain/usecases/create_speaking_exercise.dart';
import 'package:ilearn/domain/usecases/create_typing_exercise.dart';
import 'package:ilearn/domain/usecases/get_dashboard_usecase.dart';
import 'package:ilearn/domain/usecases/get_flashcards_by_lesson.dart';
import 'package:ilearn/domain/usecases/get_textbook_roadmap_usecase.dart';
import 'package:ilearn/domain/usecases/get_lesson_vocabulary.dart';
import 'package:ilearn/domain/usecases/get_lesson_kanji.dart';
import 'package:ilearn/domain/usecases/get_lesson_exercises.dart';
import 'package:ilearn/domain/usecases/get_vocabulary_progress.dart';
import 'package:ilearn/domain/usecases/start_study_session.dart';
import 'package:ilearn/domain/usecases/submit_exercise.dart';
import 'package:ilearn/domain/usecases/submit_speaking_exercise.dart';
import 'package:ilearn/domain/usecases/submit_typing_exercise.dart';
import 'package:ilearn/domain/usecases/submit_vocabulary_progress.dart';
import 'package:ilearn/domain/usecases/transcribe_audio.dart';
import 'package:ilearn/presentation/bloc/dashboard/dashboard_bloc.dart';
import 'package:ilearn/presentation/bloc/exercise/exercise_bloc.dart';
import 'package:ilearn/presentation/bloc/flashcard/flashcard_bloc.dart';
import 'package:ilearn/presentation/bloc/grammar/grammar_bloc.dart';
import 'package:ilearn/presentation/bloc/grammar_practice/grammar_practice_bloc.dart';
import 'package:ilearn/presentation/bloc/home/home_bloc.dart';
import 'package:ilearn/presentation/bloc/speaking_exercise/speaking_exercise_bloc.dart';
import 'package:ilearn/presentation/bloc/typing_exercise/typing_exercise_bloc.dart';
import 'package:ilearn/presentation/bloc/vocabulary/vocabulary_bloc.dart';
import 'package:ilearn/presentation/bloc/lesson/lesson_bloc.dart';
import 'package:ilearn/presentation/bloc/kanji/kanji_bloc.dart';
import 'package:ilearn/presentation/bloc/lesson_exercise/lesson_exercise_bloc.dart';

final getIt = GetIt.instance;

Future<void> setupDependencyInjection() async {
  // Core
  getIt.registerLazySingleton<DioClient>(() => DioClient());

  // Data Sources
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(getIt()),
  );
  getIt.registerLazySingleton<CourseRemoteDataSource>(
    () => CourseRemoteDataSource(getIt()),
  );
  getIt.registerLazySingleton<LearningRemoteDataSource>(
    () => LearningRemoteDataSource(getIt()),
  );
  getIt.registerLazySingleton<VocabularyRemoteDataSource>(
    () => VocabularyRemoteDataSourceImpl(dioClient: getIt()),
  );
  getIt.registerLazySingleton<KanjiRemoteDataSource>(
    () => KanjiRemoteDataSourceImpl(dioClient: getIt()),
  );
  getIt.registerLazySingleton<FlashcardRemoteDataSource>(
    () => FlashcardRemoteDataSource(dio: getIt<DioClient>().dio),
  );
  getIt.registerLazySingleton<ExerciseRemoteDataSource>(
    () => ExerciseRemoteDataSourceImpl(dio: getIt<DioClient>().dio),
  );
  getIt.registerLazySingleton<TypingExerciseRemoteDataSource>(
    () => TypingExerciseRemoteDataSourceImpl(dio: getIt<DioClient>().dio),
  );
  getIt.registerLazySingleton<SpeakingExerciseRemoteDataSource>(
    () => SpeakingExerciseRemoteDataSourceImpl(getIt()),
  );

  // Repositories
  getIt.registerLazySingleton<CourseRepository>(
    () => CourseRepository(getIt()),
  );
  getIt.registerLazySingleton<LearningRepository>(
    () => LearningRepository(getIt()),
  );
  getIt.registerLazySingleton<VocabularyRepository>(
    () => VocabularyRepositoryImpl(remoteDataSource: getIt()),
  );
  getIt.registerLazySingleton<KanjiRepository>(
    () => KanjiRepositoryImpl(remoteDataSource: getIt()),
  );
  getIt.registerLazySingleton<FlashcardRepository>(
    () => FlashcardRepository(remoteDataSource: getIt()),
  );
  getIt.registerLazySingleton<ExerciseRepository>(
    () => ExerciseRepositoryImpl(remoteDataSource: getIt()),
  );
  getIt.registerLazySingleton<TypingExerciseRepository>(
    () => TypingExerciseRepositoryImpl(remoteDataSource: getIt()),
  );
  getIt.registerLazySingleton<SpeakingExerciseRepository>(
    () => SpeakingExerciseRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<GrammarRepository>(
    () => GrammarRepositoryImpl(dio: getIt<DioClient>().dio),
  );
  getIt.registerLazySingleton<GrammarPracticeRepository>(
    () => GrammarPracticeRepositoryImpl(dio: getIt<DioClient>().dio),
  );

  // Use Cases
  getIt.registerLazySingleton<GetDashboardUseCase>(
    () => GetDashboardUseCase(getIt()),
  );
  getIt.registerLazySingleton<GetLessonKanji>(() => GetLessonKanji(getIt()));
  getIt.registerLazySingleton<GetLessonExercises>(
    () => GetLessonExercises(getIt()),
  );
  getIt.registerLazySingleton<GetLessonVocabulary>(
    () => GetLessonVocabulary(getIt()),
  );
  getIt.registerLazySingleton<GetVocabularyProgress>(
    () => GetVocabularyProgress(getIt()),
  );
  getIt.registerLazySingleton<SubmitVocabularyProgress>(
    () => SubmitVocabularyProgress(getIt()),
  );
  getIt.registerLazySingleton<GetTextbookRoadmapUseCase>(
    () => GetTextbookRoadmapUseCase(getIt()),
  );
  getIt.registerLazySingleton<GetFlashcardsByLessonUseCase>(
    () => GetFlashcardsByLessonUseCase(getIt()),
  );
  getIt.registerLazySingleton<StartStudySessionUseCase>(
    () => StartStudySessionUseCase(getIt()),
  );
  getIt.registerLazySingleton<CreateMultipleChoiceExercise>(
    () => CreateMultipleChoiceExercise(getIt()),
  );
  getIt.registerLazySingleton<SubmitExercise>(() => SubmitExercise(getIt()));
  getIt.registerLazySingleton<CreateTypingExercise>(
    () => CreateTypingExercise(getIt()),
  );
  getIt.registerLazySingleton<SubmitTypingExercise>(
    () => SubmitTypingExercise(getIt()),
  );
  getIt.registerLazySingleton<CreateSpeakingExercise>(
    () => CreateSpeakingExercise(getIt()),
  );
  getIt.registerLazySingleton<TranscribeAudio>(() => TranscribeAudio(getIt()));
  getIt.registerLazySingleton<SubmitSpeakingExercise>(
    () => SubmitSpeakingExercise(getIt()),
  );
  getIt.registerLazySingleton<AnswerFlashcardUseCase>(
    () => AnswerFlashcardUseCase(getIt()),
  );
  getIt.registerFactory<VocabularyBloc>(
    () => VocabularyBloc(dataSource: getIt(), repository: getIt()),
  );

  // BLoCs
  getIt.registerFactory<HomeBloc>(() => HomeBloc(getIt()));
  getIt.registerFactory<DashboardBloc>(
    () => DashboardBloc(getDashboardUseCase: getIt()),
  );
  getIt.registerFactory<LessonBloc>(() => LessonBloc(getIt()));
  getIt.registerFactory<FlashcardBloc>(
    () => FlashcardBloc(
      getFlashcardsByLesson: getIt(),
      startStudySession: getIt(),
      answerFlashcard: getIt(),
    ),
  );
  getIt.registerFactory<ExerciseBloc>(
    () => ExerciseBloc(
      createMultipleChoiceExercise: getIt(),
      submitExercise: getIt(),
    ),
  );
  getIt.registerFactory<TypingExerciseBloc>(
    () => TypingExerciseBloc(
      createTypingExercise: getIt(),
      submitTypingExercise: getIt(),
    ),
  );
  getIt.registerFactory<SpeakingExerciseBloc>(
    () => SpeakingExerciseBloc(
      createSpeakingExercise: getIt(),
      transcribeAudio: getIt(),
      submitSpeakingExercise: getIt(),
    ),
  );
  getIt.registerFactory<GrammarBloc>(() => GrammarBloc(repository: getIt()));
  getIt.registerFactory<GrammarPracticeBloc>(
    () => GrammarPracticeBloc(repository: getIt()),
  );
  getIt.registerFactory<KanjiBloc>(
    () => KanjiBloc(getLessonKanji: getIt(), repository: getIt()),
  );
  getIt.registerFactory<LessonExerciseBloc>(
    () => LessonExerciseBloc(getLessonExercises: getIt()),
  );
}
