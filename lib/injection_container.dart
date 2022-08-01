import 'features/weather/presentation/bloc/forecast/forecast_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'core/api/api_interceptor.dart';
import 'core/api/i_api_interceptor.dart';
import 'core/api/i_url_creator.dart';
import 'core/api/url_creator.dart';
import 'core/database/app_database.dart';
import 'features/weather/data/datasources/local/weather_local_datasource.dart';
import 'features/weather/data/datasources/remote/weather_remote_datasource.dart';
import 'features/weather/data/repositories/weather_repository.dart';
import 'features/weather/domain/repositories/i_weather_repository.dart';
import 'features/weather/domain/usecases/get_forecast.dart';
import 'features/weather/domain/usecases/get_weather.dart';
import 'features/weather/presentation/bloc/current/weather_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<IUrlCreator>(() => UrlCreator());
  sl.registerLazySingleton<IHttpClient>(() => HttpClient());
  sl.registerLazySingleton(() => http.Client());

  final database = await $FloorAppDatabase.databaseBuilder('cloudwalk_test.db').addMigrations([
    AppDatabase.migration1to2,
  ]).build();

  sl.registerLazySingleton<AppDatabase>(() => database);

  //! Weather
  //! Datasources
  sl.registerLazySingleton(() => WeatherRemoteDatasource(sl(), sl()));
  sl.registerLazySingleton(() => WeatherLocalDatasource(sl<AppDatabase>().weatherDao, sl<AppDatabase>().forecastDao));

  //! Repository
  sl.registerLazySingleton<IWeatherRepository>(() => WeatherRepository(sl(), sl()));

  //UseCase
  sl.registerLazySingleton(() => GetWeather(sl()));
  sl.registerLazySingleton(() => GetForecast(sl()));

  //Bloc
  sl.registerLazySingleton(() => WeatherBloc(sl()));
  sl.registerLazySingleton(() => ForecastBloc(sl()));

  await sl.allReady();
}
