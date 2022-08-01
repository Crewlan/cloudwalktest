import 'dart:convert';

import '../../../../../core/api/endpoints.dart';
import '../../../../../core/api/i_api_interceptor.dart';
import '../../../../../core/api/i_url_creator.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../models/current/weather_response_model.dart';
import '../../models/forecast/weather_forecast_response_model.dart';
import 'i_weather_remote_datasource.dart';

class WeatherRemoteDatasource extends IWeatherRemoteDatasource {
  final IHttpClient _client;
  final IUrlCreator _urlCreator;

  WeatherRemoteDatasource(this._client, this._urlCreator);

  @override
  Future<WeatherResponseModel> getCurrentWeather(double lat, double lon) async {
    final response = await _client.get(
      _urlCreator.create(
        endpoint: Endpoints.current,
        queryParameters: {
          'lat': lat.toString(),
          'lon': lon.toString(),
          'units': 'metric',
          'lang': 'pt_br',
          'appid': '1bb58ed24daff4c967d787cc00ed3561',
        },
      ),
    );

    switch (response.statusCode) {
      case 200:
        var json = jsonDecode(response.body);
        return WeatherResponseModel.fromJson(json);
      default:
        throw ServerException();
    }
  }

  @override
  Future<List<WeatherForecastResponseModel>> getForecastWeather(double lat, double lon) async {
    final response = await _client.get(
      _urlCreator.create(
        endpoint: Endpoints.forecast,
        queryParameters: {
          'lat': lat.toString(),
          'lon': lon.toString(),
          'units': 'metric',
          'lang': 'pt_br',
          'cnt': '40',
          'appid': '1bb58ed24daff4c967d787cc00ed3561',
        },
      ),
    );

    switch (response.statusCode) {
      case 200:
        Map forecast = jsonDecode(utf8.decode(response.bodyBytes));
        List content = forecast['list'];
        return content.map((e) => WeatherForecastResponseModel.fromJson(e)).toList();
      default:
        throw ServerException();
    }
  }
}
