import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/current/weather_response.dart';
import '../entities/forecast/weather_forecast_response.dart';

abstract class IWeatherRepository {
  Future<Either<Failure, WeatherResponse>> getWeather(double lat, double lon);
  Future<Either<Failure, List<WeatherForecastResponse>>> getForecast(double lat, double lon);
}
