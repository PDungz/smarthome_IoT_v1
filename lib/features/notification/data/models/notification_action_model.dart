import 'package:smarthome_iot/features/notification/domain/entities/notification_action.dart';

class NotificationActionModel extends NotificationAction {
  NotificationActionModel({
    required super.id,
    required super.message,
    required super.userId,
    required super.type,
    required super.createdAt,
    required super.updatedAt,
  });

  factory NotificationActionModel.fromJson(Map<String, dynamic> json) {
    return NotificationActionModel(
      id: json['_id'] as String,
      message: json['message'] as String,
      userId: json['userID'] as String,
      type: json['type'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}
