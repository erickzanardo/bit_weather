import 'package:bit_weather/models/settings.dart';
import 'package:flutter/material.dart';

class Temperature extends StatelessWidget {
  Temperature({
    required this.celsius,
    required this.unitType,
    this.current = false,
  });

  final double celsius;
  final UnitType unitType;
  final bool current;

  @override
  Widget build(BuildContext context) {
    final textThemes = Theme.of(context).textTheme;
    return Text(
      '${_formattedTemperature()}${_symbol()}°',
      style: current ? textThemes.headline3 : textThemes.bodyText1,
    );
  }

  int _formattedTemperature() =>
      unitType == UnitType.fahrenheit ? _toFahrenheit() : celsius.round();
  int _toFahrenheit() => ((celsius * 9 / 5) + 32).round();

  String _symbol() => unitType == UnitType.celsius ? 'C' : 'F';
}
