// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:smarthome_iot/core/services/logger_service.dart';
import 'package:smarthome_iot/features/login/data/data_sources/auth_remote_datasource.dart';
import 'package:smarthome_iot/features/login/domain/repositories/auth_repository.dart';
import 'package:smarthome_iot/features/login/domain/repositories/token_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;
  final TokenRepository tokenRepository;

  AuthRepositoryImpl({
    required this.remoteDatasource,
    required this.tokenRepository,
  });

  @override
  Future<bool> loginWithPhoneNumberPassword(
      {required String phoneNumber, required String password}) async {
    try {
      final authModel = await remoteDatasource.loginWithPhoneNumberPassword(
          phoneNumber, password);
      final accessToken = authModel.accessToken;
      final refreshToken = authModel.refreshToken;
      final expiryTime = authModel.expiresIn;

      if (accessToken != null && refreshToken != null && expiryTime != null) {
        await tokenRepository.saveToken(accessToken, refreshToken, expiryTime);
        return true;
      } else {
        throw Exception();
      }
    } on DioException catch (e) {
      printE(
          "[AuthRepositoryImpl] - [loginWithUsernamePassword] error type: ${e.type} error msg: ${e.message}");
    }
    return false;
  }

  @override
  Future<bool> logout() async {
    try {
      await tokenRepository.clearTokens();
      return true;
    } catch (e) {
      return false;
    }
  }
}
