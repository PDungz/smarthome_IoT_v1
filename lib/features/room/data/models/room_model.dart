import 'package:smarthome_iot/features/room/domain/entities/room.dart';

class RoomModel extends Room {
  RoomModel({
    required super.id,
    required super.name,
    required super.description,
    required super.userID,
    required super.createdAt,
    required super.updatedAt,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      userID: json['userID'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}
