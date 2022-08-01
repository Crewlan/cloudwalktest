import 'dart:convert';

import 'package:floor/floor.dart';

import '../models/current/main_model.dart';

class MainConverter extends TypeConverter<MainModel?, String> {
  @override
  MainModel? decode(String databaseValue) {
    return MainModel.fromJson(jsonDecode(databaseValue));
  }

  @override
  String encode(MainModel? value) {
    return jsonEncode(MainModel.toJson(value!));
  }
}
