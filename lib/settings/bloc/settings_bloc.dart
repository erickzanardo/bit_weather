import 'package:bit_weather/models/settings.dart';
import 'package:bit_weather/repositories/cache_repository.dart';
import 'package:bit_weather/settings/bloc/settings_event.dart';
import 'package:bit_weather/settings/bloc/settings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({
    required this.cacheRepository,
    Settings? initialSettings,
  }) : super(
          SettingsState(
            settings: initialSettings ??
                Settings(
                  units: UnitType.celsius,
                  flag: Flag.us,
                ),
          ),
        );

  final CacheRepository cacheRepository;

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is UpdateSettings) {
      yield SettingsState(settings: event.newSettings);
      cacheRepository.cacheSettings(event.newSettings);
    }
  }
}
