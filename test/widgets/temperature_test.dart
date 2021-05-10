import 'package:bit_weather/models/settings.dart';
import 'package:bit_weather/widgets/temperature.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/helpers.dart';

void main() {
  group('Widgets - Temperature', () {
    group('Celsius', () {
      testWidgets('Renders correctly', (tester) async {
        await tester.pumpApp(
          Temperature(celsius: 15, unitType: UnitType.celsius),
        );

        expect(find.text('15C°'), findsOneWidget);
      });

      testWidgets('Renders correctly when it is the current', (tester) async {
        await tester.pumpApp(
          Temperature(
            celsius: 15,
            unitType: UnitType.celsius,
            current: true,
          ),
        );

        expect(find.text('15C°'), findsOneWidget);
      });
    });

    group('Fahrenheit', () {
      testWidgets('Renders correctly', (tester) async {
        await tester.pumpApp(
          Temperature(celsius: 15, unitType: UnitType.fahrenheit),
        );

        expect(find.text('59F°'), findsOneWidget);
      });

      testWidgets('Renders correctly when it is the current', (tester) async {
        await tester.pumpApp(
          Temperature(
            celsius: 15,
            unitType: UnitType.fahrenheit,
            current: true,
          ),
        );

        expect(find.text('59F°'), findsOneWidget);
      });
    });
  });
}
