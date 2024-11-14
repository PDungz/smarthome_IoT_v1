// ignore_for_file: public_member_api_docs, sort_constructors_first
class Room {
  final String id;
  final String name;
  final String description;
  final String userID;
  final DateTime createdAt;
  final DateTime updatedAt;

  Room({
    required this.id,
    required this.name,
    required this.description,
    required this.userID,
    required this.createdAt,
    required this.updatedAt,
  });

  Room copyWith({
    String? id,
    String? name,
    String? description,
    String? userID,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Room(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      userID: userID ?? this.userID,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
