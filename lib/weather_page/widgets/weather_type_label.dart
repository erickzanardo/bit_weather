import 'package:flutter/material.dart';
import 'package:bit_weather/models/weather.dart';
import 'package:bit_weather/l10n/l10n.dart';

class WeatherTypeLabel extends StatelessWidget {
  WeatherTypeLabel({
    required this.type,
  });

  final WeatherType type;

  @override
  Widget build(BuildContext context) {
    return Text(_mapType(context));
  }

  String _mapType(BuildContext context) {
    final l10n = context.l10n;
    switch (type) {
      case WeatherType.snow:
        return l10n.snowWeather;
      case WeatherType.sleet:
        return l10n.sleetWeather;
      case WeatherType.hail:
        return l10n.hailWeather;
      case WeatherType.thunderstorm:
        return l10n.thunderstormWeather;
      case WeatherType.heavyRain:
        return l10n.heavyRainWeather;
      case WeatherType.lightRain:
        return l10n.lightRainWeather;
      case WeatherType.showers:
        return l10n.showersWeather;
      case WeatherType.heavyCloud:
        return l10n.heavyCloudWeather;
      case WeatherType.lightCloud:
        return l10n.lightCloudWeather;
      case WeatherType.clear:
        return l10n.clearWeather;
    }
  }
}
