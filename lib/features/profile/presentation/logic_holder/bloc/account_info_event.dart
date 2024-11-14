// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'account_info_bloc.dart';

abstract class AccountInfoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchAccountInfo extends AccountInfoEvent {
  final String userId;
  FetchAccountInfo({
    required this.userId,
  });
}

class PickImage extends AccountInfoEvent {}

class SaveInfo extends AccountInfoEvent {
  final String userId;
  SaveInfo({
    required this.userId,
  });
}

class UpdateFullName extends AccountInfoEvent {
  final String newName;
  UpdateFullName({
    required this.newName,
  });
}

class UpdatePhoneNum extends AccountInfoEvent {
  final String newPhoneNum;
  UpdatePhoneNum({
    required this.newPhoneNum,
  });
}

class UpdatePassWord extends AccountInfoEvent {
  final String password;
  UpdatePassWord({
    required this.password,
  });
}
