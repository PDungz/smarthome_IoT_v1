import 'package:flutter/material.dart';
import 'package:smarthome_iot/features/room/domain/entities/room.dart';

import '../../../../core/utils/validators.dart';
import 'dropdown_device_session.dart';
import 'text_field_device_session.dart';

class TextFieldFormDeviceSession extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController descriptionTexController;
  final String selectedRoomId;
  final String selectedType;
  final String selectedGate;
  final ValueChanged<String?> onTypeChanged;
  final ValueChanged<String?> onGateChanged;
  final ValueChanged<String?> onRoomChanged;
  final List<Room> rooms;

  const TextFieldFormDeviceSession({
    super.key,
    required this.nameController,
    required this.descriptionTexController,
    required this.selectedRoomId,
    required this.selectedType,
    required this.selectedGate,
    required this.onTypeChanged,
    required this.onGateChanged,
    required this.onRoomChanged,
    required this.rooms,
  });

  @override
  State<TextFieldFormDeviceSession> createState() =>
      _TextFieldFormDeviceSessionState();
}

class _TextFieldFormDeviceSessionState
    extends State<TextFieldFormDeviceSession> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldDeviceSession(
          fieldName: "Name",
          textEditingController: widget.nameController,
          validator: Validators.requirdWithFieldName('Name').call,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        ),
        const SizedBox(height: 8),
        TextFieldDeviceSession(
          fieldName: "Description",
          textEditingController: widget.descriptionTexController,
          maxLines: 2,
          validator: Validators.requirdWithFieldName('Description').call,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        ),
        const SizedBox(height: 8),
        DropdownDeviceSession<String>(
          title: "Type",
          hintText: 'LIGHT',
          selectedId: widget.selectedType,
          items: const [
            'LIGHT',
            'FAN',
            'SERVO',
            'GAS',
            'TEMPERATURE_HUMIDITY',
            'KLAXON',
            'AIR_CONDITIONER'
          ],
          onChanged: widget.onTypeChanged,
          getId: (type) => type,
          getName: (type) => type,
        ),
        const SizedBox(height: 8),
        DropdownDeviceSession<String>(
          title: "Gate",
          hintText: 'D0',
          selectedId: widget.selectedGate,
          items: const [
            'D0',
            'A0',
            'D1',
            'D2',
            'D3',
            'D4',
            'D5',
            'D6',
            'D7',
            'D8'
          ],
          onChanged: widget.onGateChanged,
          getId: (gate) => gate,
          getName: (gate) => gate,
        ),
        const SizedBox(height: 8),
        DropdownDeviceSession(
          title: "Room",
          hintText: 'Select Room',
          selectedId: widget.selectedRoomId,
          items: widget.rooms,
          onChanged: widget.onRoomChanged,
          getId: (room) => room.id,
          getName: (room) => room.name,
        )
      ],
    );
  }
}
