import 'package:flutter/material.dart';

import 'package:bit_weather/models/weather_location.dart';
import 'package:bit_weather/l10n/l10n.dart';

class WeatherView extends StatelessWidget {
  WeatherView({
    required this.information,
  });

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
        Text('${l10n.minTemp}: ${information.weather.minTemp}'),
        Text('${l10n.currentTemp}: ${information.weather.currentTemp}'),
        Text('${l10n.updatedAt}: $formattedDate - $formattedTime'),
      ],
    );
  }
}
