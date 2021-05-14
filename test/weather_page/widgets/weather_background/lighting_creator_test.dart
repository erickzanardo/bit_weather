import 'dart:async';

import 'package:bit_weather/weather_page/widgets/weather_background/lightning_creator.dart';
import 'package:flame/components.dart';
import 'package:flame/widgets.dart';
import 'package:test/test.dart';
import 'package:bit_weather/weather_page/widgets/weather_background/weather_background.dart';
import 'package:mocktail/mocktail.dart';

class GameMock extends Mock implements WeatherBackgroundGame {}

class SpriteAnimationMock extends Mock implements SpriteAnimation {}

class LightningCreatorRNGMock extends Mock implements LightningCreatorRNG {}

GameMock _createGameMock(
  Completer<void> animationCompleter,
  Completer<void> addCompleter,
) {
  final gameMock = GameMock();

  when(() => gameMock.loadSpriteAnimation(any(), any())).thenAnswer((_) async {
    animationCompleter.complete();

    return SpriteAnimationMock();
  });

  when(() => gameMock.size).thenReturn(Vector2.all(100));
  when(() => gameMock.add(any())).thenAnswer((_) async {
    addCompleter.complete();
  });

  return gameMock;
}

void main() {
  setUpAll(() {
    registerFallbackValue(
      SpriteAnimationData.sequenced(
        amount: 1,
        stepTime: 1,
        textureSize: Vector2.all(10),
      ),
    );
    registerFallbackValue(SpriteAnimationComponent());
  });
  group('WeatherBackgroundGame - LightningCreator', () {
    test(
      'creates a lighting when the time hits 2 secs and rng is true',
      () async {
        final rngMock = LightningCreatorRNGMock();
        when(rngMock.randomX).thenReturn(10);
        when(rngMock.randomY).thenReturn(10);
        when(rngMock.randomFlip).thenReturn(true);
        when(rngMock.createLightning).thenReturn(true);

        final animationCompleter = Completer<void>();
        final addCompleter = Completer<void>();

        final component = LightningCreator(rng: rngMock)
          ..gameRef = _createGameMock(animationCompleter, addCompleter);

        await component.onLoad();
        component.update(2);

        await Future.wait([
          animationCompleter.future,
          addCompleter.future,
        ]);

        final captured = verify(
          () => component.gameRef.add(captureAny()),
        ).captured;

        final animationComponent = captured.first as SpriteAnimationComponent;
        expect(animationComponent.animation, isA<SpriteAnimationMock>());
        expect(animationComponent.position, Vector2.all(10));
        expect(animationComponent.renderFlipX, true);
      },
    );

    test(
      'does not create a lighting when the time hits 2 secs but rng is false',
      () async {
        final rngMock = LightningCreatorRNGMock();
        when(rngMock.createLightning).thenReturn(false);

        final animationCompleter = Completer<void>();
        final addCompleter = Completer<void>();

        final component = LightningCreator(rng: rngMock)
          ..gameRef = _createGameMock(animationCompleter, addCompleter);

        await component.onLoad();
        component.update(2);

        verifyNever(() => component.gameRef.add(captureAny()));
      },
    );
  });
  group('WeatherBackgroundGame - LightningCreatorRNG', () {
    test('Generates values which makes sense', () {
      final rng = LightningCreatorRNG();
      expect(rng.createLightning(), isA<bool>());
      expect(rng.randomFlip(), isA<bool>());

      final x = rng.randomX();
      expect((x > 0 && x <= 100) || (x < 0 && x >= -100), true);

      final y = rng.randomY();
      expect(y >= 0 && y <= 10, true);
    });
  });
}
