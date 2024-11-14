import 'package:flutter/material.dart';
import '../../../../core/constants/components/components_shimmer/shimmer_loading.dart';

class DeviceSessionLoading extends StatelessWidget {
  const DeviceSessionLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(223, 216, 216, 216),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ShimmerLoading(width: 48, height: 48, borderRadius: 24),
              SizedBox(width: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerLoading(width: 100, height: 16),
                  SizedBox(height: 4),
                  ShimmerLoading(width: 80, height: 16),
                ],
              ),
              Spacer(),
              ShimmerLoading(width: 72, height: 16),
            ],
          ),
        ],
      ),
    );
  }
}
