import '../../models/forecast/weather_forecast_response_model.dart';

import '../../models/current/weather_response_model.dart';

abstract class IWeatherLocalDatasource {
  Future<WeatherResponseModel?> getCachedWeatherResponse();
  Future<void> cacheWeatherResponse(WeatherResponseModel weatherResponseModel);
  Future<List<WeatherForecastResponseModel>?> getCachedWeatherForecastResponse();
  Future<void> cacheWeatherForecastResponse(List<WeatherForecastResponseModel> weatherForecastResponseModel);
}
