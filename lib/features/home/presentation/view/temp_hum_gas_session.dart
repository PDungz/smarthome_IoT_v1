import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smarthome_iot/core/constants/colors/app_colors.dart';
import 'package:smarthome_iot/core/constants/icons/app_icons.dart';

import '../../../../core/constants/components/components_shimmer/shimmer_loading.dart';

class TempHumGasSession extends StatefulWidget {
  final Map<String, dynamic> responseWebSocket;

  const TempHumGasSession({
    super.key,
    required this.responseWebSocket,
  });

  @override
  _TempHumGasSessionState createState() => _TempHumGasSessionState();
}

class _TempHumGasSessionState extends State<TempHumGasSession>
    with TickerProviderStateMixin {
  late AnimationController _temperatureController;
  late AnimationController _humidityController;
  late AnimationController _gasController;

  late Animation<Color?> _temperatureAnimation;
  late Animation<Color?> _humidityAnimation;
  late Animation<Color?> _gasAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers
    _temperatureController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _humidityController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _gasController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    // Initialize color animations for each condition
    _temperatureAnimation = ColorTween(
      begin: AppColors.backgroundColor,
      end: const Color.fromARGB(125, 255, 153, 0),
    ).animate(_temperatureController);

    _humidityAnimation = ColorTween(
      begin: AppColors.backgroundColor,
      end: Colors.blue[100],
    ).animate(_humidityController);

    _gasAnimation = ColorTween(
      begin: AppColors.backgroundColor,
      end: AppColors.buttonDeleteColor,
    ).animate(_gasController);
  }

  @override
  void dispose() {
    _temperatureController.dispose();
    _humidityController.dispose();
    _gasController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gasValue = widget.responseWebSocket['gas_value'];
    final temperature = widget.responseWebSocket['temperature'];
    final humidity = widget.responseWebSocket['humidity'];

    return Column(
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            temperature != null
                ? AnimatedBuilder(
                    animation: _temperatureController,
                    builder: (context, child) {
                      return Container(
                        width: MediaQuery.of(context).size.width / 3.6,
                        height: 56,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        decoration: ShapeDecoration(
                          color: temperature < 45
                              ? AppColors.backgroundColor
                              : _temperatureAnimation.value,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppIcons.temperature_solid,
                              height: 20,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "$temperature°C",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : ShimmerLoading(
                    width: MediaQuery.of(context).size.width / 3.6,
                    height: 56,
                    borderRadius: 20,
                  ),
            humidity != null
                ? AnimatedBuilder(
                    animation: _humidityController,
                    builder: (context, child) {
                      return Container(
                        width: MediaQuery.of(context).size.width / 3.6,
                        height: 56,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        decoration: ShapeDecoration(
                          color: humidity > 30
                              ? AppColors.backgroundColor
                              : _humidityAnimation.value,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppIcons.droplet_solid,
                              color: Colors.blue[200],
                              height: 24,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "$humidity%",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : ShimmerLoading(
                    width: MediaQuery.of(context).size.width / 3.6,
                    height: 56,
                    borderRadius: 20,
                  ),
            gasValue != null
                ? AnimatedBuilder(
                    animation: _gasController,
                    builder: (context, child) {
                      return Container(
                        width: MediaQuery.of(context).size.width / 3.6,
                        height: 56,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        decoration: ShapeDecoration(
                          color: gasValue < 450
                              ? AppColors.backgroundColor
                              : _gasAnimation.value,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppIcons.fire_solid,
                              color: Colors.red[200],
                              height: 24,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "$gasValue",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : ShimmerLoading(
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
