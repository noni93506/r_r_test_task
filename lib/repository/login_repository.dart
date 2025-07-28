import 'package:dio/dio.dart';
import 'package:faker/faker.dart';

interface class LoginRepository {
  final dio = Dio();
  final Faker faker = Faker();

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    await Future.delayed(Duration(milliseconds: 400));
    return faker.jwt.valid();
  }
}
