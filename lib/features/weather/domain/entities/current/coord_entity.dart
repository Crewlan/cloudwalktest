import 'package:equatable/equatable.dart';

class Coord extends Equatable {
  final double? lat;
  final double? lon;

  const Coord({this.lat, this.lon});

  @override
  List<Object?> get props => [lat, lon];
}
