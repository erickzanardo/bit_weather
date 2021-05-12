import 'dart:async';

import 'package:bit_weather/models/cache.dart';
import 'package:bit_weather/models/location.dart';
import 'package:bit_weather/models/settings.dart';
import 'package:bit_weather/models/weather.dart';
import 'package:bit_weather/models/weather_location.dart';
import 'package:bit_weather/repositories/cache_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:bit_weather/repositories/weather_repository.dart';
import 'package:bit_weather/app/app.dart';

import '../helpers/helpers.dart';
import 'app_page_object.dart';

class WeatherRepositoryMock extends Mock implements WeatherRepository {}

class CacheRepositoryMock extends Mock implements CacheRepository {}

CacheRepository _defaultCacheRepository() {
  final cacheRepository = CacheRepositoryMock();
  when(cacheRepository.load)
      .thenAnswer((_) async => Cache(settings: null, weatherLocation: null));

  return cacheRepository;
}

App _createApp({
  required WeatherRepository weatherRepository,
  CacheRepository? cacheRepository,
}) {
  return App(
    weatherRepository: weatherRepository,
    cacheRepository: cacheRepository ?? _defaultCacheRepository(),
  );
}

void main() {
  final createWeatherLocation = ({
    String cityName = 'Rome',
  }) {
    return WeatherLocation(
      updatedAt: DateTime.now(),
      location: Location(
        title: cityName,
        woeid: 10,
      ),
      weather: Weather(
        id: 1,
        minTemp: 10.0,
        maxTemp: 20.0,
        currentTemp: 15.0,
        windSpeed: 10,
        weatherState: WeatherType.clear,
      ),
    );
  };

  group('App', () {
    testWidgets('Renders the app correctly', (tester) async {
      await tester.pumpAndSettleApp(_createApp(
        weatherRepository: WeatherRepositoryMock(),
      ));

      expect(find.text('No location selected yet'), findsOneWidget);
    });

    testWidgets('Can open the city selection', (tester) async {
      final pageOject = AppPageObject(tester);
      await tester.pumpAndSettleApp(_createApp(
        weatherRepository: WeatherRepositoryMock(),
      ));

      await pageOject.openCitySelection();
      expect(find.text('Search'), findsOneWidget);
    });

    testWidgets('Search and find a city weather', (tester) async {
      final repositoryMock = WeatherRepositoryMock();

      when(() => repositoryMock.fetchWeather('Rome')).thenAnswer(
        (_) async => createWeatherLocation(),
      );

      final pageOject = AppPageObject(tester);
      await tester.pumpAndSettleApp(_createApp(
        weatherRepository: repositoryMock,
      ));

      await pageOject.openCitySelection();
      await pageOject.selectCity('Rome');

      expect(find.text('City: Rome'), findsOneWidget);
      expect(find.text('15C°'), findsOneWidget);
    });

    testWidgets('Shows a loading message while searching', (tester) async {
      final weatherLocation = createWeatherLocation();

      final repositoryMock = WeatherRepositoryMock();

      final requestCompleter = Completer<WeatherLocation>();

      when(() => repositoryMock.fetchWeather('Rome')).thenAnswer(
        (_) async => requestCompleter.future,
      );

      final pageOject = AppPageObject(tester);
      await tester.pumpAndSettleApp(_createApp(
        weatherRepository: repositoryMock,
      ));

      await pageOject.openCitySelection();
      await pageOject.selectCity('Rome');

      expect(find.text('Searching...'), findsOneWidget);
      requestCompleter.complete(weatherLocation);
      await tester.pumpAndSettle();

      expect(find.text('City: Rome'), findsOneWidget);
      expect(find.text('15C°'), findsOneWidget);
    });

    testWidgets(
      'Shows a message when location can\'t be found',
      (tester) async {
        final repositoryMock = WeatherRepositoryMock();

        when(() => repositoryMock.fetchWeather('Rome')).thenAnswer(
          (_) async => null,
        );

        final pageOject = AppPageObject(tester);
        await tester.pumpAndSettleApp(_createApp(
          weatherRepository: repositoryMock,
        ));

        await pageOject.openCitySelection();
        await pageOject.selectCity('Rome');

        expect(find.text('City not found'), findsOneWidget);
      },
    );

    testWidgets(
      'Shows a message when an error happened while searching the location',
      (tester) async {
        final repositoryMock = WeatherRepositoryMock();

        when(() => repositoryMock.fetchWeather('Rome'))
            .thenThrow('Something wrong happened');

        final pageOject = AppPageObject(tester);
        await tester.pumpAndSettleApp(_createApp(
          weatherRepository: repositoryMock,
        ));

        await pageOject.openCitySelection();
        await pageOject.selectCity('Rome');

        expect(
          find.text('Something wrong happened, please try again'),
          findsOneWidget,
        );
      },
    );

    testWidgets('Refreshs', (tester) async {
      final repositoryMock = WeatherRepositoryMock();

      when(() => repositoryMock.fetchWeather('Rome')).thenAnswer(
        (_) async => createWeatherLocation(),
      );

      final pageOject = AppPageObject(tester);
      await tester.pumpAndSettleApp(_createApp(
        weatherRepository: repositoryMock,
      ));

      await pageOject.openCitySelection();
      await pageOject.selectCity('Rome');
      await pageOject.pullToRefresh();

      verify(() => repositoryMock.fetchWeather('Rome')).called(2);
    });

    testWidgets('Can change the units', (tester) async {
      final repositoryMock = WeatherRepositoryMock();

      when(() => repositoryMock.fetchWeather('Rome')).thenAnswer(
        (_) async => createWeatherLocation(),
      );

      final pageOject = AppPageObject(tester);
      await tester.pumpAndSettleApp(_createApp(
        weatherRepository: repositoryMock,
      ));

      await pageOject.openCitySelection();
      await pageOject.selectCity('Rome');

      // Making sure that the search worked
      expect(find.text('City: Rome'), findsOneWidget);
      expect(find.text('15C°'), findsOneWidget);

      await pageOject.toggleUnitType();
      expect(find.text('59F°'), findsOneWidget);
    });

    testWidgets('Can change the language', (tester) async {
      final repositoryMock = WeatherRepositoryMock();

      when(() => repositoryMock.fetchWeather('Rome')).thenAnswer(
        (_) async => createWeatherLocation(),
      );

      final pageOject = AppPageObject(tester);
      await tester.pumpAndSettleApp(_createApp(
        weatherRepository: repositoryMock,
      ));

      await pageOject.openCitySelection();
      await pageOject.selectCity('Rome');

      // Making sure that the search worked
      expect(find.text('City: Rome'), findsOneWidget);
      expect(find.text('15C°'), findsOneWidget);

      await pageOject.selectLanguage(Flag.br);
      expect(find.text('Cidade: Rome'), findsOneWidget);
    });

    testWidgets('Starts the app with cached information', (tester) async {
      final cacheRepository = CacheRepositoryMock();

      when(cacheRepository.load).thenAnswer((_) async => Cache(
            weatherLocation: createWeatherLocation(cityName: 'Tokyo'),
            settings: Settings(flag: Flag.us, units: UnitType.fahrenheit),
          ));

      await tester.pumpAndSettleApp(_createApp(
        weatherRepository: WeatherRepositoryMock(),
        cacheRepository: cacheRepository,
      ));

      expect(find.text('City: Tokyo'), findsOneWidget);
      expect(find.text('59F°'), findsOneWidget);
    });
  });
}
