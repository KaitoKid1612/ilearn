import 'package:get_it/get_it.dart';
import 'package:ilearn/core/network/dio_client.dart';
import 'package:ilearn/data/datasources/remote/auth_remote_datasource.dart';
import 'package:ilearn/data/datasources/remote/course_remote_datasource.dart';
import 'package:ilearn/data/repositories/course_repository.dart';
import 'package:ilearn/presentation/bloc/home/home_bloc.dart';

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

  // Repositories
  getIt.registerLazySingleton<CourseRepository>(
    () => CourseRepository(getIt()),
  );

  // BLoCs
  getIt.registerFactory<HomeBloc>(() => HomeBloc(getIt()));
}
