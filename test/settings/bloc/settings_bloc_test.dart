import 'package:bit_weather/settings/bloc/settings_bloc.dart';
import 'package:bit_weather/settings/bloc/settings_event.dart';
import 'package:bit_weather/settings/bloc/settings_state.dart';
import 'package:bit_weather/models/settings.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group('Settings - SettingsBloc', () {
    blocTest<SettingsBloc, SettingsState>(
      'Updates the settings',
      build: () => SettingsBloc(),
      act: (bloc) {
        return bloc.add(UpdateSettings(Settings(
          units: UnitType.fahrenheit,
          flag: Flag.br,
        )));
      },
      expect: () => [
        SettingsState(
            settings: Settings(
          units: UnitType.fahrenheit,
          flag: Flag.br,
        )),
      ],
    );
  });
}
