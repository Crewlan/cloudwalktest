part of 'forecast_bloc.dart';

abstract class ForecastEvent {}

class LoadForecast extends ForecastEvent {
  double lat;
  double lon;

  LoadForecast({
    required this.lat,
    required this.lon,
  });
}
