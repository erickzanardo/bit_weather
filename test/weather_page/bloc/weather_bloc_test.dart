import 'package:bit_weather/models/location.dart';
import 'package:bit_weather/models/weather.dart';
import 'package:bit_weather/models/weather_location.dart';
import 'package:bit_weather/weather_page/bloc/weather_bloc.dart';
import 'package:bit_weather/weather_page/bloc/weather_event.dart';
import 'package:bit_weather/weather_page/bloc/weather_state.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

import 'package:bit_weather/repositories/weather_repository.dart';

class WeatherRepositoryMock extends Mock implements WeatherRepository {}

void main() {
  final weatherLocation = WeatherLocation(
    updatedAt: DateTime.now(),
    location: Location(
      title: 'Treviso',
      woeid: 20,
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
  group('WeatherPage - WeatherBloc', () {
    group('WeatherSearch', () {
      blocTest<WeatherBloc, WeatherState>(
        'Searchs a city and emits WeatherLoaded',
        build: () {
          final repository = WeatherRepositoryMock();
          when(() => repository.fetchWeather('Treviso')).thenAnswer(
            (_) async {
              return weatherLocation;
            },
          );

          return WeatherBloc(repository: repository);
        },
        act: (bloc) => bloc.add(const WeatherSearch('Treviso')),
        expect: () => [
          WeatherLoading(),
          WeatherLoaded(weather: weatherLocation),
        ],
      );

      blocTest<WeatherBloc, WeatherState>(
        'Emits WeatherNotFound when the city can\'t be found',
        build: () {
          final repository = WeatherRepositoryMock();
          when(() => repository.fetchWeather('Pallet')).thenAnswer(
            (_) async => null,
          );

          return WeatherBloc(repository: repository);
        },
        act: (bloc) => bloc.add(const WeatherSearch('Pallet')),
        expect: () => [
          WeatherLoading(),
          WeatherNotFound(),
        ],
      );

      blocTest<WeatherBloc, WeatherState>(
        'Emits WeatherLoadingFailed when the repository throws and error',
        build: () {
          final repository = WeatherRepositoryMock();
          when(() => repository.fetchWeather('Pallet'))
              .thenThrow('Some problems');

          return WeatherBloc(repository: repository);
        },
        act: (bloc) => bloc.add(const WeatherSearch('Pallet')),
        expect: () => [
          WeatherLoading(),
          WeatherLoadingFailed(),
        ],
      );
    });

    group('WeatherRefres', () {
      blocTest<WeatherBloc, WeatherState>(
        'Refreshs and emits Weather loaded',
        build: () {
          final repository = WeatherRepositoryMock();
          when(() => repository.fetchWeather('Treviso')).thenAnswer(
            (_) async {
              return weatherLocation;
            },
          );

          return WeatherBloc(repository: repository);
        },
        act: (bloc) => bloc.add(const WeatherRefresh('Treviso')),
        expect: () => [
          WeatherLoaded(weather: weatherLocation),
        ],
      );

      blocTest<WeatherBloc, WeatherState>(
        'emits nothing if for some reason returns null',
        build: () {
          final repository = WeatherRepositoryMock();
          when(() => repository.fetchWeather('Treviso')).thenAnswer(
            (_) async => null,
          );

          return WeatherBloc(repository: repository);
        },
        act: (bloc) => bloc.add(const WeatherRefresh('Treviso')),
        expect: () => [],
      );

      blocTest<WeatherBloc, WeatherState>(
        'emits nothing if for some reason an error occur',
        build: () {
          final repository = WeatherRepositoryMock();
          when(() => repository.fetchWeather('Treviso'))
              .thenThrow('Some error');

          return WeatherBloc(repository: repository);
        },
        act: (bloc) => bloc.add(const WeatherRefresh('Treviso')),
        expect: () => [],
      );
    });
  });
}
