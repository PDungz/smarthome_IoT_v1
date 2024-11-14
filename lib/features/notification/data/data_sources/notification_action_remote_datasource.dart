// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:smarthome_iot/features/login/domain/repositories/token_repository.dart';
import 'package:smarthome_iot/features/notification/data/models/notification_action_model.dart';
import 'package:smarthome_iot/features/notification/domain/entities/notification_action.dart';

import '../../../../core/services/logger_service.dart';

abstract class NotificationActionRemoteDatasource {
  Future<List<NotificationAction>?> getNotificationAction();
}

class NotificationActionRemoteDatasourceImpl
    implements NotificationActionRemoteDatasource {
  final Dio dio;
  final TokenRepository tokenRepository;

  NotificationActionRemoteDatasourceImpl({
    required this.dio,
    required this.tokenRepository,
  });

  @override
  Future<List<NotificationAction>?> getNotificationAction() async {
    try {
      final accessToken = await tokenRepository.getAccessToken();
      if (accessToken == null) {
        throw Exception("Token truy cập không tồn tại");
      }
      final response = await dio.get('/notification/get-by-user',
          options: Options(headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'appliation/json',
          }));
      final List<dynamic> notificationJson = response.data['notifications'];
      return notificationJson
          .map((json) => NotificationActionModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      printE(
          "[DioException] loại lỗi: ${e.type}, thông điệp lỗi: ${e.message}");
    } catch (e) {
      printE("Lỗi không xác định: ${e.toString()}");
    }
    return null;
  }
}
