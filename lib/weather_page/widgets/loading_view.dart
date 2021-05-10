import 'package:flutter/material.dart';
import 'package:bit_weather/l10n/l10n.dart';

class LoadingView extends StatelessWidget {
  const LoadingView();

  @override
  Widget build(BuildContext context) {
    return Text(context.l10n.loadingView);
  }
}
