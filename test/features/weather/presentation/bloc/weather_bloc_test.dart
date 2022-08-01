import 'package:bloc_test/bloc_test.dart';
import 'package:cloudwalktest/features/weather/domain/entities/current/coord_entity.dart';
import 'package:cloudwalktest/features/weather/domain/entities/current/main_entity.dart';
import 'package:cloudwalktest/features/weather/domain/entities/current/weather_entity.dart';
import 'package:cloudwalktest/features/weather/domain/entities/current/weather_response.dart';
import 'package:cloudwalktest/features/weather/domain/usecases/get_weather.dart';
import 'package:cloudwalktest/features/weather/presentation/bloc/current/weather_bloc.dart';
import 'package:cloudwalktest/features/weather/presentation/bloc/current/weather_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetWeather extends Mock implements GetWeather {}

void main() {
  late MockGetWeather mockGetWeather;
  late WeatherBloc weatherBloc;

  setUp(() {
    mockGetWeather = MockGetWeather();
    weatherBloc = WeatherBloc(mockGetWeather);
  });

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

  blocTest(
    'should emit loading and ready state when usecase returns right',
    build: () {
      when(() => mockGetWeather.call(lat: any(named: 'lat'), lon: any(named: 'lon')))
          .thenAnswer((_) async => const Right(weatherResponseEntity));
      return weatherBloc;
    },
    expect: () => [
      const WeatherState.initial().loading(),
      const WeatherState.initial().loading().ready(weatherResponseEntity),
    ],
    act: (dynamic bloc) => bloc.add(LoadWeather(lat: 123, lon: 123)),
  );
}
