import 'package:dartz/dartz.dart';
import 'package:ilearn/core/errors/failures.dart';
import 'package:ilearn/data/models/roadmap_model.dart';
import 'package:ilearn/data/repositories/learning_repository.dart';

class GetTextbookRoadmapUseCase {
  final LearningRepository _repository;

  GetTextbookRoadmapUseCase(this._repository);

  Future<Either<Failure, RoadmapDataModel>> call(String textbookId) async {
    return await _repository.getTextbookRoadmap(textbookId);
  }
}
