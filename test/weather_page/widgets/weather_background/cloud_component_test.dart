import 'dart:ui';

import 'package:bit_weather/weather_page/widgets/weather_background/cloud_component.dart';
import 'package:bit_weather/weather_page/widgets/weather_background/weather_background.dart';
import 'package:bit_weather/models/weather.dart';
import 'package:flame/extensions.dart';
import 'package:flame/sprite.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class GameMock extends Mock implements WeatherBackgroundGame {}

class ImageMock extends Mock implements Image {}

class SpriteMock extends Mock implements Sprite {}

GameMock _createGameMock(String spritePath) {
  final gameMock = GameMock();

  final imageMock = ImageMock();
  when(() => imageMock.width).thenReturn(100);
  when(() => imageMock.height).thenReturn(50);
  final spriteMock = SpriteMock();
  when(() => spriteMock.image).thenReturn(imageMock);

  when(() => gameMock.loadSprite(spritePath))
      .thenAnswer((_) async => spriteMock);

  return gameMock;
}

void main() {
  group('WeatherBackgroundGame - CloudComponent', () {
    final lightCloudedGroup = [
      WeatherType.sleet,
      WeatherType.hail,
      WeatherType.lightRain,
      WeatherType.lightCloud,
      WeatherType.showers,
    ];

    group('SpriteLoading', () {
      group('LightCloudedGroup', () {
        for (var type in lightCloudedGroup) {
          test('when is $type loads the correct sprite', () async {
            final path = 'sprites/light_clouded.png';
            final gameMock = _createGameMock(path);

            final comp = CloudComponent(weatherType: type)..gameRef = gameMock;

            await comp.onLoad();

            verify(() => gameMock.loadSprite(path)).called(1);
            expect(comp.size, Vector2(600, 300));
          });
        }
      });

      final heavyCloudedGroup = [
        WeatherType.thunderstorm,
        WeatherType.snow,
        WeatherType.heavyRain,
        WeatherType.heavyCloud,
      ];

      group('HeavyCloudedGroup', () {
        for (var type in heavyCloudedGroup) {
          test('when is $type loads the correct sprite', () async {
            final path = 'sprites/heavy_clouded.png';
            final gameMock = _createGameMock(path);

            final comp = CloudComponent(weatherType: type)..gameRef = gameMock;

            await comp.onLoad();

            verify(() => gameMock.loadSprite(path)).called(1);
            expect(comp.size, Vector2(600, 300));
          });
        }
      });

      group('ClearCloudsGroup', () {
        test('when is clear loads the correct sprite', () async {
          final path = 'sprites/clear_clouds.png';
          final gameMock = _createGameMock(path);

          final comp = CloudComponent(weatherType: WeatherType.clear)
            ..gameRef = gameMock;

          await comp.onLoad();

          verify(() => gameMock.loadSprite(path)).called(1);
          expect(comp.size, Vector2(600, 300));
        });
      });
    });
  });

  group('Update', () {
    test('moves the cloud', () {
      final gameMock = GameMock();
      when(() => gameMock.size).thenReturn(Vector2.all(100));

      final comp = CloudComponent(weatherType: WeatherType.clear)
        ..gameRef = gameMock
        ..size = Vector2.all(20);

      // Makes sure we are athe the initial position
      expect(comp.x, 0);

      // Moved for one sec
      comp.update(1);
      expect(comp.x, -10);

      // Moved for another sec and resetted the position
      comp.update(1);
      expect(comp.x, 100);
    });
  });
}
