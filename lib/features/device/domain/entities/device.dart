// ignore_for_file: public_member_api_docs, sort_constructors_first
class Device {
  final String id;
  final String name;
  final String description;
  final String state;
  final String type;
  final String gate;
  final String roomID;
  final String userID;
  final DateTime createdAt;
  final DateTime updatedAt;

  Device({
    required this.id,
    required this.name,
    required this.description,
    required this.state,
    required this.type,
    required this.gate,
    required this.roomID,
    required this.userID,
    required this.createdAt,
    required this.updatedAt,
  });

  Device copyWith({
    String? id,
    String? name,
    String? description,
    String? state,
    String? type,
    String? gate,
    String? roomID,
    String? userID,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Device(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      state: state ?? this.state,
      type: type ?? this.type,
      gate: gate ?? this.gate,
      roomID: roomID ?? this.roomID,
      userID: userID ?? this.userID,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
