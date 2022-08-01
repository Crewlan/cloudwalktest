import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/current/weather_response.dart';
import '../repositories/i_weather_repository.dart';

class GetWeather {
  final IWeatherRepository repository;

  GetWeather(this.repository);

  Future<Either<Failure, WeatherResponse>> call({required double lat, required double lon}) async {
    return await repository.getWeather(lat, lon);
  }
}
