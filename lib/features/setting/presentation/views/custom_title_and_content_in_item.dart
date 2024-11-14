import 'package:flutter/material.dart';
import 'package:smarthome_iot/core/constants/colors/app_colors.dart';

class CustomTitleAndContentInItem extends StatelessWidget {
  final String title;
  final Widget content;
  const CustomTitleAndContentInItem({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textPrimaryColor, fontWeight: FontWeight.bold),
          ),
        ),
        content
      ],
    );
  }
}
