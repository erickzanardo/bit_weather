import 'package:bit_weather/models/location.dart';
import 'package:bit_weather/models/weather.dart';
import 'package:bit_weather/models/weather_location.dart';
import 'package:test/test.dart';

void main() {
  group('Models - WeatherLocation', () {
    test('Correctly serializes/deserializes', () {
      final original = WeatherLocation(
        updatedAt: DateTime.now(),
        weather: Weather(
          id: 1,
          minTemp: 10.0,
          maxTemp: 20.0,
          currentTemp: 15.0,
          windSpeed: 10,
          weatherState: WeatherType.clear,
        ),
        location: Location(
          title: 'Rome',
          woeid: 10,
        ),
      );

      final json = original.toJson();

      final deserialized = WeatherLocation.fromJson(json);
      expect(original, deserialized);
    });
  });
}
