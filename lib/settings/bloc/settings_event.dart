import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
}

class ToggleTemperatureUnits extends SettingsEvent {
  const ToggleTemperatureUnits() : super();

  @override
  List<Object?> get props => [];
}
