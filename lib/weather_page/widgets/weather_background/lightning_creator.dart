import 'dart:math';

import 'package:bit_weather/weather_page/widgets/weather_background/weather_background.dart';
import 'package:flame/components.dart';

class LightningCreatorRNG {
  final _random = Random();

  bool createLightning() {
    // 40% of chance of a new lightning
    return _random.nextDouble() <= 0.4;
  }

  double randomX() {
    return (100 * _random.nextDouble()) * (_random.nextBool() ? 1 : -1);
  }

  double randomY() {
    return 10 * _random.nextDouble();
  }

  bool randomFlip() => _random.nextBool();
}

class LightningCreator extends Component
    with HasGameRef<WeatherBackgroundGame> {
  LightningCreator({
    LightningCreatorRNG? rng,
  }) : _rng = rng ?? LightningCreatorRNG();

  final LightningCreatorRNG _rng;
  late final Timer _timer;

  @override
  Future<void>? onLoad() async {
    _timer = Timer(2, callback: _create, repeat: true)..start();
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
    if (_rng.createLightning()) {
      final lightningAnimation = await _createAnimation();
      await gameRef.add(
        SpriteAnimationComponent(
          animation: lightningAnimation,
          size: gameRef.size,
          removeOnFinish: true,
          position: Vector2(
            _rng.randomX(),
            _rng.randomY(),
          ),
        )..renderFlipX = _rng.randomFlip(),
      );
    }
  }
}
