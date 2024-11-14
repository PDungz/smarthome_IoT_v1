// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

class LoginState {
  final bool? canNavigateToEntryScreen;
  final String? errorMsg;
  final StatusState status;

  LoginState({
    this.canNavigateToEntryScreen,
    this.errorMsg,
    this.status = StatusState.idle,
  });

  LoginState copyWith({
    bool? canNavigateToEntryScreen,
    String? errorMsg,
    StatusState? status,
  }) {
    return LoginState(
      canNavigateToEntryScreen:
          canNavigateToEntryScreen ?? this.canNavigateToEntryScreen,
      errorMsg: errorMsg ?? this.errorMsg,
      status: status ?? this.status,
    );
  }
}
