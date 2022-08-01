import 'dart:convert';

import 'package:floor/floor.dart';

import '../models/current/coord_model.dart';

class CoordConverter extends TypeConverter<CoordModel?, String> {
  @override
  CoordModel? decode(String databaseValue) {
    return CoordModel.fromJson(jsonDecode(databaseValue));
  }

  @override
  String encode(CoordModel? value) {
    return jsonEncode(CoordModel.toJson(value!));
  }
}
