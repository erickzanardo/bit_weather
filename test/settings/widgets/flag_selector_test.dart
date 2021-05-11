import 'package:bit_weather/models/settings.dart';
import 'package:bit_weather/settings/widgets/flag_selector.dart';
import 'package:bit_weather/settings/widgets/settings_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

abstract class StubWrapper {
  void onChange(Flag flag);
}

class StubWrapperMock extends Mock implements StubWrapper {}

void main() {
  group('Settings - FlagSelector', () {
    testWidgets('Renders correctly', (tester) async {
      await tester.pumpApp(
        Scaffold(
          body: FlagSelector(flag: Flag.br, onChange: (_) {}),
        ),
      );

      expect(find.byType(Image), findsNWidgets(2));
    });

    testWidgets('Can select BR', (tester) async {
      final stub = StubWrapperMock();
      await tester.pumpApp(
        Scaffold(
          body: FlagSelector(flag: Flag.us, onChange: stub.onChange),
        ),
      );

      await tester.tap(find.byKey(const Key('br_option')));
      verify(() => stub.onChange(Flag.br)).called(1);
    });

    testWidgets('Can select US', (tester) async {
      final stub = StubWrapperMock();
      await tester.pumpApp(
        Scaffold(
          body: FlagSelector(flag: Flag.br, onChange: stub.onChange),
        ),
      );

      await tester.tap(find.byKey(const Key('us_option')));
      verify(() => stub.onChange(Flag.us)).called(1);
    });
  });
}
