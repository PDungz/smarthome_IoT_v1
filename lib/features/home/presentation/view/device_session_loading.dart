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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerLoading(
                  width: 48, height: 48, borderRadius: 24), // Shimmer cho icon
              ShimmerLoading(width: 24, height: 24), // Shimmer cho icon button
            ],
          ),
          SizedBox(height: 16),
          ShimmerLoading(width: 100, height: 16), // Shimmer cho tên thiết bị
          SizedBox(height: 4),
          ShimmerLoading(width: 80, height: 14), // Shimmer cho mô tả
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerLoading(width: 40, height: 16), // Shimmer cho trạng thái
              ShimmerLoading(width: 24, height: 24), // Shimmer cho switch
            ],
          ),
        ],
      ),
    );
  }
}
