import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/forecast/weather_forecast_response.dart';
import '../repositories/i_weather_repository.dart';

class GetForecast {
  final IWeatherRepository repository;

  GetForecast(this.repository);

  Future<Either<Failure, List<WeatherForecastResponse>>> call(double lat, double lon) async {
    return await repository.getForecast(lat, lon);
  }
}
