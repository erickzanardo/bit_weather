import 'package:bit_weather/models/settings.dart';
import 'package:bit_weather/models/weather_location.dart';

class Cache {
  Cache({
    this.settings,
    this.weatherLocation,
  });

  final Settings? settings;
  final WeatherLocation? weatherLocation;
}
