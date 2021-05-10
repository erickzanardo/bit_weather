import 'package:test/test.dart';
import 'package:bit_weather/settings/bloc/settings_event.dart';

void main() {
  group('Settings - events', () {
    group('ToggleTemperatureUnits', () {
      test('all objects are equal', () {
        final event = const ToggleTemperatureUnits();
        final anotherEvent = const ToggleTemperatureUnits();

        expect(event.props, []);
        expect(event, anotherEvent);
      });
    });
  });
}
