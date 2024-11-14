import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smarthome_iot/core/routes/app_routes.dart';
import 'package:smarthome_iot/features/add/presentation/add_routes.dart';
import 'package:smarthome_iot/features/device/presentation/add_device_routes.dart';
import 'package:smarthome_iot/features/device/presentation/update_device_routes.dart';
import 'package:smarthome_iot/features/entry_point/presentation/entry_point.dart';
import 'package:smarthome_iot/features/home/presentation/home_routes.dart';
import 'package:smarthome_iot/features/login/presentation/screens/login_routes.dart';
import 'package:smarthome_iot/features/notification/presentation/notification_routes.dart';
import 'package:smarthome_iot/features/profile/presentation/profile_routes.dart';
import 'package:smarthome_iot/features/room/presentation/add_room_routes.dart';
import 'package:smarthome_iot/features/room/presentation/update_room_routes.dart';
import 'package:smarthome_iot/features/setting/presentation/setting_routes.dart';

import '../../features/device/presentation/view_device_routes.dart';
import '../../features/room/presentation/view_room_routes.dart';

class AppGenerateRoutes {
  static Route? onGenerate(RouteSettings settings) {
    final route = settings.name;

    switch (route) {
      // Login
      case AppRoutes.login:
        return CupertinoPageRoute(builder: (_) => const LoginRoutes());

      // Entry point
      case AppRoutes.entry_point:
        final args = settings.arguments as List<dynamic>? ?? [0, ''];
        final int initialIndex = args[0] as int;
        final String id = args[1] as String;
        return CupertinoPageRoute(
          builder: (_) => EntryPoint(initialIndex: initialIndex, id: id),
        );
      // Home
      case AppRoutes.home:
        return CupertinoPageRoute(builder: (_) => const HomeRoutes());

      // Room
      case AppRoutes.view_room:
        return CupertinoPageRoute(builder: (_) => const ViewRoomRoutes());

      case AppRoutes.add_room:
        return CupertinoPageRoute(builder: (_) => const AddRoomRoutes());

      case AppRoutes.update_room:
        return CupertinoPageRoute(builder: (_) => const UpdateRoomRoutes());

      // Device
      case AppRoutes.view_device:
        return CupertinoPageRoute(builder: (_) => const ViewDeviceRoutes());

      case AppRoutes.add_device:
        return CupertinoPageRoute(builder: (_) => const AddDeviceRoutes());

      case AppRoutes.update_device:
        return CupertinoPageRoute(builder: (_) => const UpdateDeviceRoutes());

      // Add
      case AppRoutes.add:
        return CupertinoPageRoute(builder: (_) => const AddRoutes());

      // Notification
      case AppRoutes.notification:
        return CupertinoPageRoute(builder: (_) => const NotificationRoutes());

      // Setting
      case AppRoutes.profile:
        final userId = settings.arguments as String;
        return CupertinoPageRoute(
            builder: (_) => ProfileRoutes(
                  userId: userId,
                ));

      // Setting
      case AppRoutes.setting:
        return CupertinoPageRoute(builder: (_) => const SettingRoutes());
    }
    return null;
  }
}
