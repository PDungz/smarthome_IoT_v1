// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:smarthome_iot/core/constants/components/components_shimmer/shimmer_loading.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/routes/app_routes.dart';

class HeaderSessionnLoading extends StatelessWidget {
  const HeaderSessionnLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const ShimmerLoading(
          height: 48,
          width: 48,
        ),
        const SizedBox(width: 24),
        // Use Expanded to prevent overflow
        const Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerLoading(
                height: 16,
                width: 80,
              ),
              SizedBox(height: 8),
              ShimmerLoading(
                height: 12,
                width: 60,
              ),
            ],
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
