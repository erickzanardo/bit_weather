import 'package:bit_weather/weather_page/widgets/weather_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class AppPageObject {
  AppPageObject(this.tester);

  final WidgetTester tester;

  Future<void> openCitySelection() async {
    final citySelectionButton = find.byKey(const Key('add_city_button'));
    await tester.tap(citySelectionButton);
    await tester.pumpAndSettle();
  }

  Future<void> selectCity(String city) async {
    final cityNameField = find.byKey(const Key('city_text_field'));
    await tester.enterText(cityNameField, city);
    await tester.pumpAndSettle();

    final searchButton = find.text('Search');
    await tester.tap(searchButton);
    await tester.pumpAndSettle();
  }

  Future<void> pullToRefresh() async {
    final view = find.byType(WeatherView);
    await tester.fling(
      view,
      const Offset(0, 100),
      100,
    );
    await tester.pumpAndSettle();
  }
}
