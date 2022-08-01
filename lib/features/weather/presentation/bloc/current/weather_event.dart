part of 'weather_bloc.dart';

abstract class WeatherEvent {}

class LoadWeather extends WeatherEvent {
  double lat;
  double lon;

  LoadWeather({
    required this.lat,
    required this.lon,
  });
}
