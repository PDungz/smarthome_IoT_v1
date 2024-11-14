import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthome_iot/core/services/injection_container.dart';
import 'package:smarthome_iot/core/services/websocket_service.dart';
import 'package:smarthome_iot/features/device/data/repositories/device_repository_impl.dart';
import 'package:smarthome_iot/features/device/presentation/logic_holder/bloc_device/device_bloc.dart';
import 'package:smarthome_iot/features/device/presentation/views/device_session.dart';
import 'package:smarthome_iot/features/device/presentation/views/device_session_loading.dart';

import '../../../core/constants/colors/app_colors.dart';
import '../../../core/constants/icons/app_icons.dart';
import '../../../core/enums/status_state.dart';
import '../../../core/routes/app_routes.dart';

class ViewDeviceRoutes extends StatefulWidget {
  const ViewDeviceRoutes({super.key});

  @override
  State<ViewDeviceRoutes> createState() => _ViewDeviceRoutesState();
}

class _ViewDeviceRoutesState extends State<ViewDeviceRoutes> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<DeviceBloc>(
      create: (context) => DeviceBloc(
          DeviceRepositoryImpl(remoteDatasource: getIt()),
          WebSocketService(),
          getIt())
        ..add(LoadDevices()),
      child: BlocConsumer<DeviceBloc, DeviceState>(
        listener: (context, state) {
          if (state is DeviceDeleted) {
            if (state.state == StatusState.success) {
              _showDialog("Success", "Device deleted succcessfully");
            } else if (state.state == StatusState.failure) {
              _showDialog("Error", state.message ?? "Failed to delete device");
            }
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: BlocBuilder<DeviceBloc, DeviceState>(
                builder: (context, state) {
                  if (state is DeviceLoading) {
                    return ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      scrollDirection: Axis.vertical,
                      itemCount: 12,
                      itemBuilder: (context, index) {
                        return const ListTile(
                          title: DeviceSessionLoading(),
                        );
                      },
                    );
                  } else if (state is DevicesLoaded) {
                    Map icons = {
                      'LIGHT': AppIcons.LIGHT,
                      'FAN': AppIcons.FAN,
                      'SERVO': AppIcons.DOOR,
                      'KLAXON': AppIcons.KLAXON,
                      'AIR_CONDITIONER': AppIcons.FAN
                    };
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: state.devices.length + 1,
                      itemBuilder: (context, index) {
                        if (index < state.devices.length) {
                          return ListTile(
                            title: DeviceSession(
                              iconDevice: icons[state.devices[index].type],
                              device: state.devices[index],
                            ),
                          );
                        } else {
                          return const ListTile(title: SizedBox(height: 96));
                        }
                      },
                    );
                  }
                  return Center(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      scrollDirection: Axis.vertical,
                      itemCount: 12,
                      itemBuilder: (context, index) {
                        return const ListTile(
                          title: DeviceSessionLoading(),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.backgroundColor,
          title: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: AppColors.textPrimaryColor),
          ),
          content: Text(
            message,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: AppColors.textSecondarColor),
          ),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () => Navigator.pushNamed(
                context,
                AppRoutes.entry_point,
                arguments: [6, ""],
              ),
            ),
          ],
        );
      },
    );
  }
}
