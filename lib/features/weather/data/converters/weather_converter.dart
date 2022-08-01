import 'dart:convert';

import 'package:floor/floor.dart';

import '../models/current/weather_model.dart';

class WeatherConverter extends TypeConverter<List<WeatherModel>?, String> {
  @override
  List<WeatherModel>? decode(String databaseValue) {
    return (jsonDecode(databaseValue) as List).map((e) => WeatherModel.fromJson(e)).toList();
  }

  @override
  String encode(List<WeatherModel>? value) {
    return jsonEncode(value?.map(WeatherModel.toJson).toList());
  }
}
