import 'dart:async';

/// Simple in-memory cache manager với TTL (Time To Live)
class CacheManager {
  static final CacheManager _instance = CacheManager._internal();
  factory CacheManager() => _instance;
  CacheManager._internal();

  final Map<String, _CacheEntry> _cache = {};
  final Map<String, Timer> _timers = {};

  /// Lấy data từ cache
  T? get<T>(String key) {
    final entry = _cache[key];
    if (entry == null) return null;

    // Check if expired
    if (entry.expireAt.isBefore(DateTime.now())) {
      remove(key);
      return null;
    }

    return entry.data as T?;
  }

  /// Set data vào cache với TTL (mặc định 5 phút)
  void set<T>(String key, T data, {Duration ttl = const Duration(minutes: 5)}) {
    // Cancel existing timer
    _timers[key]?.cancel();

    final expireAt = DateTime.now().add(ttl);
    _cache[key] = _CacheEntry(data: data, expireAt: expireAt);

    // Set auto-remove timer
    _timers[key] = Timer(ttl, () => remove(key));
  }

  /// Remove data khỏi cache
  void remove(String key) {
    _cache.remove(key);
    _timers[key]?.cancel();
    _timers.remove(key);
  }

  /// Clear toàn bộ cache
  void clear() {
    for (var timer in _timers.values) {
      timer.cancel();
    }
    _cache.clear();
    _timers.clear();
  }

  /// Check if key exists và chưa expired
  bool has(String key) {
    final entry = _cache[key];
    if (entry == null) return false;

    if (entry.expireAt.isBefore(DateTime.now())) {
      remove(key);
      return false;
    }

    return true;
  }

  /// Get all cached keys
  List<String> get keys => _cache.keys.toList();
}

class _CacheEntry {
  final dynamic data;
  final DateTime expireAt;

  _CacheEntry({required this.data, required this.expireAt});
}
