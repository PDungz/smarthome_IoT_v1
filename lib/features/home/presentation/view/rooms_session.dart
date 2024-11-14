import 'package:flutter/material.dart';
import '../../../../core/constants/colors/app_colors.dart';

class RoomsSession extends StatefulWidget {
  final List rooms;
  final Function(String) onRoomSelected; // Add this line
  const RoomsSession(
      {super.key,
      required this.rooms,
      required this.onRoomSelected}); // Update constructor

  @override
  State<RoomsSession> createState() => _RoomsSessionState();
}

class _RoomsSessionState extends State<RoomsSession> {
  int indexRoom = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.rooms.length,
        itemBuilder: (context, index) {
          return SizedBox(
            width: 160,
            child: ListTile(
              title: indexRoom == index
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.rooms[index].name,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimaryColor,
                                  ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Divider(
                            color: AppColors.buttonColor,
                          ),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.rooms[index].name,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textSecondarColor,
                                  ),
                        ),
                      ],
                    ),
              onTap: () {
                setState(() {
                  // Move the selected room to the front of the list
                  var selectedRoom = widget.rooms[index];
                  widget.rooms.removeAt(index);
                  widget.rooms.insert(0, selectedRoom);
                  // Update the index of the current room
                  indexRoom =
                      0; // Set it to 0 since the selected room is now at the top
                  widget.onRoomSelected(selectedRoom.id); // Update the roomId
                });
              },
            ),
          );
        },
      ),
    );
  }
}
