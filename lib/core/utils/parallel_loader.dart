import 'package:dartz/dartz.dart';
import 'package:ilearn/core/errors/failures.dart';

/// Helper class để load nhiều API calls song song (parallel)
class ParallelLoader {
  /// Load 2 APIs đồng thời
  static Future<(Either<Failure, T1>, Either<Failure, T2>)> load2<T1, T2>(
    Future<Either<Failure, T1>> Function() call1,
    Future<Either<Failure, T2>> Function() call2,
  ) async {
    final results = await Future.wait([call1(), call2()]);
    return (
      results[0] as Either<Failure, T1>,
      results[1] as Either<Failure, T2>,
    );
  }

  /// Load 3 APIs đồng thời
  static Future<(Either<Failure, T1>, Either<Failure, T2>, Either<Failure, T3>)>
  load3<T1, T2, T3>(
    Future<Either<Failure, T1>> Function() call1,
    Future<Either<Failure, T2>> Function() call2,
    Future<Either<Failure, T3>> Function() call3,
  ) async {
    final results = await Future.wait([call1(), call2(), call3()]);
    return (
      results[0] as Either<Failure, T1>,
      results[1] as Either<Failure, T2>,
      results[2] as Either<Failure, T3>,
    );
  }

  /// Load 4 APIs đồng thời
  static Future<
    (
      Either<Failure, T1>,
      Either<Failure, T2>,
      Either<Failure, T3>,
      Either<Failure, T4>,
    )
  >
  load4<T1, T2, T3, T4>(
    Future<Either<Failure, T1>> Function() call1,
    Future<Either<Failure, T2>> Function() call2,
    Future<Either<Failure, T3>> Function() call3,
    Future<Either<Failure, T4>> Function() call4,
  ) async {
    final results = await Future.wait([call1(), call2(), call3(), call4()]);
    return (
      results[0] as Either<Failure, T1>,
      results[1] as Either<Failure, T2>,
      results[2] as Either<Failure, T3>,
      results[3] as Either<Failure, T4>,
    );
  }

  /// Load danh sách APIs đồng thời (generic)
  static Future<List<Either<Failure, T>>> loadList<T>(
    List<Future<Either<Failure, T>> Function()> calls,
  ) async {
    final futures = calls.map((call) => call()).toList();
    return await Future.wait(futures);
  }

  /// Load với timeout
  static Future<Either<Failure, T>> loadWithTimeout<T>(
    Future<Either<Failure, T>> Function() call, {
    Duration timeout = const Duration(seconds: 30),
  }) async {
    try {
      return await call().timeout(
        timeout,
        onTimeout: () =>
            Left(ServerFailure('Request timeout after ${timeout.inSeconds}s')),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

/// Extension để xử lý parallel loading cho BLoC
extension ParallelLoadingExtension on List<Either<Failure, dynamic>> {
  /// Check nếu tất cả đều success
  bool get allSuccess => every((result) => result.isRight());

  /// Check nếu có ít nhất 1 success
  bool get hasSuccess => any((result) => result.isRight());

  /// Lấy tất cả errors
  List<Failure> get failures => where((result) => result.isLeft())
      .map((result) => result.fold((l) => l, (_) => null))
      .whereType<Failure>()
      .toList();

  /// Lấy tất cả success values
  List<T> getSuccessValues<T>() => where((result) => result.isRight())
      .map((result) => result.fold((_) => null, (r) => r as T?))
      .whereType<T>()
      .toList();
}
