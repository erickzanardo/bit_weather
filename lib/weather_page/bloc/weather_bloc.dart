import 'dart:developer';

import 'package:bit_weather/repositories/weather_repository.dart';
import 'package:bit_weather/weather_page/bloc/weather_event.dart';
import 'package:bit_weather/weather_page/bloc/weather_state.dart';
import 'package:bloc/bloc.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc({required this.repository}) : super(WeatherEmpty());

  final WeatherRepository repository;

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is WeatherSearch) {
      yield* _mapWeatherSearch(event);
    }
  }

  Stream<WeatherState> _mapWeatherSearch(WeatherSearch event) async* {
    yield WeatherLoading();
    try {
      final response = await repository.fetchWeather(event.cityName);
      if (response != null) {
        yield WeatherLoaded(weather: response);
      } else {
        yield WeatherNotFound();
      }
    } catch (e) {
      log('Error loading weather: $e');
      yield WeatherLoadingFailed();
    }
  }
}
