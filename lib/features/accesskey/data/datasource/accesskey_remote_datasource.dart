// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:smarthome_iot/core/services/logger_service.dart';
import '../../../login/domain/repositories/token_repository.dart';
import '../../domain/entities/accesskey.dart';
import '../models/accesskey_model.dart';

abstract class AccessKeyRemoteDatasource {
  Future<List<AccessKey>?> getAccessKeys();
  Future<bool> postAccessKey();
}

class AccessKeyRemoteDatasourceImpl implements AccessKeyRemoteDatasource {
  final Dio dio;
  final TokenRepository tokenRepository;

  AccessKeyRemoteDatasourceImpl({
    required this.dio,
    required this.tokenRepository,
  });

  @override
  Future<List<AccessKey>?> getAccessKeys() async {
    try {
      // Lấy token truy cập từ repository
      final accessToken = await tokenRepository.getAccessToken();
      if (accessToken == null) {
        throw Exception("Token truy cập không tồn tại");
      }

      final response = await dio.get(
        "/access-key/get-by-user",
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      final List<dynamic> roomJson = response.data['accessKeys'];

      return roomJson.map((json) => AccessKeyModel.fromJson(json)).toList();
    } on DioException catch (e) {
      printE(
          "[DioException] loại lỗi: ${e.type}, thông điệp lỗi: ${e.message}");
    } catch (e) {
      printE("Lỗi không xác định: ${e.toString()}");
    }
    return null;
  }

  @override
  Future<bool> postAccessKey() async {
    try {
      final accessToken = await tokenRepository.getAccessToken();

      if (accessToken == null) {
        throw Exception("Token truy cập không tốn tại");
      }

      final response = await dio.post(
        '/access-key/generate',
        options: Options(headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        }),
      );
      return response.statusCode == 200;
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
