import 'package:equatable/equatable.dart';

import 'coord_entity.dart';
import 'main_entity.dart';
import 'weather_entity.dart';

class WeatherResponse extends Equatable {
  final Main? main;
  final List<Weather>? weather;

  final Coord? cord;

  const WeatherResponse({
    this.main,
    this.weather,
    this.cord,
  });

  @override
  List<Object?> get props {
    return [
      main,
      weather,
      cord,
    ];
  }
}
