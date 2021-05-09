import 'package:bit_weather/weather_page/widgets/location_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

abstract class StubWrapper {
  void onSelect(String value);
}

class StubWrapperMock extends Mock implements StubWrapper {}

void main() {
  group('WeatherPage - LocationSelection', () {
    testWidgets('Renders correctly', (tester) async {
      await tester.pumpApp(LocationSelection(onSelect: (_) {}));

      final searchButton = find.text('Search');
      expect(searchButton, findsOneWidget);
    });
    testWidgets('Correctly sends the text on the callback', (tester) async {
      final stub = StubWrapperMock();

      await tester.pumpApp(
          LocationSelection(
              onSelect: stub.onSelect,
          ),
      );

      await tester.enterText(find.byType(TextField), 'Rome');
      await tester.pumpAndSettle();

      final searchButton = find.text('Search');
      await tester.tap(searchButton);

      verify(() => stub.onSelect('Rome')).called(1);
    });
  });
}
