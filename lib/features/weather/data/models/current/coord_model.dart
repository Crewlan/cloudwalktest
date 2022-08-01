import 'package:equatable/equatable.dart';

import '../../../domain/entities/current/coord_entity.dart';

class CoordModel extends Equatable {
  final double? lat;
  final double? lon;

  const CoordModel({this.lat, this.lon});

  factory CoordModel.fromJson(Map<String, dynamic> json) => CoordModel(
        lat: json['lat'],
        lon: json['lon'],
      );

  Coord toEntity() => Coord(
        lat: lat,
        lon: lon,
      );

  static Map<String, dynamic> toJson(CoordModel cordModel) => {'lat': cordModel.lat, 'lon': cordModel.lon};

  @override
  List<Object?> get props => [lat, lon];
}
