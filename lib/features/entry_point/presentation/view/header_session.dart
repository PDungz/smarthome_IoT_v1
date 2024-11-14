// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/routes/app_routes.dart';

class HeaderSession extends StatelessWidget {
  final String userId;
  final String fullName;
  final String toDayTime;
  const HeaderSession({
    super.key,
    required this.userId,
    required this.fullName,
    required this.toDayTime,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () => Navigator.pushNamed(context, AppRoutes.profile,
              arguments: userId),
          child: Container(
            height: 56,
            width: 56,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/Profile.png"),
                fit: BoxFit.cover, // Keep the image aspect ratio
              ),
            ),
          ),
        ),
        const SizedBox(width: 24),
        // Use Expanded to prevent overflow
        Expanded(
          child: InkWell(
            onTap: () => Navigator.pushNamed(context, AppRoutes.profile,
                arguments: userId),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fullName,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w900),
                ),
                Text(
                  toDayTime, // Update with dynamic date if needed
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppColors.textSecondarColor),
                ),
              ],
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.setting);
          },
          icon: const Icon(
            Icons.settings,
            color: AppColors.iconPrimaryColor,
            size: 32,
          ),
        )
      ],
    );
  }
}
