import 'package:bit_weather/weather_page/bloc/weather_event.dart';
import 'package:test/test.dart';

void main() {
  group('WeatherPage - WeatherSearch', () {
    test('objects with equal city name are equal', () {
      final event = const WeatherSearch('Rome');
      final anotherEvent = const WeatherSearch('Rome');

      expect(event, anotherEvent);
    });

    test('objects with different city name are not equal', () {
      final event = const WeatherSearch('Treviso');
      final anotherEvent = const WeatherSearch('Rome');

      expect(event, isNot(equals(anotherEvent)));
    });
  });
}
