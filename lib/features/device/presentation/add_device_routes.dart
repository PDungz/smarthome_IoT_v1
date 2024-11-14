import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthome_iot/core/enums/status_state.dart';
import 'package:smarthome_iot/core/services/injection_container.dart';
import 'package:smarthome_iot/core/services/websocket_service.dart';
import 'package:smarthome_iot/features/device/data/repositories/device_repository_impl.dart';
import 'package:smarthome_iot/features/device/domain/entities/device.dart';
import 'package:smarthome_iot/features/device/presentation/logic_holder/bloc_device/device_bloc.dart';
import 'package:smarthome_iot/features/device/presentation/views/text_field_form_device_session.dart';
import 'package:smarthome_iot/features/room/data/repositories/room_repository_impl.dart';
import 'package:smarthome_iot/features/room/presentation/logic_holder/bloc_room/room_bloc.dart';
import '../../../core/constants/colors/app_colors.dart';

import '../../../core/constants/components/components_shimmer/shimmer_loading.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/services/logger_service.dart';
import '../../../l10n/generated/app_localizations.dart';

class AddDeviceRoutes extends StatefulWidget {
  const AddDeviceRoutes({super.key});

  @override
  State<AddDeviceRoutes> createState() => _AddDeviceRoutesState();
}

class _AddDeviceRoutesState extends State<AddDeviceRoutes> {
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  late final TextEditingController nameController;
  late final TextEditingController descriptionTexController;
  String selectedRoomId = '';
  String selectedType = 'LIGHT';
  String selectedGate = 'D0';

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    descriptionTexController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RoomBloc>(
            create: (context) =>
                RoomBloc(RoomRepositoryImpl(remoteDatasource: getIt()))
                  ..add(LoadRooms())),
        BlocProvider(
          create: (context) => DeviceBloc(
              DeviceRepositoryImpl(remoteDatasource: getIt()),
              WebSocketService(),
              getIt())
            ..add(const LoadDeviceByRoomId()),
        )
      ],
      child: BlocConsumer<DeviceBloc, DeviceState>(
        listener: (context, state) {
          if (state is DevicePostSuccess) {
            if (state.state == StatusState.success) {
              _showDialog("Success", "Device added succcessfully");
              nameController.clear();
              descriptionTexController.clear();
            } else if (state.state == StatusState.failure) {
              _showDialog("Error", state.message ?? "Failed to add device");
            }
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 20),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: AppColors.backgroundColor,
                      ),
                      child: Form(
                        key: _keyForm,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              AppLocalizations.of(context)!.add_device,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimaryColor,
                                  ),
                            ),
                            const SizedBox(height: 20),
                            BlocBuilder<RoomBloc, RoomState>(
                              builder: (context, state) {
                                if (state is RoomLoading) {
                                  return const ShimmerLoading();
                                } else if (state is RoomsLoaded) {
                                  final rooms = state.rooms;
                                  selectedRoomId = selectedRoomId == ''
                                      ? rooms.first.id
                                      : selectedRoomId;
                                  return TextFieldFormDeviceSession(
                                    rooms: rooms,
                                    nameController: nameController,
                                    descriptionTexController:
                                        descriptionTexController,
                                    selectedType: selectedType,
                                    selectedGate: selectedGate,
                                    selectedRoomId: selectedRoomId,
                                    onTypeChanged: (value) => setState(() {
                                      selectedType = value!;
                                    }),
                                    onGateChanged: (value) => setState(() {
                                      selectedGate = value!;
                                    }),
                                    onRoomChanged: (value) => setState(() {
                                      selectedRoomId = value!;
                                    }),
                                  );
                                }
                                return const ShimmerLoading();
                              },
                            ),
                            const SizedBox(height: 24),
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_keyForm.currentState?.validate() ??
                                      false) {
                                    printE(
                                        "${nameController.text} -- ${descriptionTexController.text} -- $selectedRoomId -- $selectedGate -- $selectedType");
                                    BlocProvider.of<DeviceBloc>(context).add(
                                        PostDevice(
                                            device: Device(
                                                id: "",
                                                name: nameController.text,
                                                description:
                                                    descriptionTexController
                                                        .text,
                                                state: "OFF",
                                                type: selectedType,
                                                gate: selectedGate,
                                                roomID: selectedRoomId,
                                                userID: "",
                                                createdAt: DateTime.now(),
                                                updatedAt: DateTime.now())));
                                  }
                                },
                                child: Text(AppLocalizations.of(context)!.add),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 120),
                ],
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

  @override
  void dispose() {
    nameController.dispose();
    descriptionTexController.dispose();
    super.dispose();
  }
}
