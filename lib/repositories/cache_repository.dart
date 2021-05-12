import 'dart:convert';
import 'dart:developer';

import 'package:bit_weather/models/cache.dart';
import 'package:bit_weather/models/weather_location.dart';
import 'package:bit_weather/models/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kCacheKeyWeather = 'bit_weather_cache_weather';
const kCacheKeySettings = 'bit_weather_cache_settings';

class CacheRepository {
  // No need to await for the cache writting as
  // they are only loaded on the app startup and they
  // aren't critical if their writting fails

  void cacheWeather(WeatherLocation weather) {
    _cacheJson(weather.toJson(), kCacheKeyWeather);
  }

  void cacheSettings(Settings settings) {
    _cacheJson(settings.toJson(), kCacheKeySettings);
  }

  Future<void> _cacheJson(Map<String, dynamic> json, String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, jsonEncode(json));
  }

  Map<String, dynamic>? _loadJson(SharedPreferences prefs, String key) {
    final cachedRaw = prefs.getString(key);

    if (cachedRaw != null) {
      try {
        return jsonDecode(cachedRaw);
      } catch (_) {
        log('Invalid cache format');
      }
    }
    return null;
  }

  Future<Cache> load() async {
    final prefs = await SharedPreferences.getInstance();

    return Cache(
      weatherLocation: _loadWeather(prefs),
      settings: _loadSettings(prefs),
    );
  }

  WeatherLocation? _loadWeather(SharedPreferences prefs) {
    final cachedJson = _loadJson(prefs, kCacheKeyWeather);

    if (cachedJson == null) {
      return null;
    }

    return WeatherLocation.fromJson(cachedJson);
  }

  Settings? _loadSettings(SharedPreferences prefs) {
    final cachedJson = _loadJson(prefs, kCacheKeySettings);

    if (cachedJson == null) {
      return null;
    }

    return Settings.fromJson(cachedJson);
  }
}
