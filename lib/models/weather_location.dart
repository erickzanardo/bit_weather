import 'package:bit_weather/models/location.dart';
import 'package:bit_weather/models/weather.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather_location.g.dart';

@JsonSerializable(explicitToJson: true)
class WeatherLocation extends Equatable {
  WeatherLocation({
    required this.location,
    required this.weather,
    required this.updatedAt,
  });

  factory WeatherLocation.fromJson(Map<String, dynamic> json) {
    return _$WeatherLocationFromJson(json);
  }

  final Location location;
  final Weather weather;
  final DateTime updatedAt;

  @override
  List<Object?> get props => [location, weather, updatedAt];

  Map<String, dynamic> toJson() {
    return _$WeatherLocationToJson(this);
  }
}
