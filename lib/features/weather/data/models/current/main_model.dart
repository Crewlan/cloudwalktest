import 'package:equatable/equatable.dart';

import '../../../domain/entities/current/main_entity.dart';

class MainModel extends Equatable {
  final dynamic temp;
  final dynamic feelsLike;
  final dynamic tempMin;
  final dynamic tempMax;
  final int? pressure;
  final int? humidity;

  const MainModel({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
  });

  factory MainModel.fromJson(Map<String, dynamic> json) => MainModel(
        temp: json['temp'],
        feelsLike: json['feels_like'],
        tempMin: json['temp_min'],
        tempMax: json['temp_max'],
        pressure: json['pressure'],
        humidity: json['humidity'],
      );

  Main toEntity() => Main(
        temp: temp,
        feelsLike: feelsLike,
        tempMin: tempMin,
        tempMax: tempMax,
        pressure: pressure,
        humidity: humidity,
      );

  static Map<String, dynamic> toJson(MainModel mainModel) => {
        'temp': mainModel.temp,
        'feels_like': mainModel.feelsLike,
        'temp_min': mainModel.tempMin,
        'temp_max': mainModel.tempMax,
        'pressure': mainModel.pressure,
        'humidity': mainModel.humidity
      };

  @override
  List<Object?> get props {
    return [
      temp,
      feelsLike,
      tempMin,
      tempMax,
      pressure,
      humidity,
    ];
  }
}
