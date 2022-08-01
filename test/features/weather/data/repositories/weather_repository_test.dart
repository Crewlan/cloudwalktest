import 'package:cloudwalktest/core/errors/exceptions.dart';
import 'package:cloudwalktest/core/errors/failures.dart';
import 'package:cloudwalktest/features/weather/data/datasources/local/weather_local_datasource.dart';
import 'package:cloudwalktest/features/weather/data/datasources/remote/weather_remote_datasource.dart';
import 'package:cloudwalktest/features/weather/data/models/current/coord_model.dart';
import 'package:cloudwalktest/features/weather/data/models/current/main_model.dart';
import 'package:cloudwalktest/features/weather/data/models/current/weather_model.dart';
import 'package:cloudwalktest/features/weather/data/models/current/weather_response_model.dart';
import 'package:cloudwalktest/features/weather/data/repositories/weather_repository.dart';
import 'package:cloudwalktest/features/weather/domain/entities/current/coord_entity.dart';
import 'package:cloudwalktest/features/weather/domain/entities/current/main_entity.dart';
import 'package:cloudwalktest/features/weather/domain/entities/current/weather_entity.dart';
import 'package:cloudwalktest/features/weather/domain/entities/current/weather_response.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWeatherRemoteDataSource extends Mock implements WeatherRemoteDatasource {}

class MockWeatherLocalDataSource extends Mock implements WeatherLocalDatasource {}

void main() {
  late WeatherRepository repository;
  late MockWeatherRemoteDataSource mockWeatherRemoteDataSource;
  late MockWeatherLocalDataSource mockWeatherLocalDataSource;
  const coordModel = CoordModel(lon: -46.6425, lat: -23.223);
  const mainModel = MainModel(
    temp: 289.38,
    feelsLike: 289.36,
    tempMin: 288.29,
    tempMax: 290.51,
    pressure: 961,
    humidity: 88,
  );

  const weatherModel = [
    WeatherModel(
      description: 'nublado',
    ),
  ];

  const weatherResponseModel = WeatherResponseModel(
    cordModel: coordModel,
    mainModel: mainModel,
    weatherModel: weatherModel,
    name: 'Taboão da Serra',
  );

  const mainEntity = Main(
    temp: 289.38,
    feelsLike: 289.36,
    tempMin: 288.29,
    tempMax: 290.51,
    pressure: 961,
    humidity: 88,
  );

  const weatherEntity = [
    Weather(
      description: 'nublado',
    ),
  ];

  const coord = Coord(lon: -46.6425, lat: -23.223);
  const weatherResponseEntity = WeatherResponse(
    cord: coord,
    main: mainEntity,
    weather: weatherEntity,
  );

  setUp(() {
    mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
    mockWeatherLocalDataSource = MockWeatherLocalDataSource();
    repository = WeatherRepository(mockWeatherRemoteDataSource, mockWeatherLocalDataSource);
  });

  group('Test for Weather', () {
    test('should return current weather when call is successfull', () async {
      //Arrange
      when(() => mockWeatherRemoteDataSource.getCurrentWeather(123, 123)).thenAnswer(
        (_) async => weatherResponseModel,
      );
      when(() => mockWeatherLocalDataSource.getCachedWeatherResponse()).thenAnswer((_) async {
        return null;
      });

      //Act
      final result = await repository.getWeather(123, 123);
      //Assert

      expect(result, const Right<dynamic, WeatherResponse>(weatherResponseEntity));
    });

    test('should return ServerFailure when datasource throws ServerException', () async {
      //Arrange
      when(() => mockWeatherRemoteDataSource.getCurrentWeather(123, 123)).thenThrow(ServerException());
      when(() => mockWeatherLocalDataSource.getCachedWeatherResponse()).thenAnswer((_) async {
        return null;
      });

      //Act
      final result = await repository.getWeather(123, 123);

      //Assert
      expect(result, Left(ServerFailure()));
    });
  });
}
