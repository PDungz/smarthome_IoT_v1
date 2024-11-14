import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smarthome_iot/core/constants/colors/app_colors.dart';
import 'package:smarthome_iot/core/constants/icons/app_icons.dart';
import 'package:smarthome_iot/core/enums/status_state.dart';
import 'package:smarthome_iot/core/services/injection_container.dart';
import 'package:smarthome_iot/features/accesskey/data/repositories/accesskey_repository_impl.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../accesskey/presentation/logic_holder/bloc/accesskey_bloc.dart';

class AccesskeySession extends StatefulWidget {
  final String iconPath;
  final String title;

  const AccesskeySession({
    super.key,
    required this.iconPath,
    required this.title,
  });

  @override
  State<AccesskeySession> createState() => _AccesskeySessionState();
}

class _AccesskeySessionState extends State<AccesskeySession> {
  bool isAction = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AccessKeyBloc>(
      create: (context) =>
          AccessKeyBloc(AccessKeyRepositoryImpl(remoteDatasource: getIt()))
            ..add(LoadAccessKey()),
      child: BlocConsumer<AccessKeyBloc, AccessKeyState>(
        listener: (context, state) {
          if (state is AccessKeyPost) {
            if (state.status == StatusState.success) {
              _showDialog("Success", "AccessKey added successfully");
            } else if (state.status == StatusState.failure) {
              _showDialog("Error", state.Msg ?? "Failed to add accesskey");
            }
          }
        },
        builder: (context, state) {
          return InkWell(
            onTap: () {
              setState(() {
                isAction = !isAction;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: AppColors.backgroundColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    // Main content
                    child: isAction
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 12),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: SvgPicture.asset(
                                    widget.iconPath,
                                    color: AppColors.iconPrimaryColor,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Text(
                                  widget.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textPrimaryColor,
                                      ),
                                ),
                              ],
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                  onPressed: () => Navigator.pushNamed(
                                    context,
                                    AppRoutes.entry_point,
                                    arguments: [9, ""],
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 20),
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: SvgPicture.asset(
                                          AppIcons.search_solid,
                                          color: AppColors.backgroundColor,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(AppLocalizations.of(context)!.view,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors
                                                      .backgroundColor)),
                                    ],
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    BlocProvider.of<AccessKeyBloc>(context)
                                        .add(PostAccessKey());
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 20),
                                    backgroundColor:
                                        AppColors.buttonUpdateColor,
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: SvgPicture.asset(
                                          AppIcons.plus_solid,
                                          color: AppColors.iconPrimaryColor,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(AppLocalizations.of(context)!.add,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                  fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                    // Close button positioned in the top right
                  ),
                  isAction != true
                      ? Positioned(
                          top: 2,
                          right: 2,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isAction = !isAction;
                              });
                            },
                            child: Container(
                                width: 36,
                                height: 36,
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: const Icon(Icons.close)),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.backgroundColor,
          title: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: AppColors.textPrimaryColor),
          ),
          content: Text(
            message,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: AppColors.textSecondarColor),
          ),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () => Navigator.pushNamed(
                context,
                AppRoutes.entry_point,
                arguments: [9, ""],
              ),
            ),
          ],
        );
      },
    );
  }
}
