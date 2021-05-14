import 'package:bit_weather/weather_page/widgets/weather_background/weather_background.dart';
import 'package:flame/game.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bit_weather/models/weather.dart';

import '../../../helpers/helpers.dart';

/*
   TODO(erick) When I first tried to test this I wanted to make
   some golden tests since due to the graphical nature of a Flame game
   those type of tests would be quite nice, but while doing so
   I discovered a very strange bug on Flame where it is impossible
   to use asset Flame inside testWidgets.

   I have opened an issue on Flame regarding that:
   https://github.com/flame-engine/flame/issues/790

   Will investigate that issue further later, and upon that issue fix
   this test could be improved a lot, right now it just makes sure that the
   wrapper widget of the game is rendered and presents a GameWidget
*/

void main() {
  group('WeatherPage - WeatherBackground', () {
    testWidgets(
      'Renders WeatherBackground renders a GameWidget',
      (tester) async {
        await tester.pumpAndSettleApp(
          WeatherBackground(weatherType: WeatherType.snow),
        );

        expect(
          find.byWidgetPredicate((x) => x is GameWidget<WeatherBackgroundGame>),
          findsOneWidget,
        );
      },
    );
  });
}
