import '../../../../core/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../weather/presentation/bloc/current/weather_bloc.dart';
import '../../../weather/presentation/bloc/current/weather_state.dart';
import '../../../weather/presentation/widgets/weather_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late WeatherBloc _weatherBloc;
  String? selectedValue = 'Brazil';
  @override
  void initState() {
    _weatherBloc = BlocProvider.of<WeatherBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            return _homeScreenBuilder(state);
          },
        ),
      ),
    );
  }

  Widget _homeScreenBuilder(WeatherState state) {
    switch (state.status) {
      case WeatherStatus.loading:
        return _loading(state);
      case WeatherStatus.ready:
        return _ready(state);
      case WeatherStatus.error:
        return _error(state.messageError);
    }
  }

  Widget _loading(WeatherState state) {
    _weather(lat: -23.54997337269365, lon: -46.63347950124977);
    return const SizedBox(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _ready(WeatherState state) {
    var weather = state.weatherResponse;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: [
            const SizedBox(height: 30),
            SizedBox(
              child: DropdownButton(
                value: selectedValue,
                items: [
                  DropdownMenuItem<String>(
                    value: 'Brazil',
                    child: const Text(AppStrings.weatherLocaleTitleBR),
                    onTap: () {
                      _weather(lat: -23.2229561918827, lon: -46.64245054591607);
                    },
                  ),
                  DropdownMenuItem<String>(
                    value: 'UK',
                    child: const Text(AppStrings.weatherLocaleTitleUK),
                    onTap: () {
                      _weather(lat: 52.102578937314966, lon: -1.0317649109021738);
                    },
                  ),
                  DropdownMenuItem<String>(
                    value: 'Australia',
                    child: const Text(AppStrings.weatherLocaleTitleAU),
                    onTap: () {
                      _weather(lat: -36.80965823768071, lon: 144.92780683490028);
                    },
                  ),
                  DropdownMenuItem<String>(
                    value: 'Monaco',
                    child: const Text(AppStrings.weatherLocaleTitleMC),
                    onTap: () {
                      _weather(lat: 43.73749909023319, lon: 7.420571208383592);
                    },
                  ),
                ],
                onChanged: ((String? value) {
                  setState(() {
                    selectedValue = value!;
                  });
                }),
              ),
            ),
            const SizedBox(height: 30),
            WeatherCard(
              onTap: () => openForecast(
                lat: state.weatherResponse?.cord?.lat ?? 0,
                lon: state.weatherResponse?.cord?.lon ?? 0,
              ),
              mainDescription: weather?.weather?.first.description?.toUpperCase(),
              temp: weather?.main?.temp.toString(),
              tempMax: weather?.main?.tempMax.toString(),
              tempMin: weather?.main?.tempMin.toString(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _error(String? msgError) {
    return SizedBox(
      child: Center(
        child: Text(msgError ?? 'aaaaa'),
      ),
    );
  }

  void _weather({required double lat, required double lon}) {
    _weatherBloc.add(LoadWeather(lat: lat, lon: lon));
  }

  void openForecast({
    required double lat,
    required double lon,
  }) {
    Navigator.of(context).pushNamed(Routes.forecast, arguments: [lat, lon]);
  }
}
