import 'package:dartz/dartz.dart';
import 'package:ilearn/core/cache/cache_manager.dart';
import 'package:ilearn/core/errors/failures.dart';
import 'package:ilearn/data/datasources/flashcard_remote_datasource.dart';
import 'package:ilearn/data/models/flashcard_model.dart';
import 'package:ilearn/domain/entities/flashcard.dart';

/// Repository cho Flashcard với caching
class FlashcardRepository {
  final FlashcardRemoteDataSource remoteDataSource;
  final CacheManager _cacheManager = CacheManager();

  FlashcardRepository({required this.remoteDataSource});

  /// Lấy flashcard set của lesson (với cache)
  Future<Either<Failure, FlashcardSet>> getFlashcardsByLesson(
    String lessonId, {
    bool forceRefresh = false,
  }) async {
    final cacheKey = 'flashcards_lesson_$lessonId';

    // Try cache first (unless force refresh)
    if (!forceRefresh && _cacheManager.has(cacheKey)) {
      final cached = _cacheManager.get<FlashcardSet>(cacheKey);
      if (cached != null) {
        return Right(cached);
      }
    }

    // Fetch from API
    try {
      final result = await remoteDataSource.getFlashcardsByLesson(lessonId);

      // Cache for 10 minutes
      _cacheManager.set(cacheKey, result, ttl: const Duration(minutes: 10));

      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  /// Bắt đầu session học flashcard
  Future<Either<Failure, Map<String, dynamic>>> startStudySession(
    String lessonId,
  ) async {
    try {
      final result = await remoteDataSource.startStudySession(lessonId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  /// Trả lời flashcard
  Future<Either<Failure, FlashcardAnswerResponse>> answerFlashcard({
    required String flashcardId,
    required bool isRemembered,
  }) async {
    try {
      final result = await remoteDataSource.answerFlashcard(
        flashcardId: flashcardId,
        isRemembered: isRemembered,
      );

      // Invalidate cache khi answer để lần sau fetch fresh data
      _invalidateFlashcardCaches();

      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  /// Lấy flashcards cần ôn tập hàng ngày
  Future<Either<Failure, FlashcardSet>> getDailyReview({
    bool forceRefresh = false,
  }) async {
    const cacheKey = 'flashcards_daily_review';

    // Try cache first
    if (!forceRefresh && _cacheManager.has(cacheKey)) {
      final cached = _cacheManager.get<FlashcardSet>(cacheKey);
      if (cached != null) {
        return Right(cached);
      }
    }

    // Fetch from API
    try {
      final result = await remoteDataSource.getDailyReview();

      // Cache for 5 minutes (daily review changes frequently)
      _cacheManager.set(cacheKey, result, ttl: const Duration(minutes: 5));

      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  /// Invalidate all flashcard caches
  void _invalidateFlashcardCaches() {
    final keys = _cacheManager.keys
        .where((key) => key.startsWith('flashcards_'))
        .toList();
    for (var key in keys) {
      _cacheManager.remove(key);
    }
  }

  /// Clear all flashcard caches manually
  void clearCache() {
    _invalidateFlashcardCaches();
  }
}
