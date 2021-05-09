import 'package:bit_weather/models/location.dart';
import 'package:bit_weather/models/weather.dart';
import 'package:equatable/equatable.dart';

class WeatherLocation extends Equatable {
  WeatherLocation({
    required this.location,
    required this.weather,
    required this.updatedAt,
  });

  final Location location;
  final Weather weather;
  final DateTime updatedAt;

  @override
  List<Object?> get props => [location, weather];
}
