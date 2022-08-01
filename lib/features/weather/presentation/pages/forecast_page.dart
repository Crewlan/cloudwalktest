import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../bloc/forecast/forecast_bloc.dart';
import '../bloc/forecast/forecast_state.dart';

class ForecastPage extends StatefulWidget {
  final double lat;
  final double lon;

  const ForecastPage({
    Key? key,
    required this.lat,
    required this.lon,
  }) : super(key: key);

  @override
  State<ForecastPage> createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  late ForecastBloc _forecastBloc;

  @override
  void initState() {
    _forecastBloc = BlocProvider.of<ForecastBloc>(context);
    _forecastBloc.add(LoadForecast(lat: widget.lat, lon: widget.lon));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.forecastTitle),
        ),
        body: BlocBuilder<ForecastBloc, ForecastState>(
          builder: (context, state) => Scaffold(
            body: _builderScreen(state),
          ),
        ),
      ),
    );
  }

  Widget _builderScreen(ForecastState state) {
    switch (state.status) {
      case ForecastStatus.loading:
        return _loading();
      case ForecastStatus.ready:
        return _ready(state);
      case ForecastStatus.error:
        return _error(state.messageError);
    }
  }

  Widget _loading() {
    return const SizedBox(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _ready(ForecastState state) {
    state.weatherForecastResponse!.removeWhere((element) => element.datetimeTxt!.hour >= 01);
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            const Text(AppStrings.forecastDescription),
            const SizedBox(height: 20),
            Container(
                height: 150,
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.blueLightest,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: state.weatherForecastResponse?.length,
                    itemBuilder: (context, position) {
                      var dateFormated = DateFormat.E('pt_br').format(
                        state.weatherForecastResponse![position].datetimeTxt!,
                      );
                      var forecast = state.weatherForecastResponse?[position];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(dateFormated),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Text(forecast?.main?.tempMax.toString() ?? ''),
                                const Icon(Icons.arrow_drop_up_rounded),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Text(forecast?.main?.tempMin.toString() ?? ''),
                                const Icon(Icons.arrow_drop_down_rounded),
                              ],
                            ),
                          ],
                        ),
                      );
                    })),
          ],
        ),
      ),
    );
  }

  Widget _error(String? msgError) {
    return SizedBox(
      child: Center(
        child: Text(msgError!),
      ),
    );
  }
}
