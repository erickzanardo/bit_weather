import 'dart:async';
import 'dart:developer';

import 'package:bit_weather/apis/weather_api.dart';
import 'package:bit_weather/repositories/weather_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:bloc/bloc.dart';
import 'package:bit_weather/app/app.dart';
import 'package:bit_weather/app/app_bloc_observer.dart';
import 'package:bit_weather/env.dart';

void main() {
  BitWeatherEnv.apiHost = 'https://www.metaweather.com/api/';
  Bloc.observer = AppBlocObserver();
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  final weatherClient = WeatherApi(dio: Dio());
  final weatherRepository = WeatherRepository(client: weatherClient);

  runZonedGuarded(
    () => runApp(App(repository: weatherRepository)),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
