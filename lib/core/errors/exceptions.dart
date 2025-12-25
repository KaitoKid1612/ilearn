class AppException implements Exception {
  final String message;
  final int? statusCode;

  AppException({required this.message, this.statusCode});

  @override
  String toString() => message;
}

class ServerException extends AppException {
  ServerException({super.message = 'Lỗi máy chủ', super.statusCode});
}

class NetworkException extends AppException {
  NetworkException({super.message = 'Lỗi kết nối mạng', super.statusCode});
}

class CacheException extends AppException {
  CacheException({super.message = 'Lỗi lưu trữ', super.statusCode});
}

class ValidationException extends AppException {
  ValidationException({
    super.message = 'Dữ liệu không hợp lệ',
    super.statusCode,
  });
}

class UnauthorizedException extends AppException {
  UnauthorizedException({
    super.message = 'Không có quyền truy cập',
    super.statusCode = 401,
  });
}

class NotFoundException extends AppException {
  NotFoundException({
    super.message = 'Không tìm thấy dữ liệu',
    super.statusCode = 404,
  });
}
