import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/home/presentation/pages/home_page.dart';
import '../../features/weather/presentation/bloc/current/weather_bloc.dart';
import '../../features/weather/presentation/bloc/forecast/forecast_bloc.dart';
import '../../features/weather/presentation/pages/forecast_page.dart';
import '../../injection_container.dart';
import 'routes.dart';

class AppRouter {
  final _weatherBloc = sl<WeatherBloc>();
  final _forecastBloc = sl<ForecastBloc>();

  Route generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _weatherBloc,
            child: const HomePage(),
          ),
        );
      case Routes.forecast:
        return MaterialPageRoute(
          builder: (_) {
            var args = settings.arguments as List;
            return BlocProvider.value(
              value: _forecastBloc,
              child: ForecastPage(
                lat: args[0] as double,
                lon: args[1] as double,
              ),
            );
          },
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: SafeArea(
                child: Center(
              child: Text('Erro'),
            )),
          ),
        );
    }
  }
}
