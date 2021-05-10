import 'package:bit_weather/models/settings.dart';
import 'package:bit_weather/settings/bloc/widgets/settings_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

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
  });
}
