import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class RegisterRequested extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final String passwordConfirmation;

  const RegisterRequested({
    required this.email,
    required this.password,
    required this.name,
    required this.passwordConfirmation,
  });

  @override
  List<Object> get props => [email, password, name, passwordConfirmation];
}

class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}

class ForgotPasswordRequested extends AuthEvent {
  final String email;

  const ForgotPasswordRequested(this.email);

  @override
  List<Object> get props => [email];
}

class ResetPasswordRequested extends AuthEvent {
  final String token;
  final String email;
  final String password;
  final String passwordConfirmation;

  const ResetPasswordRequested({
    required this.token,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });

  @override
  List<Object> get props => [token, email, password, passwordConfirmation];
}

class CheckAuthStatus extends AuthEvent {
  const CheckAuthStatus();
}
