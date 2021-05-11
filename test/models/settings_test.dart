import 'package:bit_weather/models/settings.dart';
import 'package:test/test.dart';

void main() {
  group('Models - Settings', () {
    test('Correctly serializes/deserializes', () {
      final original = Settings(
        units: UnitType.celsius,
        flag: Flag.br,
      );

      final json = original.toJson();

      final deserialized = Settings.fromJson(json);
      expect(original, deserialized);
    });
  });
}
