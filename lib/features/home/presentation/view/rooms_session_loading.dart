import 'package:flutter/material.dart';
import '../../../../core/constants/components/components_shimmer/shimmer_loading.dart';

class RoomsSessionLoading extends StatelessWidget {
  const RoomsSessionLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return const SizedBox(
            width: 200,
            child: ListTile(title: ShimmerLoading(width: 200, height: 32)),
          );
        },
      ),
    );
  }
}
