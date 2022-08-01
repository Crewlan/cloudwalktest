import 'package:cloudwalktest/features/weather/data/datasources/local/forecast_dao.dart';
import 'package:cloudwalktest/features/weather/data/datasources/local/weather_dao.dart';
import 'package:cloudwalktest/features/weather/data/datasources/local/weather_local_datasource.dart';
import 'package:cloudwalktest/features/weather/data/models/current/coord_model.dart';
import 'package:cloudwalktest/features/weather/data/models/current/main_model.dart';
import 'package:cloudwalktest/features/weather/data/models/current/weather_model.dart';
import 'package:cloudwalktest/features/weather/data/models/current/weather_response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWeatherDao extends Mock implements WeatherDao {}

class MockForecastDao extends Mock implements ForecastDao {}

void main() {
  late MockWeatherDao mockWeatherDao;
  late MockForecastDao mockForecastDao;
  late WeatherLocalDatasource localDatasource;

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

  setUp(() {
    mockWeatherDao = MockWeatherDao();
    mockForecastDao = MockForecastDao();
    localDatasource = WeatherLocalDatasource(mockWeatherDao, mockForecastDao);
    registerFallbackValue(weatherResponseModel);
  });

  test(('should access DAO then caching weather'), () async {
    //Arrange
    when(() => mockWeatherDao.insertWeatherResponse(any())).thenAnswer((_) async => {});

    //Act
    await localDatasource.cacheWeatherResponse(weatherResponseModel);

    //Assert
    verify(() => mockWeatherDao.insertWeatherResponse(weatherResponseModel));
  });
}
