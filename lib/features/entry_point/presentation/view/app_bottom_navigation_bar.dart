import 'package:flutter/material.dart';
import 'package:smarthome_iot/core/constants/colors/app_colors.dart';
import 'package:smarthome_iot/core/constants/icons/app_icons.dart';
import 'package:smarthome_iot/features/entry_point/presentation/view/bottom_app_bar_item.dart';

import '../../../../l10n/generated/app_localizations.dart';

class AppNavigationBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onNavTap;
  const AppNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onNavTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.buttonColor,
        borderRadius: BorderRadius.circular(20), // Bo tròn các cạnh
      ),
      child: Row(
        children: [
          // Home item
          currentIndex == 1 || currentIndex == 2 || currentIndex > 2
              ? const SizedBox(
                  width: 32,
                )
              : const SizedBox(),
          BottomAppBarItem(
            name: AppLocalizations.of(context)!.local_language == "English"
                ? "Home        "
                : AppLocalizations.of(context)!.home,
            isAction: currentIndex == 0,
            iconLocationRegular: AppIcons.home_regular,
            iconLocationSolid: AppIcons.home_solid,
            onTap: () => onNavTap(0),
          ),
          // Spacer for equal spacing between items
          const Spacer(),
          // Add item
          currentIndex == 1
              ? const SizedBox(
                  width: 42,
                )
              : const SizedBox(),
          currentIndex == 2
              ? const SizedBox(
                  width: 64,
                )
              : const SizedBox(),
          BottomAppBarItem(
            name: AppLocalizations.of(context)!.add,
            isAction: currentIndex == 1,
            iconLocationRegular: AppIcons.plus_regular,
            iconLocationSolid: AppIcons.plus_solid_round,
            onTap: () => onNavTap(1),
          ),
          // Spacer for equal spacing between items
          const Spacer(),
          // Notification item
          currentIndex == 0
              ? const SizedBox(
                  width: 28,
                )
              : const SizedBox(),
          currentIndex == 1
              ? const SizedBox(
                  width: 42,
                )
              : const SizedBox(),
          BottomAppBarItem(
            name: AppLocalizations.of(context)!.notification,
            isAction: currentIndex == 2,
            iconLocationRegular: AppIcons.notification_regular,
            iconLocationSolid: AppIcons.notification_solid,
            onTap: () => onNavTap(2),
          ),
          currentIndex == 1
              ? const SizedBox(
                  width: 32,
                )
              : const SizedBox(),
          currentIndex == 0
              ? const SizedBox(
                  width: 32,
                )
              : const SizedBox(),
          currentIndex > 2
              ? const SizedBox(
                  width: 32,
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
