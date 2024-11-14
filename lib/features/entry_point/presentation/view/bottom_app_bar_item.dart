import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smarthome_iot/core/constants/colors/app_colors.dart';

class BottomAppBarItem extends StatelessWidget {
  final String name;
  final bool isAction;
  final String iconLocationRegular;
  final String iconLocationSolid;
  final void Function() onTap;
  const BottomAppBarItem({
    super.key,
    required this.name,
    required this.isAction,
    required this.onTap,
    required this.iconLocationRegular,
    required this.iconLocationSolid,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isAction ? AppColors.buttonBottomColor : Colors.transparent,
          borderRadius: BorderRadius.circular(12), // Bo tròn các cạnh
        ),
        child: Row(
          children: [
            isAction
                ? SvgPicture.asset(iconLocationRegular)
                : SvgPicture.asset(iconLocationSolid),
            const SizedBox(width: 8),
            isAction
                ? Text(
                    name,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: AppColors.primaryColor),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
