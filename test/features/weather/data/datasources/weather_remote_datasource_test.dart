import 'package:cloudwalktest/core/api/i_api_interceptor.dart';
import 'package:cloudwalktest/core/api/i_url_creator.dart';
import 'package:cloudwalktest/features/weather/data/datasources/remote/weather_remote_datasource.dart';
import 'package:cloudwalktest/features/weather/data/models/current/coord_model.dart';
import 'package:cloudwalktest/features/weather/data/models/current/main_model.dart';
import 'package:cloudwalktest/features/weather/data/models/current/weather_model.dart';
import 'package:cloudwalktest/features/weather/data/models/current/weather_response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements IHttpClient {}

class MockIUrlCreator extends Mock implements IUrlCreator {}

void main() {
  late MockHttpClient mockHttpClient;
  late MockIUrlCreator mockIUrlCreator;

  late WeatherRemoteDatasource remoteDataSource;

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
    mockHttpClient = MockHttpClient();
    mockIUrlCreator = MockIUrlCreator();

    remoteDataSource = WeatherRemoteDatasource(mockHttpClient, mockIUrlCreator);

    when(
      () => mockIUrlCreator.create(
        endpoint: any(named: 'endpoint'),
        queryParameters: any(named: 'queryParameters'),
        pathSegments: any(named: 'pathSegments'),
        scheme: any(named: 'scheme'),
        hostKey: any(named: 'hostKey'),
        port: any(named: 'port'),
      ),
    ).thenAnswer((_) => 'www');
  });

  group(
    'Weather success',
    () {
      test('should return Weather when returns code 200', () async {
        //Arrange
        when(() => mockHttpClient.get(any())).thenAnswer((_) async => Response(fixture('weather_response.json'), 200));

        //act
        final result = await remoteDataSource.getCurrentWeather(123, 123);

        //Assert
        expect(result, weatherResponseModel);
      });
    },
  );
}
