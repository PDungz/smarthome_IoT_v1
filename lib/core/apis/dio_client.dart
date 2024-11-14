// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:smarthome_iot/core/apis/dio_interceptors/logging_interceptor.dart';
import 'package:smarthome_iot/core/apis/dio_interceptors/token_interceptor.dart';
import 'package:smarthome_iot/core/utils/dot_env_util.dart';
import 'package:smarthome_iot/features/login/domain/repositories/token_repository.dart';

class DioClient {
  late Dio authenticatedDio;
  late Dio externalDio;
  final TokenRepository tokenRepository;
  final baseUrl = DotEnvUtil.apiHost + DotEnvUtil.apiVersion;

  DioClient({
    required this.tokenRepository,
  }) {
    initAuthenticatedDio();
    initExternalDio();
  }

  void initAuthenticatedDio() {
    authenticatedDio = Dio();
    authenticatedDio.options = BaseOptions(
      baseUrl: baseUrl,
      receiveTimeout: const Duration(seconds: 8),
      connectTimeout: const Duration(seconds: 3),
    );
    authenticatedDio.interceptors.add(LoggingInterceptor());
    authenticatedDio.interceptors.add(TokenInterceptor(
      dio: authenticatedDio,
      tokenRepository: tokenRepository,
    ));
  }

  void initExternalDio() {
    externalDio = Dio();
    externalDio.options = BaseOptions(
      baseUrl: baseUrl,
      receiveTimeout: const Duration(minutes: 1),
      connectTimeout: const Duration(seconds: 3),
    );
    externalDio.interceptors.add(LoggingInterceptor());
  }
}
