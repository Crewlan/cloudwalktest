import '../../models/forecast/weather_forecast_response_model.dart';
import 'package:floor/floor.dart';

@dao
abstract class ForecastDao {
  @Query('SELECT * FROM WeatherForecastResponse')
  Future<List<WeatherForecastResponseModel>?> getWeatherForecastResponse();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertWeatherForecastResponse(List<WeatherForecastResponseModel> weatherForecastResponseModel);

  @Query('DELETE FROM WeatherForecastResponse')
  Future<void> deleteWeatherForecastResponse();
}
