import 'package:bit_weather/settings/bloc/settings_bloc.dart';
import 'package:bit_weather/settings/bloc/settings_event.dart';
import 'package:bit_weather/settings/bloc/settings_state.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group('Settings - SettingsBloc', () {
    blocTest<SettingsBloc, SettingsState>(
      'Toggles the temperature unit',
      build: () => SettingsBloc(),
      act: (bloc) {
        bloc
          ..add(const ToggleTemperatureUnits())
          ..add(const ToggleTemperatureUnits());
      },
      expect: () => [
        SettingsState(units: UnitType.fahrenheit),
        SettingsState(units: UnitType.celsius),
      ],
    );
  });
}
