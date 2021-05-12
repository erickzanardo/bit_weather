import 'package:bit_weather/repositories/cache_repository.dart';
import 'package:bit_weather/settings/bloc/settings_bloc.dart';
import 'package:bit_weather/settings/bloc/settings_event.dart';
import 'package:bit_weather/settings/bloc/settings_state.dart';
import 'package:bit_weather/models/settings.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

class CacheRepositoryMock extends Mock implements CacheRepository {}

void main() {
  final settings = Settings(
    units: UnitType.fahrenheit,
    flag: Flag.br,
  );
  group('Settings - SettingsBloc', () {
    blocTest<SettingsBloc, SettingsState>(
      'Updates the settings and caches it',
      build: () => SettingsBloc(cacheRepository: CacheRepositoryMock()),
      act: (bloc) {
        return bloc.add(UpdateSettings(settings));
      },
      expect: () => [
        SettingsState(
            settings: Settings(
          units: UnitType.fahrenheit,
          flag: Flag.br,
        )),
      ],
      verify: (bloc) {
        verify(() => bloc.cacheRepository.cacheSettings(settings)).called(1);
      },
    );
  });
}
