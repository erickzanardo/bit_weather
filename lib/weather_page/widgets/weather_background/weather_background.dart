import 'package:bit_weather/weather_page/widgets/weather_background/cloud_component.dart';
import 'package:bit_weather/weather_page/widgets/weather_background/lightning_creator.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'package:bit_weather/models/weather.dart';

class WeatherBackground extends StatelessWidget {
  WeatherBackground({
    required this.weatherType,
  });

  final WeatherType weatherType;

  @override
  Widget build(BuildContext context) {
    return GameWidget(game: WeatherBackgroundGame(weatherType));
  }
}

class WeatherBackgroundGame extends BaseGame {
  WeatherBackgroundGame(this.weatherType);

  final WeatherType weatherType;

  @override
  Future<void> onLoad() async {
    final backgroundCity = await loadSprite('sprites/city.png');
    await _addBackCity(backgroundCity);

    await add(CloudComponent(weatherType: weatherType));
    await _addForegroundEffect();
    await _addAfterEffect();
  }

  Future<void> _addBackCity(Sprite sprite) async {
    final rate = size.x / sprite.image.width;
    final spritesize = Vector2(
      size.x,
      sprite.image.height * rate,
    );
    await add(
      SpriteComponent(
        sprite: sprite,
        size: spritesize,
      ),
    );
  }

  Future<void> _addForegroundEffect() async {
    switch (weatherType) {
      case WeatherType.snow:
      case WeatherType.sleet:
      case WeatherType.hail:
        // TODO Implement this art on a follow up
        break;
      case WeatherType.thunderstorm:
      case WeatherType.heavyRain:
      case WeatherType.lightRain:
      case WeatherType.showers:
        final isFastRain = weatherType == WeatherType.heavyRain ||
            weatherType == WeatherType.thunderstorm;

        final rainAnimation = await loadSpriteAnimation(
          'sprites/rain.png',
          SpriteAnimationData.sequenced(
            amount: 4,
            stepTime: isFastRain ? 0.1 : 0.5,
            textureSize: Vector2(80, 160),
          ),
        );
        await add(
          SpriteAnimationComponent(
            animation: rainAnimation,
            size: size,
            position: Vector2.zero(),
          ),
        );
        break;
      default:
      // No effect appliable
    }
  }

  Future<void> _addAfterEffect() async {
    switch (weatherType) {
      case WeatherType.thunderstorm:
        await add(LightningCreator());
        break;
      default:
      // No effect appliable
    }
  }

  @override
  Color backgroundColor() {
    switch (weatherType) {
      case WeatherType.snow:
      case WeatherType.sleet:
      case WeatherType.hail:
        return const Color(0xFF03CFFC);
      case WeatherType.thunderstorm:
      case WeatherType.heavyRain:
      case WeatherType.heavyCloud:
        return const Color(0xFF5C686B);
      case WeatherType.lightRain:
      case WeatherType.showers:
      case WeatherType.lightCloud:
        return const Color(0xFF8FADB5);
      case WeatherType.clear:
        return const Color(0xFF96DFF2);
    }
  }
}
