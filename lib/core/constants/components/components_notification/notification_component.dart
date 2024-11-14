// notification_component.dart
import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationComponent {
  // Method to send a basic notification
  static void sendBasicNotification({
    required int id,
    required String title,
    required String body,
  }) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'basic_channel',
        title: title,
        body: body,
        icon: 'resource://drawable/res_app_icon', // Default icon
      ),
    );
  }

  // Method to send a notification with custom sound and icon
  static void sendCustomNotification({
    required int id,
    required String title,
    required String body,
    String? soundSource,
    String? icon,
  }) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'basic_channel',
        title: title,
        body: body,
        icon: icon ?? 'resource://drawable/res_app_icon',
        notificationLayout: NotificationLayout.Default,
      ),
    );
  }
}
