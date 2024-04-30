import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_tutorial/core/errors/exceptions.dart';
import 'package:tdd_tutorial/core/errors/failure.dart';
import 'package:tdd_tutorial/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tdd_tutorial/src/authentication/data/models/user_model.dart';
import 'package:tdd_tutorial/src/authentication/data/repositories/authentication_repository_implementation.dart';
import 'package:tdd_tutorial/src/authentication/domain/entities/user.dart';
import 'package:tdd_tutorial/src/authentication/domain/usecases/create_user.dart';

class MockAuthRemoteDataSrc extends Mock
    implements AuthenticationRemoteDataSource {}

void main() {
  late AuthenticationRepositoryImplementation repoImpl;
  late AuthenticationRemoteDataSource remoteDataSource;

  setUp(() {
    remoteDataSource = MockAuthRemoteDataSrc();
    repoImpl = AuthenticationRepositoryImplementation(remoteDataSource);
    registerFallbackValue(const CreateUserParams(
      createdAt: 'createdAt',
      name: 'name',
      avatar: 'avatar',
    ));
  });

  const tException =
      ServerException(message: 'Unknown Error Occurred', statusCode: 500);

  group('createUser', () {
    const createdAt = 'whatever.createdAt';
    const name = 'whatever.name';
    const avatar = 'whatever.avatar';

    test(
      'should call the [RemoteDataSource.createUser] and complete '
      'successfully when the call to the remote source is successful',
      () async {
        // arrange
        when(() => remoteDataSource.createUser(any()))
            .thenAnswer((_) async => Future.value());

        const createUserParams =
            CreateUserParams(createdAt: createdAt, name: name, avatar: avatar);

        // act
        final result = await repoImpl.createUser(createUserParams);

        // assert
        expect(result, equals(const Right(null)));
        verify(
          () => remoteDataSource.createUser(
            const CreateUserParams(
                createdAt: createdAt, name: name, avatar: avatar),
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'should return a [ServerFailure] when the call to the remote '
      'source is unsuccessful',
      () async {
        // arrange
        when(() => remoteDataSource.createUser(any())).thenThrow(tException);

        // act
        final result = await repoImpl.createUser(const CreateUserParams(
          createdAt: createdAt,
          name: name,
          avatar: avatar,
        ));

        //assert
        expect(result, equals(Left(ServerFailure.fromException(tException))));

        verify(() => remoteDataSource.createUser(const CreateUserParams(
            createdAt: createdAt, name: name, avatar: avatar))).called(1);

        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  group('getUsers', () {
    const tResponse = [UserModel.empty()];

    test(
      'should call the [RemoteDataSource.getUsers] and complete'
      ' successfully when the call to the remote source is successful ',
      () async {
        // arrange
        when(() => remoteDataSource.getUsers())
            .thenAnswer((_) async => tResponse);

        //act
        final result = await repoImpl.getUsers();

        // assert
        expect(result, isA<Right<dynamic, List<User>>>());
        verify(() => remoteDataSource.getUsers()).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'should return a [ServerFailure] when the call to the remote'
      'source is unsuccessful',
      () async {
        // arrange
        when(() => remoteDataSource.getUsers()).thenThrow(tException);

        //act
        final result = await repoImpl.getUsers();

        //assert
        expect(result, equals(Left(ServerFailure.fromException(tException))));
        verify(() => remoteDataSource.getUsers()).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });
}
