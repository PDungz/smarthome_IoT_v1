// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_bloc.dart';

abstract class UserEvent {}

class LoadUser extends UserEvent {}

class UpdateUser extends UserEvent {
  final User user;
  final String password;
  UpdateUser(
    this.password, {
    required this.user,
  });
}
