import 'package:cloudwalktest/features/weather/data/models/current/coord_model.dart';
import 'package:cloudwalktest/features/weather/data/models/current/main_model.dart';
import 'package:cloudwalktest/features/weather/data/models/current/weather_model.dart';
import 'package:cloudwalktest/features/weather/data/models/current/weather_response_model.dart';
import 'package:cloudwalktest/features/weather/domain/entities/current/coord_entity.dart';
import 'package:cloudwalktest/features/weather/domain/entities/current/main_entity.dart';
import 'package:cloudwalktest/features/weather/domain/entities/current/weather_entity.dart';
import 'package:cloudwalktest/features/weather/domain/entities/current/weather_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
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
    mainModel: mainModel,
    weatherModel: weatherModel,
    name: 'Taboão da Serra',
    cordModel: coordModel,
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

  test('should convert model to entity', () {
    //Arrange
    //Act
    final result = weatherResponseModel.toEntity();

    expect(result, weatherResponseEntity);
  });
}
