import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class Failure extends Equatable {
  final List properties;

  Failure([this.properties]);

  @override
  List<Object> get props => (properties ?? []);
}

class ServerFailure extends Failure {
  final String error;
  final int code;

  ServerFailure({
    @required this.error,
    this.code,
  });
}

class CacheFailure extends Failure {
  final String error;

  CacheFailure({
    @required this.error,
  });
}
