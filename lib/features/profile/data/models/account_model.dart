import 'package:smarthome_iot/features/profile/domain/entities/account_entity.dart';

class AccountModel extends AccountEntity {
  @override
  final String? avatarUrl;
  @override
  final String? fullName;
  @override
  final String? phoneNumber;
  @override
  final String? password;

  const AccountModel({
    this.avatarUrl,
    this.fullName,
    this.phoneNumber,
    this.password,
  }) : super(
          avatarUrl: avatarUrl,
          fullName: fullName,
          phoneNumber: phoneNumber,
          password: password,
        );

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      avatarUrl: json['avatar_url'] as String?,
      fullName: json['full_name'] as String?,
      phoneNumber: json['phone_number'] as String?,
      password: json['password'] as String?,
    );
  }

  Map<String, dynamic> toJsonNonNull() {
    Map<String, dynamic> result = {};
    if (avatarUrl != null) {
      result['avatar_url'] = avatarUrl;
    }
    if (fullName != null) {
      result['full_name'] = fullName;
    }
    if (phoneNumber != null) {
      result['phone_number'] = phoneNumber;
    }
    if (password != null) {
      result['password'] = password;
    }
    return result;
  }
}
