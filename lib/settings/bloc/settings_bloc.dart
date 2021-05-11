import 'package:bit_weather/models/settings.dart';
import 'package:bit_weather/settings/bloc/settings_event.dart';
import 'package:bit_weather/settings/bloc/settings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc()
      : super(
          SettingsState(
            settings: Settings(
                units: UnitType.celsius,
                flag: Flag.us,
            ),
          ),
        );

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is UpdateSettings) {
      yield SettingsState(settings: event.newSettings);
    }
  }
}
