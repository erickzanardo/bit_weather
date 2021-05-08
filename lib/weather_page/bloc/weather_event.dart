import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class WeatherSearch extends WeatherEvent {
  const WeatherSearch(this.cityName);

  final String cityName;

  @override
  List<Object?> get props => [cityName];
}
