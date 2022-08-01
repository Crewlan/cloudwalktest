// import 'package:cloudwalktest/features/weather/presentation/bloc/forecast/forecast_state.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// import '../../../../core/utils/app_colors.dart';

// class ForecastCard extends StatelessWidget {
//   final String? tempMin;
//   final String? tempMax;
//   final ForecastState state;
//   const ForecastCard({Key? key, this.tempMin, this.tempMax, required this.state}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // var forecastList = state.weatherForecastResponse.removeWhere((element) => element.)

//     return Container(
//         width: 200,
//         height: 200,
//         margin: const EdgeInsets.symmetric(vertical: 10),
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: AppColors.blueLightest,
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Row(
//           children: [
//             ListView.builder(
//                 // shrinkWrap: true,
//                 itemCount: 1,
//                 itemBuilder: (context, position) {
//                   var date = DateTime.parse(state.weatherForecastResponse?[position].datetimeTxt ?? '');
//                   var dateFormated = DateFormat.EEEE().format(date);
//                   return Text(dateFormated);
//                 })
//           ],
//         ));
//   }
// }
