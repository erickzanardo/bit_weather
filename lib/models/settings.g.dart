// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Settings _$SettingsFromJson(Map<String, dynamic> json) {
  return Settings(
    units: _$enumDecode(_$UnitTypeEnumMap, json['units']),
    flag: _$enumDecode(_$FlagEnumMap, json['flag']),
  );
}

Map<String, dynamic> _$SettingsToJson(Settings instance) => <String, dynamic>{
      'units': _$UnitTypeEnumMap[instance.units],
      'flag': _$FlagEnumMap[instance.flag],
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

const _$UnitTypeEnumMap = {
  UnitType.fahrenheit: 'fahrenheit',
  UnitType.celsius: 'celsius',
};

const _$FlagEnumMap = {
  Flag.br: 'br',
  Flag.us: 'us',
};
