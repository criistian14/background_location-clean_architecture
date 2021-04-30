import 'package:meta/meta.dart';

class ApiException implements Exception {
  final String error;
  final int code;

  ApiException({
    @required this.error,
    this.code,
  });
}

class CacheException implements Exception {
  final String error;

  CacheException({
    @required this.error,
  });
}
