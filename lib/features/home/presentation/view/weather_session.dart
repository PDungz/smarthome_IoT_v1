import 'package:flutter/material.dart';
import 'package:smarthome_iot/core/constants/colors/app_colors.dart';

class WeatherSession extends StatelessWidget {
  const WeatherSession({super.key});

  @override
  Widget build(BuildContext context) {
    List<IconData> icons = [
      Icons.cloud,
      Icons.cloudy_snowing,
      Icons.wb_twilight,
      Icons.thunderstorm_rounded,
      Icons.sunny_snowing,
      Icons.sunny
    ];
    List<Color?> colors = [
      Colors.blueGrey[200],
      Colors.blue[200],
      Colors.amber[200],
      Colors.blueAccent[200],
      Colors.blueGrey[200],
      Colors.blueAccent[200],
    ];
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 140,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: ShapeDecoration(
            color: AppColors.backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "$index AM",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                      const SizedBox(height: 8),
                      Icon(icons[index], color: colors[index]),
                      const SizedBox(height: 8),
                      Text(
                        "${index}0°C",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.amber),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
