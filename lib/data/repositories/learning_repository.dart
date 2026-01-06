import 'package:dartz/dartz.dart';
import 'package:ilearn/core/errors/exceptions.dart';
import 'package:ilearn/core/errors/failures.dart';
import 'package:ilearn/data/datasources/remote/learning_remote_datasource.dart';
import 'package:ilearn/data/models/dashboard_model.dart';
import 'package:ilearn/data/models/roadmap_model.dart';

class LearningRepository {
  final LearningRemoteDataSource _remoteDataSource;

  LearningRepository(this._remoteDataSource);

  /// Get dashboard data
  Future<Either<Failure, DashboardResponseModel>> getDashboard() async {
    try {
      final response = await _remoteDataSource.getDashboard();
      return Right(response);
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

  /// Get textbook roadmap
  Future<Either<Failure, RoadmapDataModel>> getTextbookRoadmap(
    String textbookId,
  ) async {
    try {
      final response = await _remoteDataSource.getTextbookRoadmap(textbookId);
      return Right(response.data);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
