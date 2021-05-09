import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bit_weather/weather_page/widgets/location_selection.dart';
import 'package:bit_weather/weather_page/widgets/weather_view.dart';
import 'package:bit_weather/weather_page/bloc/weather_bloc.dart';
import 'package:bit_weather/weather_page/bloc/weather_state.dart';
import 'package:bit_weather/weather_page/widgets/empty_view.dart';
import 'package:bit_weather/weather_page/widgets/error_view.dart';
import 'package:bit_weather/weather_page/widgets/not_found_view.dart';
import 'package:bit_weather/weather_page/widgets/loading_view.dart';
import 'package:bit_weather/weather_page/bloc/weather_event.dart';

class WeatherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        key: const Key('add_city_button'),
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) {
              return LocationSelection(
                onSelect: (String city) {
                  BlocProvider.of<WeatherBloc>(context).add(
                    WeatherSearch(city),
                  );
                },
              );
            },
          );
        },
      ),
      body: Center(
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoaded) {
              return WeatherView(information: state.weather);
            }

            if (state is WeatherLoading) {
              return const LoadingView();
            }

            if (state is WeatherLoadingFailed) {
              return const ErrorView();
            }

            if (state is WeatherNotFound) {
              return const NotFoundView();
            }

            return const EmptyView();
          },
        ),
      ),
    );
  }
}
