import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/constants/components/components_shimmer/shimmer_loading.dart';

class TempHumGasSessionLoading extends StatelessWidget {
  const TempHumGasSessionLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ShimmerLoading(
              width: MediaQuery.of(context).size.width / 3.6,
              height: 56,
              borderRadius: 20,
            ),
            ShimmerLoading(
              width: MediaQuery.of(context).size.width / 3.6,
              height: 56,
              borderRadius: 20,
            ),
            ShimmerLoading(
              width: MediaQuery.of(context).size.width / 3.6,
              height: 56,
              borderRadius: 20,
            ),
          ],
        ),
      ],
    );
  }
}
