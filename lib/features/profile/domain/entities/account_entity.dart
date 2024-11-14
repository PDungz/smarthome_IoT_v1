// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class AccountEntity extends Equatable {
  final String? avatarUrl;
  final String? fullName;
  final String? phoneNumber;
  final String? password;

  const AccountEntity({
    this.avatarUrl,
    this.fullName,
    this.phoneNumber,
    this.password,
  });

  @override
  List<Object?> get props => [
        avatarUrl,
        fullName,
        phoneNumber,
        password,
      ];

  AccountEntity copyWith({
    String? avatarUrl,
    String? fullName,
    String? phoneNumber,
    String? password,
  }) {
    return AccountEntity(
      avatarUrl: avatarUrl ?? this.avatarUrl,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
    );
  }
}
