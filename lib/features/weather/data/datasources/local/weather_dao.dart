import 'package:floor/floor.dart';

import '../../models/current/weather_response_model.dart';

@dao
abstract class WeatherDao {
  @Query('SELECT * FROM WeatherResponse')
  Future<WeatherResponseModel?> getWeatherResponse();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertWeatherResponse(WeatherResponseModel weatherResponseModel);

  @Query('DELETE FROM WeatherResponse')
  Future<void> deleteWeatherResponse();
}
