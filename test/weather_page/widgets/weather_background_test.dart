import 'package:bit_weather/weather_page/widgets/weather_background/weather_background.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bit_weather/models/weather.dart';

import '../../helpers/helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('WeatherPage - WeatherBackground', () {
    for (var type in WeatherType.values) {
      testWidgets(
        'Renders WeatherBackground with $type correctly',
        (tester) async {
          await tester.pumpAndSettleApp(
              WeatherBackground(weatherType: type),
          );
          await expectLater(
              find.byType(WeatherBackground),
              matchesGoldenFile('golden/weather_background_$type.png'),
          );
        },
      );
    }
  });
}
