// ignore_for_file: public_member_api_docs, sort_constructors_first
class NotificationAction {
  final String id;
  final String message;
  final String userId;
  final String type;
  final DateTime createdAt;
  final DateTime updatedAt;

  NotificationAction({
    required this.id,
    required this.message,
    required this.userId,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });
}
