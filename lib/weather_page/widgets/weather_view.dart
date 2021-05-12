import 'package:bit_weather/models/settings.dart';
import 'package:bit_weather/weather_page/widgets/weather_type_label.dart';
import 'package:bit_weather/widgets/temperature.dart';
import 'package:flutter/material.dart';

import 'package:bit_weather/models/weather_location.dart';
import 'package:bit_weather/l10n/l10n.dart';

class WeatherView extends StatelessWidget {
  WeatherView({
    required this.information,
    required this.unitType,
  });

  final UnitType unitType;

  final WeatherLocation information;
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final localizations = MaterialLocalizations.of(context);

    final formattedDate = localizations.formatShortDate(information.updatedAt);
    final formattedTime = localizations.formatTimeOfDay(
      TimeOfDay.fromDateTime(
        information.updatedAt,
      ),
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('${l10n.city}: ${information.location.title}'),
        WeatherTypeLabel(type: information.weather.weatherState),
        Temperature(
          celsius: information.weather.currentTemp,
          unitType: unitType,
          current: true,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${l10n.minTemp}: '),
            Temperature(
              celsius: information.weather.minTemp,
              unitType: unitType,
            ),
            const Text(' / '),
            Text('${l10n.maxTemp}: '),
            Temperature(
              celsius: information.weather.maxTemp,
              unitType: unitType,
            ),
          ],
        ),
        Text('${l10n.updatedAt}: $formattedDate - $formattedTime'),
      ],
    );
  }
}
