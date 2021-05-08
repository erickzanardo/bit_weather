import 'package:bit_weather/weather_page/bloc/weather_bloc.dart';
import 'package:bit_weather/weather_page/bloc/weather_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              return Container(
                  child: const Text('Hello'),
              );
            },
        ),
    );
  }
}
