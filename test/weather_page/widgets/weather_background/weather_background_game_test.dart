import 'package:bit_weather/weather_page/widgets/weather_background/cloud_component.dart';
import 'package:bit_weather/weather_page/widgets/weather_background/lightning_creator.dart';
import 'package:bit_weather/weather_page/widgets/weather_background/weather_background.dart';
import 'package:bit_weather/models/weather.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter_test/flutter_test.dart';

Future<WeatherBackgroundGame> _createGame(WeatherType type) async {
  final game = WeatherBackgroundGame(type)..onResize(Vector2.all(100));

  await game.onLoad();

  // components are really added on the next game tick
  game.update(0);
  return game;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('WeatherBackgroundGame - Game', () {
    test('loads the correct default components', () async {
      final game = await _createGame(WeatherType.clear);

      expect(game.components.length, 2);
      expect(game.components, contains(isA<SpriteComponent>()));
      expect(game.components, contains(isA<CloudComponent>()));
    });

    group('When the weather type is a light rain type', () {
      final rainTypes = [
        WeatherType.lightRain,
        WeatherType.showers,
      ];

      for (var type in rainTypes) {
        test('It adds an rain animation when is $type', () async {
          final game = await _createGame(type);

          expect(game.components, contains(isA<SpriteAnimationComponent>()));
        });

        test('It is a slow animation when is $type', () async {
          final game = await _createGame(type);

          final component = game.components.firstWhere(
            (c) => c is SpriteAnimationComponent,
          ) as SpriteAnimationComponent;

          expect(component.animation?.currentFrame.stepTime, 0.5);
        });
      }
    });

    group('When the weather type is a heavy rain type', () {
      final rainTypes = [
        WeatherType.thunderstorm,
        WeatherType.heavyRain,
      ];

      for (var type in rainTypes) {
        test('It adds an rain animation when is $type', () async {
          final game = await _createGame(type);

          expect(game.components, contains(isA<SpriteAnimationComponent>()));
        });

        test('It is a fast animation when is $type', () async {
          final game = await _createGame(type);

          final component = game.components.firstWhere(
            (c) => c is SpriteAnimationComponent,
          ) as SpriteAnimationComponent;

          expect(component.animation?.currentFrame.stepTime, 0.1);
        });
      }
    });

    group('when the weather is a thunderstorm', () {
      test('It adds a LightningCreator', () async {
        final game = await _createGame(WeatherType.thunderstorm);

        expect(game.components, contains(isA<LightningCreator>()));
      });
    });
  });
}
