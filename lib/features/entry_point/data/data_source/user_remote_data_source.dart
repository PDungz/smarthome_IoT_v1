// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:smarthome_iot/core/services/logger_service.dart';
import 'package:smarthome_iot/features/login/domain/repositories/token_repository.dart';
import '../../domain/entities/user.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<User?> getUser();
  Future<bool> putUser(User user, String password);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio dio;
  final TokenRepository tokenRepository;

  UserRemoteDataSourceImpl({
    required this.dio,
    required this.tokenRepository,
  });

  @override
  Future<User?> getUser() async {
    try {
      final accessToken = await tokenRepository.getAccessToken();
      if (accessToken == null) {
        throw Exception("Token truy cập không tồn tại");
      }
      final response = await dio.get('/auth/account',
          options: Options(headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          }));
      return UserModel.fromJson(response.data['user']);
    } on DioException catch (e) {
      printE(
          "[DioException] loại lỗi: ${e.type}, thông điệp lỗi: ${e.message}");
    } catch (e) {
      printE("Lỗi không xác định: ${e.toString()}");
    }
    return null;
  }

  @override
  Future<bool> putUser(User user, String password) async {
    try {
      final accessToken = await tokenRepository.getAccessToken();

      if (accessToken == null) {
        throw Exception("Token truy cập không tồn tại");
      }

      final response = await dio.put(
        '/user/update',
        options: Options(headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        }),
        data: {
          "fullName": user.fullName,
          "phoneNumber": user.phoneNumber,
          "password": password,
        },
      );
      return response.statusCode == 201;
    } on DioException catch (e) {
      printE(
          "[DioException] loại lỗi: ${e.type}, thông điệp lỗi: ${e.message}");
      return false;
    } catch (e) {
      printE("Lỗi không xác định: ${e.toString()}");
      return false;
    }
  }
}
