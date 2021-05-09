import 'package:bit_weather/models/weather.dart';
import 'package:test/test.dart';

void main() {
  group('Models - Weather', () {
    test('Correctly serializes/deserializes', () {
      final original = Weather(
        id: 1,
        minTemp: 10.0,
        maxTemp: 20.0,
        currentTemp: 15.0,
        windSpeed: 10,
        weatherState: WeatherType.clear,
      );

      final json = original.toJson();

      final deserialized = Weather.fromJson(json);
      expect(original, deserialized);
    });
  });
}
