import 'package:bit_weather/models/location.dart';
import 'package:test/test.dart';

void main() {
  group('Models - Location', () {
    test('Correctly serializes/deserializes', () {
      final original = Location(
          title: 'Rome',
          woeid: 10,
      );

      final json = original.toJson();

      final deserialized = Location.fromJson(json);
      expect(original, deserialized);
    });
  });
}
