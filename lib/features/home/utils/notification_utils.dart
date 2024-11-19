// core/services/notification_service.dart
import 'package:smarthome_iot/core/constants/components/components_notification/notification_component.dart';

class NotificationUtils {
  static const double gasThreshold = 850.0;
  static const double humidityThreshold = 30.0;
  static const double temperatureThreshold = 45.0;

  static void checkAndSendNotifications({
    required double gasValue,
    required double humidity,
    required double temperature,
  }) {
    // Gas Level Alert
    if (gasValue > gasThreshold) {
      NotificationComponent.sendBasicNotification(
        id: 1,
        title: 'Warning: High Gas Level',
        body: 'Gas level has reached $gasValue. Please check ventilation!',
      );
    }

    // Humidity Alert
    if (humidity < humidityThreshold) {
      NotificationComponent.sendBasicNotification(
        id: 2,
        title: 'Warning: High Humidity',
        body: 'Humidity level is at $humidity%. Consider dehumidifying!',
      );
    }

    // Temperature Alert
    if (temperature > temperatureThreshold) {
      NotificationComponent.sendBasicNotification(
        id: 3,
        title: 'Warning: High Temperature',
        body: 'Temperature is at $temperature°C. Please take action!',
      );
    }
  }
}
