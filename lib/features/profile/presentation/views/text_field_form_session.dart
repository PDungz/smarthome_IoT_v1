import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthome_iot/core/constants/colors/app_colors.dart';
import 'package:smarthome_iot/features/profile/presentation/logic_holder/bloc/account_info_bloc.dart';

import '../../../../core/utils/validators.dart';
import 'text_field_session.dart';

class TextFieldFormSession extends StatefulWidget {
  final String userId;

  const TextFieldFormSession({
    super.key,
    required this.userId,
  });

  @override
  State<TextFieldFormSession> createState() => _TextFieldFormSessionState();
}

class _TextFieldFormSessionState extends State<TextFieldFormSession> {
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final canUpdate =
        BlocProvider.of<AccountInfoBloc>(context, listen: true).canUpdate;
    return Form(
      key: _keyForm,
      child: Column(
        children: [
          BlocSelector<AccountInfoBloc, AccountInfoState, String?>(
            selector: (state) {
              final fullnameFromFirestore =
                  state.accountDataFromFirestore?.fullName;
              final fullnameFromLocal = state.upddateLocalAccountData.fullName;
              return fullnameFromFirestore ?? fullnameFromLocal;
            },
            builder: (context, state) {
              return TextFieldSession(
                fieldName: "Full Name",
                currentValue: state,
                onChanged: (newValue) {
                  BlocProvider.of<AccountInfoBloc>(context)
                      .add(UpdateFullName(newName: newValue));
                },
                validator: Validators.requirdWithFieldName('Full Name').call,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              );
            },
          ),
          const SizedBox(height: 8),
          BlocSelector<AccountInfoBloc, AccountInfoState, String?>(
            selector: (state) {
              final phoneNumFromFirestore =
                  state.accountDataFromFirestore?.phoneNumber;
              final phoneNumFromLocal =
                  state.upddateLocalAccountData.phoneNumber;
              return phoneNumFromFirestore ?? phoneNumFromLocal;
            },
            builder: (context, state) {
              return TextFieldSession(
                fieldName: "Phone number",
                currentValue: state,
                onChanged: (newValue) {
                  BlocProvider.of<AccountInfoBloc>(context)
                      .add(UpdatePhoneNum(newPhoneNum: newValue));
                },
                validator: Validators.phoneNumber.call,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              );
            },
          ),
          const SizedBox(height: 8),
          BlocSelector<AccountInfoBloc, AccountInfoState, String?>(
            selector: (state) {
              final passwordFromFirestore =
                  state.accountDataFromFirestore?.password;
              final passwordFromLocal = state.upddateLocalAccountData.password;
              return passwordFromFirestore ?? passwordFromLocal;
            },
            builder: (context, state) {
              return TextFieldSession(
                fieldName: "Password",
                currentValue: state,
                onChanged: (newValue) {
                  BlocProvider.of<AccountInfoBloc>(context)
                      .add(UpdatePassWord(password: newValue));
                },
                validator: Validators.password.call,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              );
            },
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Center(
              child: ElevatedButton(
                onPressed: canUpdate
                    ? () {
                        if (_keyForm.currentState!.validate()) {
                          FocusScope.of(context).unfocus();
                          BlocProvider.of<AccountInfoBloc>(context)
                              .add(SaveInfo(userId: widget.userId));
                        }
                      }
                    : null,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith<Color>(
                    (states) => canUpdate ? AppColors.buttonColor : Colors.grey,
                  ),
                  padding: WidgetStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 24)),
                ),
                child: const Text("Update"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
