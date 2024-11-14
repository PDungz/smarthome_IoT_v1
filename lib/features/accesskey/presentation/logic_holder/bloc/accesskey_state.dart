// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'accesskey_bloc.dart';

abstract class AccessKeyState {}

class AccessKeyInitial extends AccessKeyState {}

class AccessKeyLoading extends AccessKeyState {}

class AccessKeyLoaded extends AccessKeyState {
  final List<AccessKey> accesskey;
  AccessKeyLoaded({
    required this.accesskey,
  });
}

class AccessKeyPost extends AccessKeyState {
  final StatusState status;
  final String? Msg;
  AccessKeyPost({
    this.status = StatusState.idle,
    this.Msg,
  });

  AccessKeyPost copyWith({
    StatusState? status,
    String? Msg,
  }) {
    return AccessKeyPost(
      status: status ?? this.status,
      Msg: Msg ?? this.Msg,
    );
  }
}

class AccessKeyError extends AccessKeyState {
  final String Msg;
  AccessKeyError({
    required this.Msg,
  });
}
