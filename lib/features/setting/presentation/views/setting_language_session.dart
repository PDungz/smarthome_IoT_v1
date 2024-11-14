import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/common/global_setting/presentation/global_info_bloc/global_info_bloc.dart';
import '../../../../core/services/logger_service.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../l10n/generated/app_localizations.dart';
import 'custom_title_and_content_in_item.dart';

class FlagOption extends StatelessWidget {
  final String flagValue;
  final String? selectedFlag;
  final String svgPicturePath;
  final void Function()? onTap;
  const FlagOption({
    super.key,
    required this.flagValue,
    required this.selectedFlag,
    required this.svgPicturePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = flagValue == selectedFlag;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(
              color: isSelected ? Colors.grey : Colors.white,
              width: isSelected ? 4 : 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: SvgPicture.asset(
          svgPicturePath,
          width: 32,
          height: 32,
        ),
      ),
    );
  }
}

class SettingLanguageSession extends StatefulWidget {
  const SettingLanguageSession({
    super.key,
  });

  @override
  State<SettingLanguageSession> createState() => _SettingLanguageSessionState();
}

class _SettingLanguageSessionState extends State<SettingLanguageSession> {
  // String selectedLanguage = "Vietnamese";
  final supportedLocales = AppLocalizations.supportedLocales;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTitleAndContentInItem(
            title: AppLocalizations.of(context)!.language,
            content: BlocBuilder<GlobalInfoBloc, GlobalInfoState>(
              builder: (context, state) {
                final selectedLocale = state.currentLocale;
                final selectedLangCode = selectedLocale?.languageCode;
                printS("Selected locale: $selectedLocale");
                return Row(
                    children: supportedLocales
                        .map((locale) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: FlagOption(
                                flagValue: locale.languageCode,
                                selectedFlag: selectedLangCode,
                                svgPicturePath: locale.iconPath,
                                onTap: () {
                                  printS(
                                      "Selected lang code: ${locale.languageCode}");
                                  BlocProvider.of<GlobalInfoBloc>(context).add(
                                      SetSavedLangCode(
                                          langCode: locale.languageCode));
                                },
                              ),
                            ))
                        .toList());
              },
            ))
      ],
    );
  }
}

extension LocaleExtension on Locale {
  String get iconPath {
    switch (languageCode) {
      case "en":
        return Assets.svg.usFlag;
      case "vi":
        return Assets.svg.vietnamFlag;
      default:
        return "";
    }
  }
}
