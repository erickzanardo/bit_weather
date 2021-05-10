import 'package:flutter/material.dart';
import 'package:bit_weather/l10n/l10n.dart';

class NotFoundView extends StatelessWidget {
  const NotFoundView();

  @override
  Widget build(BuildContext context) {
    return Text(context.l10n.locationNotFoundView);
  }
}
