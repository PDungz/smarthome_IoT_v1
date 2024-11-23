import 'package:flutter/material.dart';
import 'package:smarthome_iot/features/add/presentation/view/accesskey_session.dart';
import 'package:smarthome_iot/features/add/presentation/view/device_session.dart';

import '../../../core/constants/icons/app_icons.dart';
import '../../../l10n/generated/app_localizations.dart';
import 'view/room_session.dart';

class AddRoutes extends StatelessWidget {
  const AddRoutes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 32),
        child: Column(
          children: [
            RoomSession(
                iconPath: AppIcons.DOOR,
                title: AppLocalizations.of(context)!.room),
            DeviceSession(
                iconPath: AppIcons.screwdriver_wrench_solid,
                title: AppLocalizations.of(context)!.device),
            AccesskeySession(iconPath: AppIcons.KEY, title: "Access Key"),
          ],
        ),
      ),
    );
  }
}
