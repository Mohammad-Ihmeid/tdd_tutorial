import 'package:dartz/dartz.dart';
import 'package:tdd_tutorial/core/errors/exceptions.dart';
import 'package:tdd_tutorial/core/errors/failure.dart';
import 'package:tdd_tutorial/core/utils/typedef.dart';
import 'package:tdd_tutorial/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tdd_tutorial/src/authentication/domain/entities/user.dart';
import 'package:tdd_tutorial/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:tdd_tutorial/src/authentication/domain/usecases/create_user.dart';

class AuthenticationRepositoryImplementation extends AuthenticationRepository {
  final AuthenticationRemoteDataSource _remoteDataSource;

  AuthenticationRepositoryImplementation(this._remoteDataSource);

  @override
  ResultVoid createUser(CreateUserParams params) async {
    //Test-Driven Development
    //call the remote data source
    //check if the method returns the proper data
    //make sure that it returns the proper data if there is no exception
    //check if when the remoteDataSource throws an exception, we return a
    //failure and if it doesn't throw and exception , we return the actual
    //expected data
    try {
      final result = await _remoteDataSource.createUser(params);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    try {
      final result = await _remoteDataSource.getUsers();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
