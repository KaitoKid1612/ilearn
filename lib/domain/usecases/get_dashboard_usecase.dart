import 'package:dartz/dartz.dart';
import 'package:ilearn/core/errors/failures.dart';
import 'package:ilearn/data/models/dashboard_model.dart';
import 'package:ilearn/data/repositories/learning_repository.dart';

class GetDashboardUseCase {
  final LearningRepository _repository;

  GetDashboardUseCase(this._repository);

  Future<Either<Failure, DashboardDataModel>> call() async {
    return await _repository.getDashboard();
  }
}
