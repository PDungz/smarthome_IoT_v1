import 'package:smarthome_iot/features/notification/domain/entities/notification_action.dart';

abstract class NotificationActionRepository {
  Future<List<NotificationAction>?> getNotificationAction();
}
