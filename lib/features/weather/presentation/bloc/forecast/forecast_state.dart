import 'package:equatable/equatable.dart';

import '../../../domain/entities/forecast/weather_forecast_response.dart';

enum ForecastStatus { loading, error, ready }

class ForecastState extends Equatable {
  final ForecastStatus status;
  final List<WeatherForecastResponse>? weatherForecastResponse;
  final String? messageError;

  const ForecastState._(
    this.status,
    this.weatherForecastResponse,
    this.messageError,
  );

  @override
  List<Object?> get props => [
        status,
        weatherForecastResponse,
        messageError,
      ];

  const ForecastState.initial() : this._(ForecastStatus.loading, null, null);

  ForecastState loading() => ForecastState._(
        ForecastStatus.loading,
        weatherForecastResponse,
        messageError,
      );

  ForecastState ready(List<WeatherForecastResponse> weatherResponse) => ForecastState._(
        ForecastStatus.ready,
        weatherResponse,
        messageError,
      );

  ForecastState error(String? msgError) => ForecastState._(
        ForecastStatus.error,
        weatherForecastResponse,
        msgError,
      );
}
