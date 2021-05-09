import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

enum WeatherType {
  @JsonValue('sn')
  snow,
  @JsonValue('sl')
  sleet,
  @JsonValue('h')
  hail,
  @JsonValue('t')
  thunderstorm,
  @JsonValue('hr')
  heavyRain,
  @JsonValue('lr')
  lightRain,
  @JsonValue('s')
  showers,
  @JsonValue('hc')
  heavyCloud,
  @JsonValue('lc')
  lightCloud,
  @JsonValue('c')
  clear,
}

@JsonSerializable()
class Weather extends Equatable {
  Weather({
    required this.id,
    required this.weatherState,
    required this.minTemp,
    required this.currentTemp,
    required this.maxTemp,
    required this.windSpeed,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return _$WeatherFromJson(json);
  }

  final int id;
  @JsonKey(name: 'min_temp')
  final double minTemp;
  @JsonKey(name: 'max_temp')
  final double maxTemp;
  @JsonKey(name: 'the_temp')
  final double currentTemp;
  @JsonKey(name: 'weather_state_abbr')
  final WeatherType weatherState;
  @JsonKey(name: 'wind_speed')
  final double windSpeed;

  Map<String, dynamic> toJson() => _$WeatherToJson(this);

  @override
  List<Object?> get props {
    return [
      id,
      minTemp,
      maxTemp,
      currentTemp,
      weatherState,
      windSpeed,
    ];
  }
}
