// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherLocation _$WeatherLocationFromJson(Map<String, dynamic> json) {
  return WeatherLocation(
    location: Location.fromJson(json['location'] as Map<String, dynamic>),
    weather: Weather.fromJson(json['weather'] as Map<String, dynamic>),
    updatedAt: DateTime.parse(json['updatedAt'] as String),
  );
}

Map<String, dynamic> _$WeatherLocationToJson(WeatherLocation instance) =>
    <String, dynamic>{
      'location': instance.location.toJson(),
      'weather': instance.weather.toJson(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
