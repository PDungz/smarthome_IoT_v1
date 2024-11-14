import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/colors/app_colors.dart';

class LineChartSession extends StatefulWidget {
  const LineChartSession({super.key});

  @override
  State<LineChartSession> createState() => _LineChartSessionState();
}

class _LineChartSessionState extends State<LineChartSession> {
  List<Color> gradientColors = [
    Color(0xFF50E4FF),
    Color(0xFF2196F3),
  ];

  bool isTemperature = true; // Toggle variable

  final List<Map<String, dynamic>> data = [
    {'day': 'Mon', 'temperature': 25.0, 'humidity': 60.0},
    {'day': 'Tue', 'temperature': 27.0, 'humidity': 65.0},
    {'day': 'Wed', 'temperature': 24.0, 'humidity': 55.0},
    {'day': 'Thu', 'temperature': 26.5, 'humidity': 63.0},
    {'day': 'Fri', 'temperature': 28.0, 'humidity': 68.0},
    {'day': 'Sat', 'temperature': 29.0, 'humidity': 70.0},
    {'day': 'Sun', 'temperature': 26.0, 'humidity': 64.0},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 6,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: ShapeDecoration(
        color: AppColors.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Stack(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.70,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: LineChart(
                isTemperature ? temperatureData() : humidityData(),
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: IconButton(
              icon: isTemperature
                  ? Icon(
                      Icons.thermostat,
                      color: Colors.red[300],
                    )
                  : Icon(
                      Icons.water_drop,
                      color: Colors.blue[300],
                    ),
              onPressed: () {
                setState(() {
                  isTemperature = !isTemperature;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  LineChartData temperatureData() {
    return LineChartData(
      titlesData: _titlesData(),
      lineBarsData: [
        LineChartBarData(
          spots: data.asMap().entries.map((entry) {
            return FlSpot(entry.key.toDouble(), entry.value['temperature']);
          }).toList(),
          isCurved: true,
          gradient: LinearGradient(colors: gradientColors),
          barWidth: 5,
          dotData: FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData humidityData() {
    return LineChartData(
      titlesData: _titlesData(),
      lineBarsData: [
        LineChartBarData(
          spots: data.asMap().entries.map((entry) {
            return FlSpot(entry.key.toDouble(), entry.value['humidity']);
          }).toList(),
          isCurved: true,
          gradient: LinearGradient(colors: gradientColors),
          barWidth: 5,
          dotData: FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  FlTitlesData _titlesData() {
    return FlTitlesData(
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) {
            const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 12);
            switch (value.toInt()) {
              case 0:
                return SideTitleWidget(
                    axisSide: meta.axisSide, child: Text('Mon', style: style));
              case 1:
                return SideTitleWidget(
                    axisSide: meta.axisSide, child: Text('Tue', style: style));
              case 2:
                return SideTitleWidget(
                    axisSide: meta.axisSide, child: Text('Wed', style: style));
              case 3:
                return SideTitleWidget(
                    axisSide: meta.axisSide, child: Text('Thu', style: style));
              case 4:
                return SideTitleWidget(
                    axisSide: meta.axisSide, child: Text('Fri', style: style));
              case 5:
                return SideTitleWidget(
                    axisSide: meta.axisSide, child: Text('Sat', style: style));
              case 6:
                return SideTitleWidget(
                    axisSide: meta.axisSide, child: Text('Sun', style: style));
              default:
                return Container();
            }
          },
          interval: 1,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: 10,
          getTitlesWidget: (value, meta) {
            const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 12);
            return SideTitleWidget(
                axisSide: meta.axisSide,
                child: Text(value.toInt().toString(), style: style));
          },
        ),
      ),
    );
  }
}
