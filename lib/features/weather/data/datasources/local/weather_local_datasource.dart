// ignore_for_file: depend_on_referenced_packages

import 'package:cloudwalktest/features/weather/data/datasources/local/forecast_dao.dart';
import 'package:cloudwalktest/features/weather/data/models/forecast/weather_forecast_response_model.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../../core/errors/exceptions.dart';
import '../../models/current/weather_response_model.dart';
import 'i_weather_local_datasource.dart';
import 'weather_dao.dart';

class WeatherLocalDatasource implements IWeatherLocalDatasource {
  final WeatherDao _weatherDao;
  final ForecastDao _forecastDao;

  WeatherLocalDatasource(this._weatherDao, this._forecastDao);

  @override
  Future<void> cacheWeatherResponse(WeatherResponseModel weatherResponseModel) async {
    try {
      await _weatherDao.insertWeatherResponse(weatherResponseModel);
    } on DatabaseException {
      throw CacheException();
    }
  }

  @override
  Future<WeatherResponseModel?> getCachedWeatherResponse() async {
    try {
      return await _weatherDao.getWeatherResponse();
    } on DatabaseException {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheWeatherForecastResponse(List<WeatherForecastResponseModel> weatherForecastResponseModel) async {
    try {
      await _forecastDao.insertWeatherForecastResponse(weatherForecastResponseModel);
    } on DatabaseException {
      throw CacheException();
    }
  }

  @override
  Future<List<WeatherForecastResponseModel>?> getCachedWeatherForecastResponse() async {
    try {
      final forecast = await _forecastDao.getWeatherForecastResponse();
      if (forecast != null) {
        return forecast;
      } else {
        throw CacheException();
      }
    } on DatabaseException {
      throw CacheException();
    }
  }
}
