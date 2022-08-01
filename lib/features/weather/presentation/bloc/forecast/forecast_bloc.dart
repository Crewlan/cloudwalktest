import 'package:bloc/bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/usecases/get_forecast.dart';
import 'forecast_state.dart';

part 'forecast_event.dart';

class ForecastBloc extends Bloc<ForecastEvent, ForecastState> {
  final GetForecast getForecast;

  ForecastBloc(this.getForecast) : super(const ForecastState.initial()) {
    on<LoadForecast>((event, emit) async {
      emit(state.loading());
      var fold = await getForecast(event.lat, event.lon);
      emit(await fold.fold(
        (failure) => state.error(_mapForecastFailureToString(failure)),
        (forecast) => state.ready(forecast),
      ));
    });
  }

  String _mapForecastFailureToString(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Erro ao conectar ao servidor';
      default:
        return 'Erro tente novamente!';
    }
  }
}
