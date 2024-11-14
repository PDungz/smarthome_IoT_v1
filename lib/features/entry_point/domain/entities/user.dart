// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final String id;
  final String fullName;
  final String phoneNumber;
  final DateTime createdAt;
  final DateTime updatedAt;
  User({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.createdAt,
    required this.updatedAt,
  });

  User copyWith({
    String? id,
    String? fullName,
    String? phoneNumber,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
