import 'package:smarthome_iot/features/device/domain/entities/device.dart';

class DeviceModel extends Device {
  DeviceModel({
    required super.id,
    required super.name,
    required super.description,
    required super.state,
    required super.type,
    required super.gate,
    required super.roomID,
    required super.userID,
    required super.createdAt,
    required super.updatedAt,
  });

  factory DeviceModel.fromJson(Map<String, dynamic> json) {
    return DeviceModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      state: json['state'] as String,
      type: json['type'] as String,
      gate: json['gate'] as String,
      roomID: json['roomID'] as String,
      userID: json['userID'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}
