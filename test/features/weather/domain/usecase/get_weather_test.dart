import 'package:cloudwalktest/core/errors/failures.dart';
import 'package:cloudwalktest/features/weather/domain/entities/current/coord_entity.dart';
import 'package:cloudwalktest/features/weather/domain/entities/current/main_entity.dart';
import 'package:cloudwalktest/features/weather/domain/entities/current/weather_entity.dart';
import 'package:cloudwalktest/features/weather/domain/entities/current/weather_response.dart';
import 'package:cloudwalktest/features/weather/domain/repositories/i_weather_repository.dart';
import 'package:cloudwalktest/features/weather/domain/usecases/get_weather.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWeatherRepository extends Mock implements IWeatherRepository {}

void main() {
  late MockWeatherRepository mockWeatherRepository;
  late GetWeather getWeather;

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
    main: mainEntity,
    weather: weatherEntity,
    cord: coord,
  );
  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getWeather = GetWeather(mockWeatherRepository);
  });

  test('should return Right when repository returns success', () async {
    //Arrange
    when(() => mockWeatherRepository.getWeather(any(), any()))
        .thenAnswer((_) async => const Right(weatherResponseEntity));

    //Act
    final Either<Failure, WeatherResponse> result = await getWeather(lat: 123, lon: 123);

    //Assert
    verify(() => mockWeatherRepository.getWeather(123, 123));
    expect(result, const Right(weatherResponseEntity));
  });
}
