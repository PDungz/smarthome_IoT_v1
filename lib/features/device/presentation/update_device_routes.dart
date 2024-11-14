import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthome_iot/core/services/injection_container.dart';
import 'package:smarthome_iot/features/device/presentation/views/text_field_form_device_session.dart';
import 'package:smarthome_iot/features/room/data/repositories/room_repository_impl.dart';
import 'package:smarthome_iot/features/room/presentation/logic_holder/bloc_room/room_bloc.dart';
import '../../../core/constants/colors/app_colors.dart';
import '../../../core/constants/components/components_shimmer/shimmer_loading.dart';
import '../../../core/enums/status_state.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/services/logger_service.dart';
import '../../../core/services/websocket_service.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../data/repositories/device_repository_impl.dart';
import '../domain/entities/device.dart';
import 'logic_holder/bloc_device/device_bloc.dart';

class UpdateDeviceRoutes extends StatefulWidget {
  final String? deviceId;
  const UpdateDeviceRoutes({super.key, this.deviceId});

  @override
  State<UpdateDeviceRoutes> createState() => _UpdateDeviceRoutesState();
}

class _UpdateDeviceRoutesState extends State<UpdateDeviceRoutes> {
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
    printE("${widget.deviceId}");
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
            ..add(LoadDeviceById(deviceId: widget.deviceId)),
        )
      ],
      child: BlocConsumer<DeviceBloc, DeviceState>(
        listener: (context, state) {
          if (state is DevicePutSuccess) {
            if (state.state == StatusState.success) {
              _showDialog("Success", "Device updated succcessfully");
              nameController.clear();
              descriptionTexController.clear();
            } else if (state.state == StatusState.failure) {
              _showDialog("Error", state.message ?? "Failed to update device");
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
                      child: BlocBuilder<DeviceBloc, DeviceState>(
                        builder: (context, state) {
                          if (state is DeviceLoading) {
                            return const ShimmerLoading();
                          } else if (state is DeviceLoaded) {
                            nameController.text = state.device.name;
                            descriptionTexController.text =
                                state.device.description;
                            selectedType = state.device.type;
                            selectedGate = state.device.gate;
                            if (selectedRoomId == '') {
                              selectedRoomId = state.device.roomID;
                            }
                            return Form(
                              key: _keyForm,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 20),
                                  Text(
                                    AppLocalizations.of(context)!.update_device,
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
                                        // selectedRoomId = selectedRoomId == ''
                                        //     ? rooms.first.id
                                        //     : selectedRoomId;
                                        return TextFieldFormDeviceSession(
                                          rooms: rooms,
                                          nameController: nameController,
                                          descriptionTexController:
                                              descriptionTexController,
                                          selectedType: selectedType,
                                          selectedGate: selectedGate,
                                          selectedRoomId: selectedRoomId,
                                          onTypeChanged: (value) =>
                                              setState(() {
                                            selectedType = value!;
                                          }),
                                          onGateChanged: (value) =>
                                              setState(() {
                                            selectedGate = value!;
                                          }),
                                          onRoomChanged: (value) =>
                                              setState(() {
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
                                          BlocProvider.of<DeviceBloc>(context)
                                              .add(PutDevice(
                                                  device: Device(
                                                      id: state.device.id,
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
                                                      updatedAt:
                                                          DateTime.now())));
                                        }
                                      },
                                      child: Text(
                                          AppLocalizations.of(context)!.update),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          return const SizedBox();
                        },
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
