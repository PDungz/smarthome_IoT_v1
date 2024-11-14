import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smarthome_iot/core/routes/app_routes.dart';
import 'package:smarthome_iot/features/room/domain/entities/room.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/icons/app_icons.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../logic_holder/bloc_room/room_bloc.dart';

class RoomSession extends StatefulWidget {
  final String iconRoom;
  final Room room;
  const RoomSession({
    super.key,
    required this.iconRoom,
    required this.room,
  });

  @override
  State<RoomSession> createState() => _RoomSessionState();
}

class _RoomSessionState extends State<RoomSession> {
  bool isAction = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.backgroundColor,
          ),
          child: isAction
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            padding: const EdgeInsets.all(8),
                            decoration: const ShapeDecoration(
                              color: AppColors.circleBackground,
                              shape: OvalBorder(),
                            ),
                            child: SvgPicture.asset(
                              widget
                                  .iconRoom, // Use the icon passed from HomeRoutes
                              color: AppColors.iconPrimaryColor,
                            ),
                          ),
                          const SizedBox(width: 24),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.room.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Text(
                                widget.room.description,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                        color: AppColors.textSecondarColor),
                              ),
                            ],
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                isAction = !isAction;
                              });
                            },
                            icon: const Icon(
                              Icons.keyboard_control,
                              color: AppColors.iconPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            backgroundColor: AppColors
                                .buttonUpdateColor, // Set background color
                          ),
                          onPressed: () => Navigator.pushNamed(
                              context, AppRoutes.entry_point,
                              arguments: [5, widget.room.id]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(
                                  AppIcons.screwdriver_wrench_solid),
                              const SizedBox(width: 8),
                              Text(
                                AppLocalizations.of(context)!.update,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textPrimaryColor,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 28),
                      SizedBox(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            backgroundColor: AppColors
                                .buttonDeleteColor, // Set background color
                          ),
                          onPressed: () {
                            context
                                .read<RoomBloc>()
                                .add(DeleteRoom(roomId: widget.room.id));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(AppIcons.trash_can_solid),
                              const SizedBox(width: 8),
                              Text(
                                AppLocalizations.of(context)!.delete,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textPrimaryColor,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
        isAction != true
            ? Positioned(
                top: 2,
                right: 2,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isAction = !isAction;
                    });
                  },
                  child: Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Icon(Icons.close)),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
