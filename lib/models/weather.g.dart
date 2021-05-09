// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Weather _$WeatherFromJson(Map<String, dynamic> json) {
  return Weather(
    id: json['id'] as int,
    weatherState:
        _$enumDecode(_$WeatherTypeEnumMap, json['weather_state_abbr']),
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
      'weather_state_abbr': _$WeatherTypeEnumMap[instance.weatherState],
      'wind_speed': instance.windSpeed,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$WeatherTypeEnumMap = {
  WeatherType.snow: 'sn',
  WeatherType.sleet: 'sl',
  WeatherType.hail: 'h',
  WeatherType.thunderstorm: 't',
  WeatherType.heavyRain: 'hr',
  WeatherType.lightRain: 'lr',
  WeatherType.showers: 's',
  WeatherType.heavyCloud: 'hc',
  WeatherType.lightCloud: 'lc',
  WeatherType.clear: 'c',
};
