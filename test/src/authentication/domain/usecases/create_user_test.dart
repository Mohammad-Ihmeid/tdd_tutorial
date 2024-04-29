// What does the class depend on
// Answer --Authentication
//how can we create a fake version of the dependency
// Answer --Mocktail
// how do we control what our dependencies
// Answer --Using the Mocktail's API's

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_tutorial/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:tdd_tutorial/src/authentication/domain/usecases/create_user.dart';

import 'authentication_repository.mock.dart';

void main() {
  late CreateUser usecase;
  late AuthenticationRepository repository;

  setUp(() {
    repository = MockAuthRepo();
    usecase = CreateUser(repository);
    registerFallbackValue(
      const CreateUserParams(
          createdAt: "createdAt", name: "name", avatar: "avatar"),
    );
  });

  const params = CreateUserParams.empty();

  test(
    'should call the [AuthRepo.createUser]',
    () async {
      //Arrange

      // مهما كانت المتغيرات التي يتم أعطائها يجب ان تكون الاجابة null
      when(
        () => repository.createUser(any()),
      ).thenAnswer((_) async => const Right(null));
      /* .thenReturn(expected) عندما يكون الاقتران لا يوجد به انتظار */
      /* .thenAnswer((invocation) => null) عندما يكون الاقتران يوجد به انتظار */

      //Act
      // منعطي نفس متغيرات فارغة عشان انطابقهم مع اجابات الي فوق
      final result = await usecase(params);

      //Assert
      // هون المكان الي بتم فيه المطابقة
      expect(result, equals(const Right<dynamic, void>(null)));
      // يجب التحقق مرة واحدة من الاجابة
      verify(
        () => repository.createUser(params),
      ).called(1);

      verifyNoMoreInteractions(repository);
    },
  );
}
