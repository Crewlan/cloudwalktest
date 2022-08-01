import 'package:equatable/equatable.dart';

import '../../../domain/entities/current/weather_response.dart';

enum WeatherStatus { loading, error, ready }

class WeatherState extends Equatable {
  final WeatherStatus status;
  final WeatherResponse? weatherResponse;
  final String? messageError;

  const WeatherState._(
    this.status,
    this.weatherResponse,
    this.messageError,
  );

  @override
  List<Object?> get props => [
        status,
        weatherResponse,
        messageError,
      ];

  const WeatherState.initial() : this._(WeatherStatus.loading, null, null);

  WeatherState loading() => WeatherState._(
        WeatherStatus.loading,
        weatherResponse,
        messageError,
      );

  WeatherState ready(WeatherResponse weatherResponse) => WeatherState._(
        WeatherStatus.ready,
        weatherResponse,
        messageError,
      );

  WeatherState error(String? msgError) => WeatherState._(
        WeatherStatus.error,
        weatherResponse,
        msgError,
      );
}
