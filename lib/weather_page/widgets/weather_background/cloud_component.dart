import 'package:bit_weather/weather_page/widgets/weather_background/weather_background.dart';
import 'package:flame/components.dart';
import 'package:bit_weather/models/weather.dart';

class CloudComponent extends SpriteComponent
    with HasGameRef<WeatherBackgroundGame> {

  CloudComponent({
    required this.weatherType,
  });

  static const _cloudSpriteHeight = 300.0;
  static const _cloudSpeed = 10;

  final WeatherType weatherType;

  @override
  Future<void> onLoad() async {
    switch(weatherType) {
      case WeatherType.sleet:
      case WeatherType.hail:
      case WeatherType.lightRain:
      case WeatherType.lightCloud:
      case WeatherType.showers:
        sprite = await gameRef.loadSprite('sprites/light_clouded.png');
        break;
      case WeatherType.thunderstorm:
      case WeatherType.snow:
      case WeatherType.heavyRain:
      case WeatherType.heavyCloud:
        sprite = await gameRef.loadSprite('sprites/heavy_clouded.png');
        break;
      case WeatherType.clear:
        sprite = await gameRef.loadSprite('sprites/clear_clouds.png');
        break;
    }

    final rate = _cloudSpriteHeight / sprite!.image.height;

    size = Vector2(
        sprite!.image.width * rate,
        _cloudSpriteHeight,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    x -= _cloudSpeed * dt;

    if (size.x - x.abs() <= 0 ) {
      x = gameRef.size.x;
    }
  }
}
