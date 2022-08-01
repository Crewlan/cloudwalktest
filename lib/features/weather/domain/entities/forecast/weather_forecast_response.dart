import 'package:equatable/equatable.dart';

import '../current/main_entity.dart';
import '../current/weather_entity.dart';

class WeatherForecastResponse extends Equatable {
  final Main? main;

  final List<Weather>? weather;

  final DateTime? datetimeTxt;

  const WeatherForecastResponse({
    this.main,
    this.weather,
    this.datetimeTxt,
  });

  @override
  List<Object?> get props {
    return [
      main,
      weather,
      datetimeTxt,
    ];
  }
}
