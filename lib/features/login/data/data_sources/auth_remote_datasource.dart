// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:smarthome_iot/features/login/data/models/auth_model.dart';

abstract class AuthRemoteDatasource {
  Future<AuthModel> loginWithPhoneNumberPassword(
      String phoneNumber, String password);
}

class AuthRemoteDatasourceImpl extends AuthRemoteDatasource {
  final Dio dio;

  AuthRemoteDatasourceImpl({
    required this.dio,
  });

  @override
  Future<AuthModel> loginWithPhoneNumberPassword(
      String phoneNumber, String password) async {
    final response = await dio.post('/auth/login', data: {
      'phoneNumber': phoneNumber,
      'password': password,
    });
    return AuthModel.fromJson(response.data);
  }
}
