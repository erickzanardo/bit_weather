import 'dart:async';
import 'dart:developer';

import 'package:bit_weather/apis/weather_api.dart';
import 'package:bit_weather/repositories/cache_repository.dart';
import 'package:bit_weather/repositories/weather_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:bloc/bloc.dart';
import 'package:bit_weather/app/app.dart';
import 'package:bit_weather/app/app_bloc_observer.dart';
import 'package:bit_weather/env.dart';

void main() async {
  BitWeatherEnv.apiHost = 'https://www.metaweather.com/api/';
  Bloc.observer = AppBlocObserver();
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  final weatherClient = WeatherApi(dio: Dio());
  final weatherRepository = WeatherRepository(client: weatherClient);

  final cacheRepository = CacheRepository();

  runZonedGuarded(
    () {
      return runApp(
        App(
          weatherRepository: weatherRepository,
          cacheRepository: cacheRepository,
        ),
      );
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
