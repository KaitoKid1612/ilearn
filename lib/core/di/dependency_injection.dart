import 'package:get_it/get_it.dart';
import 'package:ilearn/core/network/dio_client.dart';
import 'package:ilearn/data/datasources/remote/auth_remote_datasource.dart';
import 'package:ilearn/data/datasources/remote/course_remote_datasource.dart';
import 'package:ilearn/data/datasources/remote/learning_remote_datasource.dart';
import 'package:ilearn/data/datasources/vocabulary_remote_datasource.dart';
import 'package:ilearn/data/repositories/course_repository.dart';
import 'package:ilearn/data/repositories/learning_repository.dart';
import 'package:ilearn/data/repositories/vocabulary_repository_impl.dart';
import 'package:ilearn/domain/usecases/get_dashboard_usecase.dart';
import 'package:ilearn/domain/usecases/get_textbook_roadmap_usecase.dart';
import 'package:ilearn/domain/usecases/get_lesson_vocabulary.dart';
import 'package:ilearn/domain/usecases/get_vocabulary_progress.dart';
import 'package:ilearn/domain/usecases/submit_vocabulary_progress.dart';
import 'package:ilearn/presentation/bloc/dashboard/dashboard_bloc.dart';
import 'package:ilearn/presentation/bloc/home/home_bloc.dart';
import 'package:ilearn/presentation/bloc/vocabulary/vocabulary_bloc.dart';

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

  // Use Cases
  getIt.registerLazySingleton<GetDashboardUseCase>(
    () => GetDashboardUseCase(getIt()),
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
  getIt.registerFactory<VocabularyBloc>(
    () => VocabularyBloc(
      getLessonVocabulary: getIt(),
      getVocabularyProgress: getIt(),
      submitVocabularyProgress: getIt(),
    ),
  );

  // BLoCs
  getIt.registerFactory<HomeBloc>(() => HomeBloc(getIt()));
  getIt.registerFactory<DashboardBloc>(
    () => DashboardBloc(
      getDashboardUseCase: getIt(),
      getTextbookRoadmapUseCase: getIt(),
    ),
  );
}
