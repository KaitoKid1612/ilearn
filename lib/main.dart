import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/di/dependency_injection.dart';
import 'core/routes/app_router.dart';
import 'core/theme/app_theme.dart';
import 'data/datasources/local/auth_local_datasource.dart';
import 'data/repositories/auth_repository.dart';
import 'presentation/bloc/auth/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: '.env');

  // Initialize SharedPreferences
  final prefs = await SharedPreferences.getInstance();

  // Setup dependency injection
  await setupDependencyInjection();

  // Setup auth local datasource with SharedPreferences
  final authLocalDataSource = AuthLocalDataSource(prefs);
  final authRepository = AuthRepository(getIt(), authLocalDataSource);

  runApp(MyApp(authRepository: authRepository));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;

  const MyApp({super.key, required this.authRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(authRepository),
      child: MaterialApp.router(
        title: 'iLearn - Học tiếng Nhật',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
