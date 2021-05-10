import 'package:bit_weather/models/settings.dart';
import 'package:test/test.dart';
import 'package:bit_weather/settings/bloc/settings_event.dart';

void main() {
  group('Settings - events', () {
    group('ToggleTemperatureUnits', () {
      test('objects are equals when on the settings are the same', () {
        final event = UpdateSettings(Settings(units: UnitType.celsius));
        final anotherEvent = UpdateSettings(Settings(units: UnitType.celsius));

        expect(event, anotherEvent);
      });

      test('objects are not equals when on the settings are not the same', () {
        final event = UpdateSettings(Settings(units: UnitType.fahrenheit));
        final anotherEvent = UpdateSettings(Settings(units: UnitType.celsius));

        expect(event, isNot(equals(anotherEvent)));
      });
    });
  });
}
