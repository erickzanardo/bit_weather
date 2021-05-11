import 'package:bit_weather/models/settings.dart';
import 'package:test/test.dart';
import 'package:bit_weather/settings/bloc/settings_event.dart';

void main() {
  group('Settings - events', () {
    group('ToggleTemperatureUnits', () {
      test('objects are equals when on the settings are the same', () {
        final event = UpdateSettings(Settings(
          units: UnitType.celsius,
          flag: Flag.us,
        ));
        final anotherEvent = UpdateSettings(Settings(
          units: UnitType.celsius,
          flag: Flag.us,
        ));

        expect(event, anotherEvent);
      });

      test('objects are not equals when the units are not equals', () {
        final event = UpdateSettings(Settings(
          units: UnitType.fahrenheit,
          flag: Flag.us,
        ));
        final anotherEvent = UpdateSettings(Settings(
          units: UnitType.celsius,
          flag: Flag.us,
        ));

        expect(event, isNot(equals(anotherEvent)));
      });

      test('objects are not equals when the flag are not equals', () {
        final event = UpdateSettings(Settings(
          units: UnitType.celsius,
          flag: Flag.br,
        ));
        final anotherEvent = UpdateSettings(Settings(
          units: UnitType.celsius,
          flag: Flag.us,
        ));

        expect(event, isNot(equals(anotherEvent)));
      });
    });
  });
}
