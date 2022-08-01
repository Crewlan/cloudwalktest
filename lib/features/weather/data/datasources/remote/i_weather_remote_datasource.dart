import '../../models/current/weather_response_model.dart';
import '../../models/forecast/weather_forecast_response_model.dart';

abstract class IWeatherRemoteDatasource {
  Future<WeatherResponseModel> getCurrentWeather(double lat, double lon);
  Future<List<WeatherForecastResponseModel>> getForecastWeather(double lat, double lon);
}
