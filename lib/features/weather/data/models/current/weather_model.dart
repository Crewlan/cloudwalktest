import 'package:equatable/equatable.dart';

import '../../../domain/entities/current/weather_entity.dart';

class WeatherModel extends Equatable {
  final String? description;

  const WeatherModel({
    this.description,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        description: json['description'],
      );

  factory WeatherModel.fromEntity(Weather entity) => WeatherModel(
        description: entity.description,
      );

  Weather toEntity() => Weather(
        description: description,
      );

  static Map<String, dynamic> toJson(WeatherModel weatherModel) => {
        'description': weatherModel.description,
      };

  @override
  List<Object?> get props => [description];
}
