import 'dart:async';
import 'package:flutter/foundation.dart';

/// Debouncer để giảm số lần gọi hàm
class Debouncer {
  final Duration delay;
  Timer? _timer;

  Debouncer({this.delay = const Duration(milliseconds: 500)});

  /// Run callback sau khi delay
  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  /// Cancel timer hiện tại
  void cancel() {
    _timer?.cancel();
  }

  /// Dispose
  void dispose() {
    _timer?.cancel();
  }
}

/// Throttler để limit số lần gọi hàm trong khoảng thời gian
class Throttler {
  final Duration duration;
  DateTime? _lastActionTime;

  Throttler({this.duration = const Duration(seconds: 1)});

  /// Run callback nếu đã quá duration từ lần gọi cuối
  void run(VoidCallback action) {
    final now = DateTime.now();
    if (_lastActionTime == null ||
        now.difference(_lastActionTime!) >= duration) {
      _lastActionTime = now;
      action();
    }
  }

  /// Reset throttler
  void reset() {
    _lastActionTime = null;
  }
}
