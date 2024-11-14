// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_bloc.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final User user;
  UserLoaded({
    required this.user,
  });
}

class UserError extends UserState {
  final String Msg;
  UserError({
    required this.Msg,
  });
}
