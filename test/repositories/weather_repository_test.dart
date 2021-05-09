import 'package:bit_weather/models/location.dart';
import 'package:bit_weather/models/weather.dart';
import 'package:bit_weather/models/weather_location.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:bit_weather/repositories/weather_repository.dart';
import 'package:bit_weather/apis/weather_api.dart';

class WeatherApiMock extends Mock implements WeatherApi {}

void main() {
  group('WeatherRepository', () {
    group('fetchWeather', () {
      test('returns the weather for the city', () async {
        final apiMock = WeatherApiMock();
        when(() => apiMock.searchLocation('Rome')).thenAnswer((_) async => 
          Location(
            title: 'Rome',
            woeid: 10,
          ),
        );
        when(() => apiMock.searchWeather(10)).thenAnswer((_) async => 
          WeatherLocation(
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
          ),
        );
        final repository = WeatherRepository(client: apiMock);

        final weatherLocation = await repository.fetchWeather('Rome');

        expect(weatherLocation?.location.title, 'Rome');

        expect(weatherLocation?.weather.id, 1);
      });

      test('returns null if the location isn\'t found', () async {
        final apiMock = WeatherApiMock();
        when(() => apiMock.searchLocation('Rome'))
            .thenAnswer((_) async => null);

        final repository = WeatherRepository(client: apiMock);

        final weatherLocation = await repository.fetchWeather('Rome');

        expect(weatherLocation, null);
      });

      test('returns null if the weather isn\'t found', () async {
        final apiMock = WeatherApiMock();
        when(() => apiMock.searchLocation('Rome')).thenAnswer((_) async => 
          Location(
            title: 'Rome',
            woeid: 10,
          ),
        );
        when(() => apiMock.searchWeather(10))
            .thenAnswer((_) async => null);

        final repository = WeatherRepository(client: apiMock);

        final weatherLocation = await repository.fetchWeather('Rome');

        expect(weatherLocation, null);
      });
    });
  });
}
