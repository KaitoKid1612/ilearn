import 'package:dartz/dartz.dart';
import 'package:ilearn/core/errors/exceptions.dart';
import 'package:ilearn/core/errors/failures.dart';
import 'package:ilearn/domain/entities/user.dart';
import 'package:ilearn/data/datasources/local/auth_local_datasource.dart';
import 'package:ilearn/data/datasources/remote/auth_remote_datasource.dart';
import 'package:ilearn/data/models/login_request_model.dart';
import 'package:ilearn/data/models/register_request_model.dart';

class AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  AuthRepository(this._remoteDataSource, this._localDataSource);

  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
    try {
      final request = LoginRequestModel(email: email, password: password);
      final response = await _remoteDataSource.login(request);

      // Save to local storage
      await _localDataSource.saveToken(response.token);
      if (response.refreshToken != null) {
        await _localDataSource.saveRefreshToken(response.refreshToken!);
      }
      await _localDataSource.saveUser(response.user);

      return Right(response.user.toEntity());
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, User>> register({
    required String email,
    required String password,
    required String name,
    required String passwordConfirmation,
  }) async {
    try {
      final request = RegisterRequestModel(
        email: email,
        password: password,
        name: name,
        passwordConfirmation: passwordConfirmation,
      );
      final response = await _remoteDataSource.register(request);

      // Save to local storage
      await _localDataSource.saveToken(response.token);
      if (response.refreshToken != null) {
        await _localDataSource.saveRefreshToken(response.refreshToken!);
      }
      await _localDataSource.saveUser(response.user);

      return Right(response.user.toEntity());
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> logout() async {
    try {
      await _remoteDataSource.logout();
      await _localDataSource.clearAuthData();
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> forgotPassword(String email) async {
    try {
      await _remoteDataSource.forgotPassword(email);
      return const Right(null);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> resetPassword({
    required String token,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      await _remoteDataSource.resetPassword(
        token: token,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );
      return const Right(null);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  User? getCurrentUser() {
    try {
      final userModel = _localDataSource.getUser();
      return userModel?.toEntity();
    } catch (e) {
      return null;
    }
  }

  bool isLoggedIn() {
    return _localDataSource.isLoggedIn();
  }
}
