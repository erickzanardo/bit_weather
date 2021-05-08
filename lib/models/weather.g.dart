// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Weather _$WeatherFromJson(Map<String, dynamic> json) {
  return Weather(
    id: json['id'] as int,
    weatherState: json['weather_state_abbr'] as String,
    minTemp: (json['min_temp'] as num).toDouble(),
    currentTemp: (json['the_temp'] as num).toDouble(),
    maxTemp: (json['max_temp'] as num).toDouble(),
    windSpeed: (json['wind_speed'] as num).toDouble(),
  );
}

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'id': instance.id,
      'min_temp': instance.minTemp,
      'max_temp': instance.maxTemp,
      'the_temp': instance.currentTemp,
      'weather_state_abbr': instance.weatherState,
      'wind_speed': instance.windSpeed,
    };
