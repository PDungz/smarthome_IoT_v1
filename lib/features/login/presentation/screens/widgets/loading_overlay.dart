import 'package:flutter/material.dart';

class LoadingOverylay extends StatelessWidget {
  const LoadingOverylay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black87,
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
