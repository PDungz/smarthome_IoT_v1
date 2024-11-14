// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'notification_action_bloc.dart';

abstract class NotificationActionState {}

class NotificationActionInitial extends NotificationActionState {}

class NotificationActionLoaded extends NotificationActionState {
  final List<NotificationAction>? notifications;
  final StatusState status;
  final String? Mgs;
  NotificationActionLoaded({
    this.notifications,
    this.status = StatusState.idle,
    this.Mgs,
  });

  NotificationActionLoaded copyWith({
    List<NotificationAction>? notifications,
    StatusState? state,
    String? Mgs,
  }) {
    return NotificationActionLoaded(
      notifications: notifications ?? this.notifications,
      status: state ?? status,
      Mgs: Mgs ?? this.Mgs,
    );
  }
}
