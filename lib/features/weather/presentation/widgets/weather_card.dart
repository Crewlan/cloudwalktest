import '../../../../core/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_strings.dart';

class WeatherCard extends StatelessWidget {
  final String? temp;
  final String? tempMax;
  final String? tempMin;
  final String? mainDescription;
  final VoidCallback? onTap;

  const WeatherCard({
    Key? key,
    this.temp,
    this.tempMax,
    this.tempMin,
    this.mainDescription,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.blueLightest,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text('${AppStrings.weatherWeatherTemp} $temp ${AppStrings.weatherWeatherCelsius}'),
            const SizedBox(height: 10),
            Row(
              children: [
                Text('${AppStrings.weatherWeatherTempMax} $tempMax ${AppStrings.weatherWeatherCelsius}'),
                const SizedBox(width: 4),
                const Icon(Icons.arrow_drop_up_rounded),
              ],
            ),
            Row(
              children: [
                Text('${AppStrings.weatherWeatherTempMin} $tempMin ${AppStrings.weatherWeatherCelsius}'),
                const SizedBox(width: 4),
                const Icon(Icons.arrow_drop_down_rounded),
              ],
            ),
            const SizedBox(height: 10),
            Text('${AppStrings.weatherDescription}$mainDescription'),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  AppStrings.weatherAboutMore,
                  style: TextStyle(color: AppColors.blueLight),
                ),
                SizedBox(width: 4),
                Icon(Icons.arrow_right_alt_sharp)
              ],
            )
          ],
        ),
      ),
    );
  }
}
