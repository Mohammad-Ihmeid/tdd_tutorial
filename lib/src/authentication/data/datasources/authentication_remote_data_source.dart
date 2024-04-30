import 'package:tdd_tutorial/src/authentication/data/models/user_model.dart';
import 'package:tdd_tutorial/src/authentication/domain/usecases/create_user.dart';

abstract class AuthenticationRemoteDataSource {
  Future<void> createUser(CreateUserParams params);

  Future<List<UserModel>> getUsers();
}
