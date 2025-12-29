import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/auth/auth_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay a bit to show splash, then check auth
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        print('🔍 Splash: Checking auth status...');
        context.read<AuthBloc>().add(const CheckAuthStatus());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            print('✅ Splash: User authenticated, going to dashboard');
            // Navigate to dashboard
            context.go('/dashboard');
          } else if (state is Unauthenticated) {
            print('❌ Splash: User not authenticated, going to login');
            // Navigate to login
            context.go('/login');
          } else if (state is AuthError) {
            print('⚠️ Splash: Auth error, going to login');
            // If there's an error checking auth, go to login
            context.go('/login');
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Icon(Icons.school_rounded, size: 120, color: Colors.white),
              const SizedBox(height: 24),

              // App name
              Text(
                'iLearn',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              Text(
                'Học tiếng Nhật cùng bạn',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: Colors.white70),
              ),
              const SizedBox(height: 48),

              // Loading indicator
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
