// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:smarthome_iot/features/notification/data/data_sources/notification_action_remote_datasource.dart';
import 'package:smarthome_iot/features/notification/domain/entities/notification_action.dart';
import 'package:smarthome_iot/features/notification/domain/repositories/notification_action_repository.dart';

class NotificationActionRepositoryImpl implements NotificationActionRepository {
  final NotificationActionRemoteDatasource notificationActionRemoteDatasource;

  NotificationActionRepositoryImpl({
    required this.notificationActionRemoteDatasource,
  });

  @override
  Future<List<NotificationAction>?> getNotificationAction() async {
    return await notificationActionRemoteDatasource.getNotificationAction();
  }
}
