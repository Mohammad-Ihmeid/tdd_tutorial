import 'package:tdd_tutorial/core/utils/typedef.dart';
import 'package:tdd_tutorial/src/authentication/domain/entities/user.dart';
import 'package:tdd_tutorial/src/authentication/domain/usecases/create_user.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  ResultVoid createUser(CreateUserParams params);

  ResultFuture<List<User>> getUsers();
}


/* Future<(Exception, List<User>)> getUsers(); */
