import 'package:bloc/bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/usecases/get_weather.dart';
import 'weather_state.dart';

part 'weather_event.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeather getWeather;

  WeatherBloc(this.getWeather) : super(const WeatherState.initial()) {
    on<LoadWeather>((event, emit) async {
      emit(state.loading());
      var fold = await getWeather(lat: event.lat, lon: event.lon);
      emit(await fold.fold(
        (failure) => state.error(_mapWeatherFailureToString(failure)),
        (weather) => state.ready(weather),
      ));
    });
  }

  String _mapWeatherFailureToString(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Erro ao conectar ao servidor';
      default:
        return 'Erro tente novamente!';
    }
  }
}
