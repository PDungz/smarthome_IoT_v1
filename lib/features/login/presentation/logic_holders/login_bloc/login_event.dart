// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

abstract class LoginEvent {}

class loginWithPhoneNumberPassword extends LoginEvent {
  final String phoneNumber;
  final String password;

  loginWithPhoneNumberPassword({
    required this.phoneNumber,
    required this.password,
  });
}
