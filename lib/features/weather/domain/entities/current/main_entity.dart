import 'package:equatable/equatable.dart';

class Main extends Equatable {
  final dynamic temp;
  final dynamic feelsLike;
  final dynamic tempMin;
  final dynamic tempMax;
  final int? pressure;
  final int? humidity;

  const Main({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
  });

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
