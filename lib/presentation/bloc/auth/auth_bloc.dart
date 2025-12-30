import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilearn/data/repositories/auth_repository.dart';
import 'package:ilearn/presentation/bloc/auth/auth_event.dart';
import 'package:ilearn/presentation/bloc/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(const AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<ForgotPasswordRequested>(_onForgotPasswordRequested);
    on<ResetPasswordRequested>(_onResetPasswordRequested);
    on<CheckAuthStatus>(_onCheckAuthStatus);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await _authRepository.login(
      email: event.email,
      password: event.password,
    );

    result.fold(
      (failure) {
        emit(AuthError(failure.message));
      },
      (user) {
        emit(Authenticated(user));
      },
    );
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await _authRepository.register(
      email: event.email,
      password: event.password,
      name: event.name,
      passwordConfirmation: event.passwordConfirmation,
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(Authenticated(user)),
    );
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await _authRepository.logout();

    result.fold(
      (failure) {
        emit(AuthError(failure.message));
      },
      (_) {
        emit(const Unauthenticated());
      },
    );
  }

  Future<void> _onForgotPasswordRequested(
    ForgotPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await _authRepository.forgotPassword(event.email);

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(const ForgotPasswordSuccess()),
    );
  }

  Future<void> _onResetPasswordRequested(
    ResetPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await _authRepository.resetPassword(
      token: event.token,
      email: event.email,
      password: event.password,
      passwordConfirmation: event.passwordConfirmation,
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(const ResetPasswordSuccess()),
    );
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final isLoggedIn = _authRepository.isLoggedIn();

      if (isLoggedIn) {
        final user = _authRepository.getCurrentUser();

        if (user != null) {
          emit(Authenticated(user));
        } else {
          await _authRepository.logout();
          emit(const Unauthenticated());
        }
      } else {
        emit(const Unauthenticated());
      }
    } catch (e) {
      await _authRepository.logout();
      emit(const Unauthenticated());
    }
  }
}
