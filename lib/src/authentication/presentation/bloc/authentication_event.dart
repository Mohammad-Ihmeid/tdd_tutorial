part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class CreateUserEvent extends AuthenticationEvent {
  final CreateUserParams createUserParams;

  const CreateUserEvent({required this.createUserParams});

  @override
  List<Object> get props => [createUserParams];
}

class GetUsersEvent extends AuthenticationEvent {
  const GetUsersEvent();
}
