import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import '../../../../../core/utils/date_time_utils.dart';
import '../../../domain/entities/forecast/weather_forecast_response.dart';
import '../current/main_model.dart';
import '../current/weather_model.dart';

@Entity(tableName: 'WeatherForecastResponse')
class WeatherForecastResponseModel extends Equatable {
  final MainModel? mainModel;
  final List<WeatherModel>? weatherModel;
  @primaryKey
  final DateTime? datetimeTxt;

  const WeatherForecastResponseModel({
    this.mainModel,
    this.weatherModel,
    this.datetimeTxt,
  });

  @override
  List<Object?> get props {
    return [
      mainModel,
      weatherModel,
      datetimeTxt,
    ];
  }

  factory WeatherForecastResponseModel.fromJson(Map<String, dynamic> json) => WeatherForecastResponseModel(
        mainModel: MainModel.fromJson(
          json['main'],
        ),
        weatherModel: (json['weather'] as List).map((e) => WeatherModel.fromJson(e)).toList(),
        datetimeTxt: DateTimeUtils.dateTimeFromString(json['dt_txt']),
      );

  WeatherForecastResponse toEntity() => WeatherForecastResponse(
        main: mainModel?.toEntity(),
        weather: weatherModel?.map((e) => e.toEntity()).toList(),
        datetimeTxt: datetimeTxt,
      );
}
