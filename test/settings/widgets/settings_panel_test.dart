import 'package:bit_weather/models/settings.dart';
import 'package:bit_weather/settings/widgets/settings_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

abstract class StubWrapper {
  void onSave(Settings settings);
}

class StubWrapperMock extends Mock implements StubWrapper {}

void main() {
  group('Settings - SettingsPanel', () {
    testWidgets('Renders correctly', (tester) async {
      await tester.pumpApp(
        Scaffold(
            body: SettingsPanel(
                currentSettings: Settings(units: UnitType.celsius),
                onSave: (_) {})),
      );

      expect(find.text('Settings'), findsOneWidget);
    });

    testWidgets('Changes the units', (tester) async {
      final stub = StubWrapperMock();
      await tester.pumpApp(
        Scaffold(
          body: SettingsPanel(
              currentSettings: Settings(units: UnitType.celsius),
              onSave: stub.onSave),
        ),
      );

      final switchField = find.byKey(const Key('toggle_units_type'));
      await tester.tap(switchField);

      final saveButton = find.text('Save');
      await tester.tap(saveButton);

      verify(() => stub.onSave(Settings(units: UnitType.fahrenheit))).called(1);
    });
  });
}
