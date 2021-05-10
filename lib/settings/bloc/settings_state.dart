import 'package:bit_weather/models/settings.dart';
import 'package:equatable/equatable.dart';

class SettingsState extends Equatable {
  SettingsState({
    required this.settings,
  });

  final Settings settings;

  @override
  List<Object?> get props => [settings];
}
