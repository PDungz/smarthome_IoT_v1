import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthome_iot/core/constants/colors/app_colors.dart';
import 'package:smarthome_iot/core/constants/icons/app_icons.dart';
import 'package:smarthome_iot/core/enums/status_state.dart';
import 'package:smarthome_iot/core/services/injection_container.dart';
import 'package:smarthome_iot/core/utils/format_date_util.dart';
import 'package:smarthome_iot/features/notification/data/repositories/notification_action_repository_impl.dart';
import 'package:smarthome_iot/features/notification/presentation/logic_bloc/bloc_notification_action/notification_action_bloc.dart';
import 'package:smarthome_iot/features/notification/presentation/view/notification_session.dart';
import 'package:smarthome_iot/features/notification/presentation/view/notification_session_loading.dart';

import '../../../l10n/generated/app_localizations.dart';

class NotificationRoutes extends StatefulWidget {
  const NotificationRoutes({super.key});

  @override
  State<NotificationRoutes> createState() => _NotificationRoutesState();
}

class _NotificationRoutesState extends State<NotificationRoutes> {
  late final TextEditingController searchTextController;

  @override
  void initState() {
    searchTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotificationActionBloc>(
      create: (context) => NotificationActionBloc(
        NotificationActionRepositoryImpl(
          notificationActionRemoteDatasource: getIt(),
        ),
      )..add(LoadNotificationAction()),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              const SizedBox(height: 10),
              // Search Bar
              TextFormField(
                controller: searchTextController,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.searching,
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.iconSecondarColor,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                ),
              ),
              const SizedBox(height: 16),
              // Notifications List
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: BlocBuilder<NotificationActionBloc,
                      NotificationActionState>(
                    builder: (context, state) {
                      if (state is NotificationActionLoaded) {
                        if (state.status == StatusState.loading) {
                          return ListView.builder(
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return const NotificationSessionLoading();
                            },
                          );
                        } else if (state.status == StatusState.success &&
                            state.notifications != null &&
                            state.notifications!.isNotEmpty) {
                          // Hiển thị danh sách thông báo nếu có dữ liệu
                          return ListView.builder(
                            itemCount: state.notifications!.length,
                            itemBuilder: (context, index) {
                              final notification = state.notifications![index];
                              return NotificationSession(
                                iconsPath: AppIcons.warning_regular,
                                type: notification.type,
                                message: notification.message,
                                timeOfDay:
                                    DateUtil.formatHour(notification.createdAt),
                              );
                            },
                          );
                        } else if (state.notifications == null ||
                            state.notifications!.isEmpty) {
                          // Trường hợp không có thông báo
                          return const Center(
                              child: Text("No notifications found"));
                        }
                      }
                      return const SizedBox();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
