import 'package:flutter/material.dart';
import 'package:smarthome_iot/core/constants/components/components_shimmer/shimmer_loading.dart';

import '../../../../core/constants/colors/app_colors.dart';

class NotificationSessionLoading extends StatelessWidget {
  const NotificationSessionLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: ShimmerLoading(
              height: 48,
              width: 48,
            ),
          ),
          SizedBox(width: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 196,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ShimmerLoading(width: 80),
                    SizedBox(height: 8),
                    ShimmerLoading(width: 200),
                    SizedBox(height: 4),
                    ShimmerLoading(width: 120),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: ShimmerLoading(width: 32),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
