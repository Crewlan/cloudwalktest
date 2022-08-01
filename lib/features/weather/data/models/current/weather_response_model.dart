import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import '../../../domain/entities/current/weather_response.dart';
import 'coord_model.dart';
import 'main_model.dart';
import 'weather_model.dart';

@Entity(tableName: 'WeatherResponse')
class WeatherResponseModel extends Equatable {
  final MainModel? mainModel;
  final List<WeatherModel>? weatherModel;
  @primaryKey
  final String? name;
  final CoordModel? cordModel;

  const WeatherResponseModel({
    this.mainModel,
    this.weatherModel,
    this.name,
    this.cordModel,
  });

  @override
  List<Object?> get props {
    return [
      mainModel,
      weatherModel,
      name,
      cordModel,
    ];
  }

  factory WeatherResponseModel.fromJson(Map<String, dynamic> json) => WeatherResponseModel(
        mainModel: MainModel.fromJson(
          json['main'],
        ),
        weatherModel: (json['weather'] as List).map((e) => WeatherModel.fromJson(e)).toList(),
        name: json['name'],
        cordModel: CoordModel.fromJson(json['coord']),
      );

  WeatherResponse toEntity() => WeatherResponse(
        main: mainModel?.toEntity(),
        weather: weatherModel?.map((e) => e.toEntity()).toList(),
        cord: cordModel?.toEntity(),
      );
}
