import 'dart:convert';

import 'package:bit_weather/apis/weather_api.dart';
import 'package:bit_weather/env.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:test/test.dart';

import './json_payloads.dart';

void main() {
  group('WeatherApi', () {
    BitWeatherEnv.apiHost = 'https://host.com/';
    group('searchLocation', () {
      test('returns a Location', () async {
        final dioAdapter = DioAdapter();
        final dio = Dio()
            ..httpClientAdapter = dioAdapter;

        final path = '${BitWeatherEnv.apiHost}location/search';
        dioAdapter.onGet(
            path,
            (request) => request.reply(
                200,
                jsonDecode(locationJson),
            ),
            queryParameters: { 'query': 'london' },
        );

        final api = WeatherApi(dio: dio);
        final location = await api.searchLocation('london');

        expect(location?.title, 'London');
        expect(location?.woeid, 44418);
      });

      test('returns null when nothing is found', () async {
        final json = '[ ]';
        final dioAdapter = DioAdapter();
        final dio = Dio()
            ..httpClientAdapter = dioAdapter;

        final path = '${BitWeatherEnv.apiHost}location/search';
        dioAdapter.onGet(
            path,
            (request) => request.reply(
                200,
                jsonDecode(json),
            ),
            queryParameters: { 'query': 'london' },
        );

        final api = WeatherApi(dio: dio);
        final location = await api.searchLocation('london');

        expect(location, null);
      });
    });

    group('searchWeather', () {
      test('returns a Weather', () async {
        final dioAdapter = DioAdapter();
        final dio = Dio()
            ..httpClientAdapter = dioAdapter;

        final path = '${BitWeatherEnv.apiHost}location/44418';
        dioAdapter.onGet(
            path,
            (request) => request.reply(
                200,
                jsonDecode(weatherJson),
            ),
        );

        final api = WeatherApi(dio: dio);
        final weather = await api.searchWeather(44418);

        expect(weather.location.title, 'London');
        expect(weather.location.woeid, 44418);

        expect(weather.weather.id, 5461767422476288);
        expect(weather.weather.minTemp, 11.215);
        expect(weather.weather.currentTemp, 19.52);
        expect(weather.weather.maxTemp, 19.21);
        expect(weather.weather.windSpeed, 9.539010474832311);
        expect(weather.weather.weatherState, 's');
      });
    });
  });
}
