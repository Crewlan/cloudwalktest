import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/current/weather_response.dart';
import '../../domain/entities/forecast/weather_forecast_response.dart';
import '../../domain/repositories/i_weather_repository.dart';
import '../datasources/local/weather_local_datasource.dart';
import '../datasources/remote/weather_remote_datasource.dart';

class WeatherRepository implements IWeatherRepository {
  final WeatherRemoteDatasource remoteDataSource;
  final WeatherLocalDatasource localDatasource;

  WeatherRepository(this.remoteDataSource, this.localDatasource);

  @override
  Future<Either<Failure, WeatherResponse>> getWeather(double lat, double lon) async {
    try {
      final cachedWeather = await localDatasource.getCachedWeatherResponse();
      if (cachedWeather != null) {
        return Right(cachedWeather.toEntity());
      } else {
        final response = await remoteDataSource.getCurrentWeather(lat, lon);
        return Right(response.toEntity());
      }
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<WeatherForecastResponse>>> getForecast(double lat, double lon) async {
    try {
      final cachedForecast = await localDatasource.getCachedWeatherForecastResponse();
      if (cachedForecast != null && cachedForecast.isNotEmpty) {
        return Right(cachedForecast.map((e) => e.toEntity()).toList());
      } else {
        final response = await remoteDataSource.getForecastWeather(lat, lon);
        return Right(response.map((e) => e.toEntity()).toList());
      }
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
