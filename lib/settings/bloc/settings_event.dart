import 'package:bit_weather/models/settings.dart';
import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
}

class UpdateSettings extends SettingsEvent {
  UpdateSettings(this.newSettings);

  final Settings newSettings;

  @override
  List<Object?> get props => [newSettings];
}
