import 'package:bit_weather/weather_page/widgets/weather_type_label.dart';
import 'package:bit_weather/models/weather.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/helpers.dart';

void main() {
  final asserts = {
    WeatherType.snow: 'Snow',
    WeatherType.sleet: 'Sleet',
    WeatherType.hail: 'Hail',
    WeatherType.thunderstorm: 'Thunderstorm',
    WeatherType.heavyRain: 'Heavy Rain',
    WeatherType.lightRain: 'Light Rain',
    WeatherType.showers: 'Showers',
    WeatherType.heavyCloud: 'Heavy clouds',
    WeatherType.lightCloud: 'Light Clouds',
    WeatherType.clear: 'Clear'
  };
  group('Widgets - WeatherTypeLabel', () {
    for (var entry in asserts.entries) {
      testWidgets(
        'returns the right label when is ${entry.key}',
        (tester) async {
          await tester.pumpApp(WeatherTypeLabel(type: entry.key));
          expect(find.text(entry.value), findsOneWidget);
        },
      );
    }
  });
}
