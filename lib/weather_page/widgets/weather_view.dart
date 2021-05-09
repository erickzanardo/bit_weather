import 'package:bit_weather/models/weather_location.dart';
import 'package:flutter/material.dart';

class WeatherView extends StatelessWidget {
  WeatherView({
    required this.information,
  });

  final WeatherLocation information;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(information.location.title),
        Text('${information.weather.currentTemp}'),
      ],
    );
  }
}
