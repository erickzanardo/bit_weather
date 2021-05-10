import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'settings.g.dart';

enum UnitType {
  fahrenheit,
  celsius,
}

@JsonSerializable()
class Settings extends Equatable {
  Settings({
    required this.units,
  });

  factory Settings.fromJson(Map<String, dynamic> json) {
    return _$SettingsFromJson(json);
  }

  final UnitType units;

  Map<String, dynamic> toJson() => _$SettingsToJson(this);

  @override
  List<Object?> get props => [units];
}
