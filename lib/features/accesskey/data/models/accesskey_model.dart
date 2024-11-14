import '../../domain/entities/accesskey.dart';

class AccessKeyModel extends AccessKey {
  AccessKeyModel({
    required super.id,
    required super.accessKey,
    required super.userID,
    required super.createdAt,
    required super.updatedAt,
  });

  factory AccessKeyModel.fromJson(Map<String, dynamic> json) {
    return AccessKeyModel(
      id: json['_id'] as String,
      accessKey: json['accessKey'] as String,
      userID: json['userID'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}
