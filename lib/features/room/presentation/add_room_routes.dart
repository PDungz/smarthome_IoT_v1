import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthome_iot/core/constants/colors/app_colors.dart';
import 'package:smarthome_iot/core/services/injection_container.dart';
import 'package:smarthome_iot/features/room/data/repositories/room_repository_impl.dart';
import 'package:smarthome_iot/features/room/presentation/logic_holder/bloc_room/room_bloc.dart';
import 'package:smarthome_iot/features/room/presentation/views/text_field_form_room_session.dart';
import '../../../core/enums/status_state.dart';
import '../../../core/routes/app_routes.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../domain/entities/room.dart';

class AddRoomRoutes extends StatefulWidget {
  const AddRoomRoutes({super.key});

  @override
  State<AddRoomRoutes> createState() => _AddRoomRoutesState();
}

class _AddRoomRoutesState extends State<AddRoomRoutes> {
  late final TextEditingController roomController;
  late final TextEditingController descriptionTexController;
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    roomController = TextEditingController();
    descriptionTexController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RoomBloc>(
      create: (context) =>
          RoomBloc(RoomRepositoryImpl(remoteDatasource: getIt()))
            ..add(LoadRooms()),
      child: BlocConsumer<RoomBloc, RoomState>(
        listener: (context, state) {
          if (state is RoomPost) {
            // Show dialog instead of SnackBar
            if (state.status == StatusState.success) {
              _showDialog("Success", "Room added successfully");
              roomController.clear();
              descriptionTexController.clear();
            } else if (state.status == StatusState.failure) {
              _showDialog("Error", state.Msg ?? "Failed to add room");
            }
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
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
                        AppLocalizations.of(context)!.add_room,
                        style:
                            Theme.of(context).textTheme.headlineLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimaryColor,
                                ),
                      ),
                      const SizedBox(height: 20),
                      TextFieldFormRoomSession(
                        roomController: roomController,
                        descriptionTexController: descriptionTexController,
                      ),
                      const SizedBox(height: 24),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_keyForm.currentState?.validate() ?? false) {
                              BlocProvider.of<RoomBloc>(context).add(
                                PostRoom(
                                  room: Room(
                                    id: "",
                                    name: roomController.text,
                                    description: descriptionTexController.text,
                                    userID: "",
                                    createdAt: DateTime.now(),
                                    updatedAt: DateTime.now(),
                                  ),
                                ),
                              );
                            }
                          },
                          child: Text(AppLocalizations.of(context)!.add),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
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
                arguments: [3, ""],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    roomController.dispose();
    descriptionTexController.dispose();
    super.dispose();
  }
}
