import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthome_iot/core/constants/icons/app_icons.dart';
import 'package:smarthome_iot/core/services/injection_container.dart';
import 'package:smarthome_iot/features/room/data/repositories/room_repository_impl.dart';
import 'package:smarthome_iot/features/room/presentation/logic_holder/bloc_room/room_bloc.dart';
import 'package:smarthome_iot/features/room/presentation/views/room_session.dart';
import 'package:smarthome_iot/features/room/presentation/views/room_session_loading.dart';

import '../../../core/constants/colors/app_colors.dart';
import '../../../core/enums/status_state.dart';
import '../../../core/routes/app_routes.dart';

class ViewRoomRoutes extends StatefulWidget {
  const ViewRoomRoutes({super.key});

  @override
  State<ViewRoomRoutes> createState() => _ViewRoomRoutesState();
}

class _ViewRoomRoutesState extends State<ViewRoomRoutes> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RoomBloc>(
      create: (context) =>
          RoomBloc(RoomRepositoryImpl(remoteDatasource: getIt()))
            ..add(LoadRooms()),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: BlocConsumer<RoomBloc, RoomState>(
            listener: (context, state) {
              if (state is RoomDelete) {
                if (state.status == StatusState.success) {
                  _showDialog("Success", "Room deleted successfully");
                  BlocProvider.of<RoomBloc>(context).add(LoadRooms());
                } else if (state.status == StatusState.failure) {
                  _showDialog("Error", state.Msg ?? "Failed to delete room");
                }
              }
            },
            builder: (context, state) {
              if (state is RoomLoading) {
                return ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  scrollDirection: Axis.vertical,
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    return const ListTile(
                      title: RoomSessionLoading(),
                    );
                  },
                );
              } else if (state is RoomsLoaded) {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: state.rooms.length + 1,
                  itemBuilder: (context, index) {
                    if (index < state.rooms.length) {
                      return ListTile(
                        title: RoomSession(
                          iconRoom: AppIcons.DOOR,
                          room: state.rooms[index],
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
                      title: RoomSessionLoading(),
                    );
                  },
                ),
              );
            },
          ),
        ),
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
}
