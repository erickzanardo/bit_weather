import 'package:bit_weather/models/settings.dart';
import 'package:bit_weather/models/weather.dart';
import 'package:test/test.dart';

void main() {
  group('Models - Settings', () {
    test('Correctly serializes/deserializes', () {
      final original = Settings(
        useCelsius: true,
      );

      final json = original.toJson();

      final deserialized = Weather.fromJson(json);
      expect(original, deserialized);
    });
  });
}
