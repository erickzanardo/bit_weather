import 'package:bit_weather/models/weather_location.dart';
import 'package:equatable/equatable.dart';

abstract class WeatherState extends Equatable {
  WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherEmpty extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  WeatherLoaded({required this.weather});

  final WeatherLocation weather;

  @override
  List<Object> get props => [weather];
}

class WeatherNotFound extends WeatherState {}

class WeatherLoadingFailed extends WeatherState {}
