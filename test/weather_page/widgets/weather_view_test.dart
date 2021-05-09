import 'package:bit_weather/weather_page/widgets/weather_view.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bit_weather/models/location.dart';
import 'package:bit_weather/models/weather.dart';
import 'package:bit_weather/models/weather_location.dart';

import '../../helpers/helpers.dart';

void main() {
  final weather = WeatherLocation(
      updatedAt: DateTime( 2021, 5, 9, 3, 20, 0,  0, 0),
      location: Location(
          title: 'Rome',
          woeid: 10,
      ),
      weather: Weather(
          id: 1,
          minTemp: 10.0,
          maxTemp: 20.0,
          currentTemp: 15.0,
          windSpeed: 10,
          weatherState: WeatherType.clear,
      ),
  );

  group('WeatherPage - WeatherView', () {
    testWidgets('Renders correctly', (tester) async {
      await tester.pumpApp(WeatherView(information: weather));

      expect(find.text('City: Rome'), findsOneWidget);
      expect(find.text('Min: 10.0'), findsOneWidget);
      expect(find.text('Current: 15.0'), findsOneWidget);
      expect(find.text('Updated at: May 9, 2021 - 3:20 AM'), findsOneWidget);
    });
  });
}
