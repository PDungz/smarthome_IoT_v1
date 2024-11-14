import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthome_iot/core/enums/status_state.dart';
import 'package:smarthome_iot/core/routes/app_routes.dart';
import 'package:smarthome_iot/core/services/injection_container.dart';
import 'package:smarthome_iot/features/login/data/repositories/auth_repository.dart';
import 'package:smarthome_iot/features/login/presentation/logic_holders/login_bloc/login_bloc.dart';
import 'package:smarthome_iot/features/login/presentation/screens/widgets/login_button_session.dart';
import 'package:smarthome_iot/features/login/presentation/screens/widgets/username_password_sesion.dart';
import 'package:smarthome_iot/l10n/generated/app_localizations.dart';

import 'widgets/loading_overlay.dart';

class LoginRoutes extends StatefulWidget {
  const LoginRoutes({super.key});

  @override
  State<LoginRoutes> createState() => _LoginRoutesState();
}

class _LoginRoutesState extends State<LoginRoutes> {
  late final TextEditingController phoneNumberTexController;
  late final TextEditingController passwordTextController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String notification = '';

  @override
  void initState() {
    phoneNumberTexController = TextEditingController();
    passwordTextController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(AuthRepositoryImpl(
        remoteDatasource: getIt(),
        tokenRepository: getIt(),
      )),
      child: Scaffold(
        body: Builder(builder: (context) {
          return BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              final status = state.status;
              if (status == StatusState.failure) {
                notification = "Check PhoneNumber or Password";
              } else if (status == StatusState.success) {
                notification = "successful login";
                Navigator.pushNamed(context, AppRoutes.entry_point);
              }
            },
            builder: (_, state) {
              final isLoading = state.status == StatusState.loading;
              return Stack(
                children: [
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/bg_login.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Column(
                      children: [
                        const Spacer(),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 190, 190, 190)
                                .withOpacity(0.98),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 30),
                                  child: Center(
                                    child: Text(
                                      AppLocalizations.of(context)!.login,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 42),
                                    ),
                                  ),
                                ),
                                // Form nhập thông tin đăng nhập
                                UsernamePasswordSesion(
                                    phoneNumberTexController:
                                        phoneNumberTexController,
                                    passwordTextController:
                                        passwordTextController,
                                    notification: notification),
                                const SizedBox(height: 16),
                                LoginButtonSection(
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();
                                    BlocProvider.of<LoginBloc>(context)
                                        .add(loginWithPhoneNumberPassword(
                                      phoneNumber:
                                          phoneNumberTexController.text.trim(),
                                      password:
                                          passwordTextController.text.trim(),
                                    ));
                                  },
                                ),
                                const SizedBox(height: 32),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                  if (isLoading) const LoadingOverylay(),
                ],
              );
            },
          );
        }),
      ),
    );
  }

  @override
  void dispose() {
    phoneNumberTexController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }
}
