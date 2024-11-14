// ignore_for_file: public_member_api_docs, sort_constructors_first
class AccessKey {
  final String id;
  final String accessKey;
  final String userID;
  final DateTime createdAt;
  final DateTime updatedAt;

  AccessKey({
    required this.id,
    required this.accessKey,
    required this.userID,
    required this.createdAt,
    required this.updatedAt,
  });

  AccessKey copyWith({
    String? id,
    String? accessKey,
    String? userID,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AccessKey(
      id: id ?? this.id,
      accessKey: accessKey ?? this.accessKey,
      userID: userID ?? this.userID,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
