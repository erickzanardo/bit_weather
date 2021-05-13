import 'dart:math';

import 'package:bit_weather/weather_page/widgets/weather_background/weather_background.dart';
import 'package:flame/components.dart';

class LightningCreator extends Component
with HasGameRef<WeatherBackgroundGame> {
  late final Timer _timer;
  final random = Random();

  @override
  Future<void>? onLoad() async {
    _timer = Timer(2, callback: _create, repeat: true)
        ..start();
  }

  @override
  void update(double dt) {
    super.update(dt);
    _timer.update(dt);
  }

  Future<SpriteAnimation> _createAnimation() async {
    return await gameRef.loadSpriteAnimation(
       'sprites/lightning.png',
        SpriteAnimationData.sequenced(
            amount: 5,
            stepTime: 0.1,
            textureSize: Vector2(80, 160),
            loop: false,
        ),
    );
  }

  void _create() async {
    // 40% of chance of a new lightning
    if (random.nextDouble() <= 0.4) {
      final lightningAnimation = await _createAnimation();
      await gameRef.add(
          SpriteAnimationComponent(
              animation: lightningAnimation,
              size: gameRef.size,
              removeOnFinish: true,
              position: Vector2(
                  (100 * random.nextDouble()) * (random.nextBool() ? 1 : -1),
                  10 * random.nextDouble(),
              ),
          )..renderFlipX = random.nextBool(),
      );
    }
  }
}
