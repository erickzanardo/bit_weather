import 'dart:convert';

import 'package:bit_weather/apis/weather_api.dart';
import 'package:bit_weather/env.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:test/test.dart';


void main() {
  group('WeatherApi', () {
    BitWeatherEnv.apiHost = 'https://host.com/';
    group('searchLocation', () {
      test('returns a Location', () async {
        final json = '''
            [
              {
                "title": "London",
                "location_type": "City",
                "woeid": 44418,
                "latt_long": "51.506321,-0.12714"
              }
            ]
        ''';
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
  });
}
