// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:cloudwalktest/features/weather/data/converters/coord_converter.dart';
import 'package:cloudwalktest/features/weather/data/converters/weather_converter.dart';
import 'package:cloudwalktest/features/weather/data/datasources/local/forecast_dao.dart';
import 'package:cloudwalktest/features/weather/data/datasources/local/weather_dao.dart';
import 'package:cloudwalktest/features/weather/data/models/forecast/weather_forecast_response_model.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../../features/weather/data/converters/main_converter.dart';
import '../../features/weather/data/models/current/weather_response_model.dart';
import '../utils/date_time_converter.dart';

part 'app_database.g.dart';

@TypeConverters([MainConverter, WeatherConverter, CoordConverter, DateTimeConverter])
@Database(version: 1, entities: [
  WeatherResponseModel,
  WeatherForecastResponseModel,
])
abstract class AppDatabase extends FloorDatabase {
  WeatherDao get weatherDao;
  ForecastDao get forecastDao;

  static final migration1to2 = Migration(1, 2, (database) async {
    await database.execute(
        'CREATE TABLE IF NOT EXISTS `WeatherResponse` (`mainModel` TEXT, `windModel` TEXT, `weatherModel` TEXT, `cloudsModel` TEXT, `timezone` TEXT,`name` TEXT, PRIMARY KEY(`name`))');
    await database.execute(
        'CREATE TABLE IF NOT EXISTS `WeatherForecastResponse` (`mainModel` TEXT, `windModel` TEXT, `weatherModel` TEXT, `cloudsModel` TEXT,`datetimeTxt` TEXT, PRIMARY KEY(`datetimeTxt`))');
  });
}
