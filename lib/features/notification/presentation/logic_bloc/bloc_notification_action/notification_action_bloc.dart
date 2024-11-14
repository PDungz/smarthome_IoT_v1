import 'package:bloc/bloc.dart';
import 'package:smarthome_iot/core/enums/status_state.dart';
import 'package:smarthome_iot/features/notification/domain/entities/notification_action.dart';
import 'package:smarthome_iot/features/notification/domain/repositories/notification_action_repository.dart';

import '../../../../../core/services/logger_service.dart';

part 'notification_action_event.dart';
part 'notification_action_state.dart';

class NotificationActionBloc
    extends Bloc<NotificationActionEvent, NotificationActionState> {
  final NotificationActionRepository notificationActionRepository;

  NotificationActionBloc(
    this.notificationActionRepository,
  ) : super(NotificationActionInitial()) {
    on<LoadNotificationAction>(_onLoadNotificationAction);
  }

  Future<void> _onLoadNotificationAction(LoadNotificationAction event,
      Emitter<NotificationActionState> emit) async {
    emit(NotificationActionLoaded(status: StatusState.loading));

    try {
      final notifications =
          await notificationActionRepository.getNotificationAction();
      // Check if notifications list is not null or empty
      print("Fetched Notifications: $notifications");
      if (notifications != null && notifications.isNotEmpty) {
        emit(NotificationActionLoaded(
            notifications: notifications, status: StatusState.success));
      } else {
        emit(NotificationActionLoaded(
            notifications: [], status: StatusState.success));
      }
    } catch (e) {
      printE("[NotificationActionBloc] - Error: $e");
      emit(NotificationActionLoaded(status: StatusState.idle));
    }
  }
}
