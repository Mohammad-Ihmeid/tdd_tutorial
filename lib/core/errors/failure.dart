import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final int statusCode;

  const Failure({required this.message, required this.statusCode});

  @override
  List<Object> get props => [message, statusCode];
}

class RemoteFailure extends Failure {
  const RemoteFailure({required super.message, required super.statusCode});
}

class LocalDataFailure extends Failure {
  const LocalDataFailure({required super.message, required super.statusCode});
}
