import 'dart:developer';

import 'package:bit_weather/repositories/cache_repository.dart';
import 'package:bit_weather/repositories/weather_repository.dart';
import 'package:bit_weather/weather_page/bloc/weather_event.dart';
import 'package:bit_weather/weather_page/bloc/weather_state.dart';
import 'package:bit_weather/models/weather_location.dart';
import 'package:bloc/bloc.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc({
    required this.weatherRepository,
    required this.cacheRepository,
    WeatherLocation? initialWeather,
  }) : super(
          initialWeather != null
              ? WeatherLoaded(weather: initialWeather)
              : WeatherEmpty(),
        );

  final WeatherRepository weatherRepository;
  final CacheRepository cacheRepository;

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is WeatherSearch) {
      yield* _mapWeatherSearch(event);
    } else if (event is WeatherRefresh) {
      yield* _mapWeatherRefresh(event);
    }
  }

  Stream<WeatherState> _mapWeatherSearch(WeatherSearch event) async* {
    yield WeatherLoading();
    try {
      final response = await weatherRepository.fetchWeather(event.cityName);
      if (response != null) {
        yield* _emitWeatherLoaded(response);
      } else {
        yield WeatherNotFound();
      }
    } catch (e) {
      log('Error loading weather: $e');
      yield WeatherLoadingFailed();
    }
  }

  Stream<WeatherState> _mapWeatherRefresh(WeatherRefresh event) async* {
    try {
      final response = await weatherRepository.fetchWeather(event.cityName);
      if (response != null) {
        yield* _emitWeatherLoaded(response);
      }
    } catch (e) {
      log('Error refreshing weather: $e');
    }
  }

  Stream<WeatherState> _emitWeatherLoaded(WeatherLocation weather) async* {
    yield WeatherLoaded(weather: weather);
    cacheRepository.cacheWeather(weather);
  }
}
