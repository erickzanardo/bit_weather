import 'package:equatable/equatable.dart';

enum UnitType {
  fahrenheit,
  celsius,
}

class SettingsState extends Equatable {
  SettingsState({
    required this.units,
  });

  final UnitType units;

  @override
  List<Object?> get props => [units];
}
