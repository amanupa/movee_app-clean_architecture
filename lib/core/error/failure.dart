// TODO Implement this library.

import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? message;

  const Failure({this.message});
}

// General Failures
class ServerFailure extends Failure {
  @override
  final String? message;

  const ServerFailure({this.message});

  @override
  List<Object?> get props => [message];
}

//internet failure

class InternetFailure extends Failure {
  @override
  List<Object?> get props => [];
}

// api Failures
class ApiFailure extends Failure {
  @override
  final String message;
  const ApiFailure({required this.message});
  @override
  List<Object?> get props => [];
}
