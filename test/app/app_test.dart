import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:bit_weather/repositories/weather_repository.dart';
import 'package:bit_weather/app/app.dart';

import '../helpers/helpers.dart';

class WeatherRepositoryMock extends Mock implements WeatherRepository {}
void main() {
  group('App', () {
    testWidgets('Renders the app correctly', (tester) async {
      await tester.pumpApp(App(repository: WeatherRepositoryMock()));

      expect(find.text('No location selected yet'), findsOneWidget);
    });
  });
}
