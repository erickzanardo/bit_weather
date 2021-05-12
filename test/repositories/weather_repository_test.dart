import 'dart:convert';

import 'package:bit_weather/models/location.dart';
import 'package:bit_weather/models/settings.dart';
import 'package:bit_weather/models/weather.dart';
import 'package:bit_weather/models/weather_location.dart';
import 'package:bit_weather/repositories/cache_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

void main() {
  final weatherLocation = WeatherLocation(
    updatedAt: DateTime.now(),
    location: Location(
      title: 'Rome',
      woeid: 10,
    ),
    weather: Weather(
      id: 1,
      minTemp: 10,
      maxTemp: 20,
      currentTemp: 15,
      windSpeed: 10,
      weatherState: WeatherType.clear,
    ),
  );

  final settings = Settings(
    flag: Flag.br,
    units: UnitType.celsius,
  );

  group('CacheRepository', () {
    group('load', () {
      test('returns the caches info', () async {
        SharedPreferences.setMockInitialValues({
          kCacheKeyWeather: jsonEncode(weatherLocation.toJson()),
          kCacheKeySettings: jsonEncode(settings.toJson()),
        });

        final cacheRepository = CacheRepository();
        final cache = await cacheRepository.load();

        expect(cache.settings, settings);
        expect(cache.weatherLocation, weatherLocation);
      });

      test('returns null info if not present', () async {
        SharedPreferences.setMockInitialValues({});

        final cacheRepository = CacheRepository();
        final cache = await cacheRepository.load();

        expect(cache.settings, null);
        expect(cache.weatherLocation, null);
      });

      test('returns null info info is not valid', () async {
        SharedPreferences.setMockInitialValues({
          kCacheKeySettings: 'I am not a json',
          kCacheKeyWeather: 'I am not a json',
        });

        final cacheRepository = CacheRepository();
        final cache = await cacheRepository.load();

        expect(cache.settings, null);
        expect(cache.weatherLocation, null);
      });

      test('can cache information', () async {
        final cacheRepository = CacheRepository()
          ..cacheWeather(weatherLocation)
          ..cacheSettings(settings);

        final cache = await cacheRepository.load();
        expect(cache.settings, settings);
        expect(cache.weatherLocation, weatherLocation);
      });
    });
  });
}
